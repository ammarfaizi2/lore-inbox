Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992709AbWJTVKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992709AbWJTVKW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992713AbWJTVKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:10:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992709AbWJTVKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:10:18 -0400
Date: Fri, 20 Oct 2006 14:06:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
In-Reply-To: <20061020185944.GC8894@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610201402180.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk>
 <20061015124210.GX30596@stusta.de> <20061019081753.GA29883@flint.arm.linux.org.uk>
 <20061020180722.GA8894@flint.arm.linux.org.uk> <20061020111900.30d3cb03.akpm@osdl.org>
 <20061020183159.GB8894@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610201149340.3962@g5.osdl.org>
 <20061020185944.GC8894@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Russell King wrote:
> > 
> > Gaah. Remind me where the autobuild is again..
> 
> The main status page is at:
>   http://armlinux.simtec.co.uk/kautobuild/

Ahh. At least _most_ builds seem ok. I only looked at the first failing 
one, and it _seems_ to be due to "drivers/usb/gadget/pxa2xx_udc.c" which 
still includes <asm/irq.h> rather than <linux/irq.h>.

Maybe. I could do the trivial fix myself, but there have been people who 
have ARM build environments, so maybe somebody who can actually verify 
whether that one-liner fixes things (or whether there is something else 
hiding) can do that and send me the patch.

[ Although I've gotten so much email lately that maybe I already missed 
  that patch. Ahh, the joys of SCM discussions ;) ]

			Linus
