Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSFRRKW>; Tue, 18 Jun 2002 13:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317501AbSFRRKV>; Tue, 18 Jun 2002 13:10:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3201 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317500AbSFRRKU>; Tue, 18 Jun 2002 13:10:20 -0400
Date: Tue, 18 Jun 2002 13:12:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: David Schwartz <davids@webmaster.com>, rml@tech9.net, mgix@mgix.com,
       linux-kernel@vger.kernel.org
Subject: Re: Question about sched_yield()
In-Reply-To: <3D0F669C.89596EC0@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020618130733.7442A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Chris Friesen wrote:

> David Schwartz wrote:
> > 
> > >And you seem to have a misconception about sched_yield, too.  If a
> > >machine has n tasks, half of which are doing CPU-intense work and the
> > >other half of which are just yielding... why on Earth would the yielding
> > >tasks get any noticeable amount of CPU use?
> > 
> >         Because they are not blocking. They are in an endless CPU burning loop. They
> > should get CPU use for the same reason they should get CPU use if they're the
> > only threads running. They are always ready-to-run.
> > 
> > >Quite frankly, even if the supposed standard says nothing of this... I
> > >do not care: calling sched_yield in a loop should not show up as a CPU
> > >hog.
> > 
> >         It has to. What if the only task running is:
> > 
> >         while(1) sched_yield();
> > 
> >         What would you expect?
> 
> If there is only the one task, then sure it's going to be 100% cpu on that task.
> 
> However, if there is anything else other than the idle task that wants to run,
> then it should run until it exhausts its timeslice.
> 
> One process looping on sched_yield() and another one doing calculations should
> result in almost the entire system being devoted to calculations.
> 
> Chris
> 

It's all in the accounting. Use usleep(0) if you want it to "look good".

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

