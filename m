Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319086AbSHSWlY>; Mon, 19 Aug 2002 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSHSWlY>; Mon, 19 Aug 2002 18:41:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58823 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319086AbSHSWlR>;
	Mon, 19 Aug 2002 18:41:17 -0400
Date: Tue, 20 Aug 2002 00:46:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <200208192242.g7JMgmD29241@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208200044550.5489-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Richard Gooch wrote:

> > no, in other words: "yes, if you use SysV IPC semaphores/semaphores
> > in any of your binaries in your system, which binaries were linked
> > against glibc 2.1 or older, and if you have set
> > /proc/sys/kernel/pid_max to a value higher than 32K."
> 
> Ah, OK. So if I leave /proc/sys/kernel/pid_max alone, nothing will
> break. Will the default ever change, or do you plan on leaving it as is?

the default will be something sane, ie. probably larger than 32K. There is
safe code in glibc to catch your old applications from doing any
stupidity, then you can change pid_max or just upgrade your system (like
you did with the kernel). It's not a big dependency to require the setting
of pid_max if you want binary compatibility with rare old stuff.

	Ingo

