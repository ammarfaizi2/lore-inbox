Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSDDXsV>; Thu, 4 Apr 2002 18:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312119AbSDDXsL>; Thu, 4 Apr 2002 18:48:11 -0500
Received: from zero.tech9.net ([209.61.188.187]:20746 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312076AbSDDXsB>;
	Thu, 4 Apr 2002 18:48:01 -0500
Subject: Re: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at
	boot  time
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Roger Larsson <roger.larsson@norran.net>,
        Dave Hansen <haveblue@us.ibm.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204041541500.26177-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 18:47:59 -0500
Message-Id: <1017964079.23629.662.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 18:42, Linus Torvalds wrote:

> Because that requires that every user of "set_task_state()" needs to know 
> about preemption.

Hm, how so?  I contend not to rudely set the task state but instead mark
the task as "preempted" in preempt_schedule and handle this case in
schedule.

It requires zero change to anything else; this is the behavior of the
original patch I sent you.

> Btw, I think entry.S should just call preempt_schedule() instead, instead 
> of knowing about these details.

Agreed.

	Robert Love


