Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTE0L0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTE0L0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:26:14 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45004
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263285AbTE0LZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:25:46 -0400
Subject: Re: [PATCH] xirc2ps_cs irq return fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: jgarzik@pobox.com, zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527034548.4aaae353.akpm@digeo.com>
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
	 <3ED16351.7060904@pobox.com>
	 <Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
	 <1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
	 <3ED2E03E.80004@pobox.com> <20030526205548.4853c92b.akpm@digeo.com>
	 <1054028411.18165.5.camel@dhcp22.swansea.linux.org.uk>
	 <20030527034548.4aaae353.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054032047.18160.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 11:40:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-27 at 11:45, Andrew Morton wrote:
> The below patch has been in -mm for some time.  It was supposed to kill the
> IRQ if 750 of the previous 1000 IRQs weren't handled.
> 
> I disabled the killing code because it was triggering on someone's
> works-just-fine setup.
> 
> There will be pain involved in getting all this to work right.  Do you
> really think there's much value in it?

Being able to at least turn it on at run time is valuable when you are debugging
a box operated by someone who doesnt habitually rebuild kernels. The 750 of 1000
thing doesnt work because it can happen to be timing triggered by blocks of IRQ's
from a chip being folded together. The "million in a row" should be a stuck IRQ,
maybe 50,000 in a row even but just "zillions in a row"

