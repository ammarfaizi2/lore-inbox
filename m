Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317833AbSFMVYz>; Thu, 13 Jun 2002 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317835AbSFMVYy>; Thu, 13 Jun 2002 17:24:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41198 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317833AbSFMVYx>; Thu, 13 Jun 2002 17:24:53 -0400
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
From: Robert Love <rml@tech9.net>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3D090B4D.4060104@avaya.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jun 2002 14:24:41 -0700
Message-Id: <1024003481.6704.98.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-13 at 14:14, Bhavesh P. Davda wrote:

> No I haven't. What prompted me to go with the kernel.org 2.4.18 kernel 
> is the fact that the RedHat 7.3 2.4.18-3 kernel, with your O(1) 
> scheduler patches besides hundreds of other patches any of which might 
> also have changed the scheduler, doesn't honour SCHED_FIFO or SCHED_RR 
> real-time priorities at all.

Huh?  It certainly should...

> I would think that the logical place to add any process to the runqueue 
> would be the back of the runqueue. If all processes are ALWAYS added to 
> the back of the runqueue, then every process is GUARANTEED to eventually 
> be scheduled. No process will be starved indefinitely.

You are entirely right, but Ingo's point is very valid: changing wakeup
behavior is risky and is not ideal in the middle of 2.4.

Fixing major bugs is fine for 2.4, but changing behavior to suit an
ideal is not.  Now is your chance to do so for 2.5, however.

	Robert Love

