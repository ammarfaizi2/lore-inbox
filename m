Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTJOXe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTJOXe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:34:57 -0400
Received: from dp.samba.org ([66.70.73.150]:51588 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262712AbTJOXe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:34:56 -0400
Date: Thu, 16 Oct 2003 03:14:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031015171411.GH610@krispykreme>
References: <20031009174604.GC7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310091049150.22318-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > c) mind-boggling amount of code duplication - are there any plans to take
> > that stuff to kernel/*?
> 
> Yes. It was actually tried a few months ago, but some of the other 
> architectures have very different interrupt setups, so it got dropped. But 
> it will almost certainly happen eventually: we've had bugs fixed on x86 
> that ended up living a lot longer on other architectures.

>From memory at least x86, alpha, ppc32 and ppc64 worked with Andrey's
irq consolidation patches. I'll be pushing for it in 2.7 together with
some macros to abstract away irq_desc[NR_IRQS] completely. (it will
make it easier to support 24 bit irqs on ppc64 and should allow sparc64
to use the consolidated irq code).

Anton
