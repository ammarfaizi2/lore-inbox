Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSGUTMy>; Sun, 21 Jul 2002 15:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSGUTMy>; Sun, 21 Jul 2002 15:12:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47501 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S312560AbSGUTMx>;
	Sun, 21 Jul 2002 15:12:53 -0400
Date: Sun, 21 Jul 2002 21:14:54 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <Pine.LNX.4.44.0207211156580.872-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207212111300.24336-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Linus Torvalds wrote:

> This seems to have tons of stuff which makes it compile, but which is
> just broken. Randomly changing "cli()" to "__cli()" apparently just to
> make it compile, with no warning that its now buggy.

indeed ...

fixed these, and have categorized every change whether it's safe,
known-unsafe or unknown-effect, and commented the latter two.

i also removed the save_flags() and restore_flags() macros on SMP which 
were left there by accident.

new patch is at:

  http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A3

(there's one more open bug, i can now see the 'exited with preempt_count
1' messages.)

	Ingo

