Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTEVUeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTEVUeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:34:44 -0400
Received: from mail.eskimo.com ([204.122.16.4]:47371 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S263246AbTEVUen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:34:43 -0400
Date: Thu, 22 May 2003 13:47:35 -0700
To: Ming Lei <lei.ming@attbi.com>
Cc: linux-kernel@vger.kernel.org, Elladan <elladan@eskimo.com>, efault@gmx.de
Subject: Re: Linux 2.4 scheduler is RTOS-alike?
Message-ID: <20030522204735.GB4195@eskimo.com>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil> <20030514205949.GA3945@kroah.com> <004601c3209c$f0739700$0305a8c0@arch.sel.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004601c3209c$f0739700$0305a8c0@arch.sel.sony.com>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also of note, FIFO threads will actually block the same priority threads
forever.  An RR thread will also block a lower priority thread forever,
but it'll get preempted by other RR threads with the same priority.  A
FIFO thread is never preempted except by higher priority, it has to
yield somehow (explicitly or by blocking)

-J

On Thu, May 22, 2003 at 01:01:30PM -0700, Ming Lei wrote:
> 
> will it be the same behavior If thread A and thread B both have a lot of
> printf? Suppose A get first run, does B get run at all?
> 
> > this question is regarding linux kernel 2.4.7-2.4.20.
> > linux 2.4 kernel does support real time sheduler. If using FIFO real time
> > schedule policy, would the case that higher priority thread starve the
> lower
> > priority thread happen?  Similarly, let's say an example: if I have higher
> > prioority thread A and lower priority thread B, thread A is running
> without
> > any wait or blocking, is there a possiblity that 2.4 scheduler may want to
> > switch to thread B? Why?
> 
> Yes, FIFO threads that spin will block lower priority threads forever.
> 
> Sure, guaranteed if the high prio SCHED_FIFO task doesn't block at all.  If
> you have a pure cpu burner, it will starve all lower priority
> threads.
