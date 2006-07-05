Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWGEQy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWGEQy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWGEQy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:54:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbWGEQy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:54:58 -0400
Date: Wed, 5 Jul 2006 09:54:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andi Kleen <ak@suse.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: early pagefault handler
In-Reply-To: <44ABEB20.2010702@zytor.com>
Message-ID: <Pine.LNX.4.64.0607050952190.12404@g5.osdl.org>
References: <200607050745_MC3-1-C42B-9937@compuserve.com> <p73veqcp58s.fsf@verdi.suse.de>
 <44ABEB20.2010702@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, H. Peter Anvin wrote:
> 
> I don't remember what the failure mode was, though; didn't think it was
> recursive faulting.

I think we should probably remove the test. The failure mode was simply 
that a machine with the "halt" idle loop simply didn't work, and would 
lock up. The most likely reason for that is probably just a bad CPU power 
VRM, and the potential high current fluctuations, not so much any CPU bug 
itself.

Anybody with that old a CPU will have learnt to to say "no-hlt" or 
whatever the kernel command line is, and we could probably retire the 
silly old hlt check (which I'm not even sure really ever worked).

		Linus
