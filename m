Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWDQOXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWDQOXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWDQOXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:23:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751019AbWDQOXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:23:16 -0400
Subject: Re: irqbalance mandatory on SMP kernels?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rddunlap@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
In-Reply-To: <Pine.LNX.4.44.0604171608400.28728-100000@hubble.stokkie.net>
References: <Pine.LNX.4.44.0604171608400.28728-100000@hubble.stokkie.net>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 16:23:02 +0200
Message-Id: <1145283782.2847.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm not sure what your actual problem is btw, the irqbalance tool is
> > supposed to automatically start at boot, did it not do that ?
> > (and no the kernel doesn't need to do everything, something like this
> > can perfectly well be done in userspace as irqbalance shows)
> 
> My question is if the irqbalance util is really needed to activate IRQ 
> balancing these days. Which kernel versions and higher (2.4xx and 
> 2.6.xx) do need this tool? 

again this isn't kernel specific this is chipset specific. 2.4 NEVER
balanced irqs manually, and 2.6 has an optional in-kernel balancer which
is very conservative and which RHEL disables. Again only SOME, old,
hardware does balancing in hardware.

> 
> To my understanding can a Linux/UNIX kernel not be called SMP if it 
> does not activate Symmetric IRQ balancing out of the box.

I think I highly disagree with your statement.
1) I think you are too narrow focusing on "kernel" rather than OS.
2) Why would an OS NOT be SMP even without any IRQ balancing at all?
   (note, on just about any system irq load is < 1% even of 1 cpu)


>  Why was 
> irqbalance introduced as a tool inside kernel-utils in the 1st place?  

because hardware stopped doing the balancing and it turned out that a
userspace balancer could do much better than the hardware anyway

> In other words: What happened to the Linux kernel that we today now 
> need a tool called irqbalance ?

nothing happened to the kernel. Hardware changed.


