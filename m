Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282830AbRK0HMd>; Tue, 27 Nov 2001 02:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282832AbRK0HMX>; Tue, 27 Nov 2001 02:12:23 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:34591 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S282828AbRK0HML>; Tue, 27 Nov 2001 02:12:11 -0500
Message-Id: <5.0.2.1.2.20011127020817.009ed3d0@pop.mindspring.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 27 Nov 2001 02:13:29 -0500
To: <mingo@elte.hu>, Robert Love <rml@tech9.net>
From: Joe Korty <l-k@mindspring.com>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
Cc: Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111270930470.3061-100000@localhost.localdom
 ain>
In-Reply-To: <1006832357.1385.3.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:40 AM 11/27/01 +0100, Ingo Molnar wrote:
> > This patch comes about as an alternative to Ingo Molnar's
> > syscall-implemented version.  Ingo's code is nice; however I and
> > others expressed discontent as yet another syscall. [...]
>
>i do express discontent over yet another procfs bloat. What if procfs is
>not mounted in a high security installation? Are affinities suddenly
>unavailable? Such kind of dependencies are unacceptable IMO - if we want
>to export the setting of affinities to user-space, then it should be a
>system call.

...

> > [...] Other benefits include the ease with which to set the affinity
> > of tasks that are unaware of the new interface [...]


I have not yet seen the patch, but one nice feature that a system call 
interface
could provide is the ability to *atomically* change the cpu affinities of 
sets of
processes -- for example, all processes with a certain uid or gid.  All that
would be required would be for the system call to accept a command integer
value which would define what the argument integer value would mean -- a pid,
a gid, or a uid.

Joe


