Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281497AbRKQATj>; Fri, 16 Nov 2001 19:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281506AbRKQAT3>; Fri, 16 Nov 2001 19:19:29 -0500
Received: from [208.129.208.52] ([208.129.208.52]:54789 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281497AbRKQATX>;
	Fri, 16 Nov 2001 19:19:23 -0500
Date: Fri, 16 Nov 2001 16:28:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Real Time Runqueue
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Mike Kravetz wrote:

> Suppose you have a 2 CPU system with 4 runnable tasks.  3 of these
> tasks are realtime with the same realtime priority and the other is
> an ordinary SCHED_OTHER task.  The task distribution on the runqueues
> looks something like this.
>
> CPU 0             CPU 1
> ---------         ---------
> RT Task A         RT Task B
> Other Task C      RT Task D
>
> Task A and Task B are currently running on the 2 CPUs.  Now, Task A
> voluntarily gives up CPU 0 and Task B is still running on CPU 1.
> At this point, Task D should be chosen to run on CPU 0.  Correct?
> Isn't this a required RT semantic?  I'm curious how you plan on
> accomplishing this.

Well I don't know how RT sematics apply to SMP systems.
The easy solution ( == big common lock ) would be to have a single RT
queue that is checked before the private one.
Anyway, sometime it happens that the cure is worst than the disease and to
solve a corner case you're going to punish common case performances (
Linux is not an RT OS even with that fix ).




- Davide


