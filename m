Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBSVTA>; Mon, 19 Feb 2001 16:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBSVSv>; Mon, 19 Feb 2001 16:18:51 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:11012 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129230AbRBSVSc>; Mon, 19 Feb 2001 16:18:32 -0500
Date: Mon, 19 Feb 2001 22:18:28 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The lack of specification (was Re: [LONG RANT] Re: Linux stifles innovation... )
In-Reply-To: <200102192017.f1JKHO952286@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.96.1010219220603.16223B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One of these things must happen:
> 
> a. follow the specification, even if that makes code slow and contorted
> b. change the specification
> c. ignore the specification
> d. get rid of the specification
> 
> Option "a" will not be accepted around here. Sorry.

It should be followed in stable releases. (and usually is - except for few
cases - and except that there is no specification, just unwritten rules).

> The best you can
> hope for is option "b". Since that is hard work (want to help?) we
> often end up not using a specification... hopefully by just not
> having one, instead of by ignoring one.


> > Now implementators of TCP will say: that driver is buggy. Everybody should
> > set state=TASK_RUNNING before calling schedule to yield the process. 
> > 
> > Implementators of driver will say: TCP is buggy - no one should call my
> > driver in TASK_[UN]INTERRUPTIBLE state.
> > 
> > Who is right? If there is no specification....
> 
> The driver is buggy, unless the TCP maintainer can be convinced
> that TCP is buggy. TCP is a big chunk of code that most people use,
> while the driver is not so huge or critical.
> 
> The TCP maintainers do not seem to be sadistic bastards hell-bent on
> breaking your drivers. API changes usually have a good reason.

Why should block device developers read TCP/IP code? And only after
reading significant amount of it they realize that they can be called in
TASK_INTERRUPTIBLE state. 

They will most likely read other block drivers, find using schedule
without setting state and use it also that way. 

The only way to tell developers to always set state before using schedule
is to write it to specification.

Mikulas


