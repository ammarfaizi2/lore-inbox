Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272433AbTHEFEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272435AbTHEFEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:04:14 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:2460
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272433AbTHEFEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:04:12 -0400
Message-ID: <1060059844.3f2f3ac46e2f2@kolivas.org>
Date: Tue,  5 Aug 2003 15:04:04 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <200308050207.18096.kernel@kolivas.org> <200308051220.04779.kernel@kolivas.org> <3F2F149F.1020201@cyberone.com.au> <200308051318.47464.kernel@kolivas.org> <3F2F2517.7080507@cyberone.com.au>
In-Reply-To: <3F2F2517.7080507@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <piggin@cyberone.com.au>:

> 
> 
> Con Kolivas wrote:
> 
> >On Tue, 5 Aug 2003 12:21, Nick Piggin wrote:
> >
> >>No, this still special-cases the uninterruptible sleep. Why is this
> >>needed? What is being worked around? There is probably a way to
> >>attack the cause of the problem.
> >>
> >
> >Footnote: I was thinking of using this to also _elevate_ the dynamic
> priority 
> >of tasks waking from interruptible sleep as well which may help throughput.
> >
> 
> Con, an uninterruptible sleep is one which is not be woken by a signal,
> an interruptible sleep is one which is. There is no other connotation.
> What happens when read/write syscalls are changed to be interruptible?
> I'm not saying this will happen... but come to think of it, NFS probably
> has interruptible read/write.
> 
> In short: make the same policy for an interruptible and an uninterruptible
> sleep.

That's the policy that has always existed...

Interesting that I have only seen the desired effect and haven't noticed any 
side effect from this change so far. I'll keep experimenting as much as 
possible (as if I wasn't going to) and see what the testers find as well.

Con
