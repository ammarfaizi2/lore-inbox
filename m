Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTE0KZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTE0KZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:25:06 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38604
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262288AbTE0KZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:25:05 -0400
Subject: Re: [PATCH] xirc2ps_cs irq return fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030526205548.4853c92b.akpm@digeo.com>
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
	 <3ED16351.7060904@pobox.com>
	 <Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
	 <1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
	 <3ED2E03E.80004@pobox.com>  <20030526205548.4853c92b.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054028411.18165.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 10:40:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-27 at 04:55, Andrew Morton wrote:
> It should only be turned on for special situations, where someone is trying
> to hunt down a reproducible lockup.  These are situations in which the odd
> false positive just doesn't matter.  And we know that there will always
> be false positives due to apic delivery latency (at least).
> 
> I think the time is right to do this.  Add CONFIG_DEBUG_IRQ and get on with
> fixing real stuff.

I not 100% convinced. I think it should be left by default but only if you get
something like a million unhandled interrupts in a row. Thats the "your box has died"
case where the info is useful anyway.

Maybe the number in a row is what you want to tweak in config or /proc/sys ?

