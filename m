Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSKUA33>; Wed, 20 Nov 2002 19:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbSKUA33>; Wed, 20 Nov 2002 19:29:29 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:61066 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266203AbSKUA31>;
	Wed, 20 Nov 2002 19:29:27 -0500
Date: Thu, 21 Nov 2002 00:37:39 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading enhancements, tid-2.5.47-C0
Message-ID: <20021121003739.GD12650@bjl1.asuk.net>
References: <Pine.LNX.4.44.0211181303240.1639-100000@localhost.localdomain> <3DDAE822.1040400@redhat.com> <20021120033747.GB9007@bjl1.asuk.net> <3DDB09C2.3070100@redhat.com> <20021120215540.GA11879@bjl1.asuk.net> <3DDC08AF.7020107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC08AF.7020107@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > - of
> > the order of a single system call time, i.e. not significant.  (That
> > delay is much shorter than signal delivery time itself).  No signals
> > are actually _lost_,
> 
> Of course they can get lost.  Normal Unix signals are not queued.

Oh yes they are.  Libc info for "Why Block":

   Temporary blocking of signals with `sigprocmask' gives you a way to
   prevent interrupts during critical parts of your code.  *If signals
   arrive in that part of the program, they are delivered later, after you
   unblock them.*

And sigpending(2):

   The sigpending call allows the examination of pending signals (ones
   which have been raised while blocked).  The signal mask of pending
   signals is stored in set".

-- Jamie
