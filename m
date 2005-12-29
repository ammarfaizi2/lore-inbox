Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVL2Hli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVL2Hli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 02:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVL2Hlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 02:41:37 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:13784 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932572AbVL2Hlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 02:41:37 -0500
Date: Thu, 29 Dec 2005 08:41:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229074107.GB20177@elte.hu>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <m3fyoc4vye.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3fyoc4vye.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> >>    gcc version 4.0.2 20051109 (Red Hat 4.0.2-6)
> 
> > another thing: i wanted to decrease the size of -Os 
> > (CONFIG_CC_OPTIMIZE_FOR_SIZE) kernels, which e.g. Fedora uses too (to 
> > keep the icache footprint down).
> 
> Remember the above gcc miscompiles the x86-32 kernel with -Os:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173764

i'm not sure what the point is. There was no sudden rush of -Os related 
bugs when Fedora switched to it for the kernel, and the 35% code-size 
savings were certainly worth it in terms of icache footprint. Yes, -Os 
is a major change for how the compiler works, and the kernel is a major 
piece of software.

	Ingo
