Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262735AbRE0D2s>; Sat, 26 May 2001 23:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262738AbRE0D2h>; Sat, 26 May 2001 23:28:37 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6406 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262735AbRE0D20>;
	Sat, 26 May 2001 23:28:26 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105270328.f4R3SIG40664@saturn.cs.uml.edu>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
To: davem@redhat.com (David S. Miller)
Date: Sat, 26 May 2001 23:28:18 -0400 (EDT)
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <15120.16986.610478.279574@pizda.ninka.net> from "David S. Miller" at May 26, 2001 04:55:06 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller
> Ingo Molnar writes:

>> (unlike bottom halves, soft-IRQs do not preempt kernel code.)
> ...
>
> Since when do we have this rule? :-)
...
> You should check Softirqs on return from every single IRQ.
> In do_softirq() it will make sure that we won't run softirqs
> while already doing so or being already nested in a hard-IRQ.
> 
> Every port works this way, I don't know where you got this "soft-IRQs
> cannot run when returning to kernel code" rule, it simply doesn't
> exist.

After you two argue this out, please toss a note in Documentation.
