Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTEBOrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTEBOrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 10:47:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37275
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261747AbTEBOrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 10:47:31 -0400
Subject: Re: [PATCH 0/4] NE2000 driver updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB1ADEC.6080007@rogers.com>
References: <3EB15127.2060409@rogers.com>
	 <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>
	 <3EB1ADEC.6080007@rogers.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 May 2003 15:01:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-02 at 00:29, Jeff Muizelaar wrote:
> Are we stuck with Space.c forever? Anyone have any plans for replacing 
> it with something more driver-model friendly?

Is it worth the effort. Why not just let the old isa stuff live out its
life in peace ? There is certainly no reason we couldnt make it more
driver model like by splitting probe and activity

ie ne2000 probing would do

	poke around for ISA device
	Found one ?
		Alloc isadevice
		Fill in ports/range/irq
		Fill in vendor/product with invented idents
		Announce it

Then have ne2000 driver model code do the actual setup


