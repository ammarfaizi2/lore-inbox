Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289028AbSANUfM>; Mon, 14 Jan 2002 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289037AbSANUd6>; Mon, 14 Jan 2002 15:33:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:64772 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288962AbSANUdn>;
	Mon, 14 Jan 2002 15:33:43 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: Momchil Velikov <velco@fadata.bg>, yodaiken@fsmlabs.com,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <16QDdD-1EqtSyC@fwd03.sul.t-online.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<16QBTc-1er7D6C@fwd03.sul.t-online.com> <1011039031.4603.15.camel@phantasy>
	 <16QDdD-1EqtSyC@fwd03.sul.t-online.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 15:36:44 -0500
Message-Id: <1011040605.4604.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 15:22, Oliver Neukum wrote:

> > No, this isn't needed.  This same problem would occur without
> > preemption.  Our semaphores now have locking rules such that we aren't
> > going to have blatant priority inversion like this (1 holds A needs B, 2
> > holds B needs A).
> 
> No this is a good old deadlock.
> The problem with preemption and SCHED_FIFO is, that due to SCHED_FIFO
> you have no guarantee that any task will make any progress at all.
> Thus a semaphore could basically be held forever.
> That can happen without preemption only if you do something that
> might block.

Well, semaphores block.  And we have these races right now with
SCHED_FIFO tasks.  I still contend preempt does not change the nature of
the problem and it certainly doesn't introduce a new one.

	Robert Love

