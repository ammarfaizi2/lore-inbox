Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSGLOeI>; Fri, 12 Jul 2002 10:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSGLOeH>; Fri, 12 Jul 2002 10:34:07 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:22521 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S316512AbSGLOeG>; Fri, 12 Jul 2002 10:34:06 -0400
Date: Fri, 12 Jul 2002 14:39:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: O(1) scheduler "complex" macros
Message-ID: <20020712123915.GA108@elf.ucw.cz>
References: <Pine.LNX.4.44.0207111111280.6835-100000@localhost.localdomain> <Pine.LNX.4.44.0207111137460.7442-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207111137460.7442-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  #define task_running(rq, p) \
> > 	((rq)->curr == (p)) && !spin_is_locked(&(p)->switch_lock)
> 
> one more implementational note: the above test is not 'sharp' in the sense
> that on SMP it's only correct (the test has no barriers) if the runqueue
> lock is held. This is true for all the critical task_running() uses in
> sched.c - and the cases that use it outside the runqueue lock are
> optimizations so they dont need an exact test.

I believe this is worth a *big fat* comment.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
