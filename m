Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267596AbUH2C1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267596AbUH2C1I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUH2C1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:27:08 -0400
Received: from web13925.mail.yahoo.com ([66.163.176.50]:19576 "HELO
	web13925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267596AbUH2C1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:27:05 -0400
Message-ID: <20040829022804.92317.qmail@web13925.mail.yahoo.com>
Date: Sat, 28 Aug 2004 19:28:03 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Peter Williams <pwil3058@bigpond.net.au>,
       Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41313985.3050805@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Williams <pwil3058@bigpond.net.au> wrote:
> The mode in which the scheduler was being used had all priority fiddling 
> (except promotion) turned off so the tasks should have been just round 
> robinning with each other.  Also, the time outs are fairly rare (every 
> few hours according to Nicolas's e-mail) and happen with several 
> different schedulers (with ZAPHOD (the one being used by Nicolas) and 
> Con's staircase schedulers having less problem than the vanilla 
> scheduler) which is why I thought it might be something outside the 
> scheduler.  Perhaps it's something outside the kernel?
> 

I can add to this that this problem occured on a variety of systems, single CPU
Pentium IIIs and 4s, Athlon, dual PIIIs ;
the one thing in common is that everything works fine on all those machines
with 2.4, but breaks with 2.5 (or redhat 2.4 kernel with some backported code).
When I do the tests, the only thing I switch is the kernel and reboot.

It's true that it could be something broken outside of the scheduling code
(like the way IRQ events are handled maybe, or the way signals are delivered).

The one difference between the artificial test (from the original post) and the
real life test I do now, is that the real test combines disks I/O, network I/O
(TCP/IP and UDP) and several multithreaded processes.
Where things are kind of bad is that I am far from saturating the machine (the
load average is less than 2), but still some processes get those annoying
timeouts.

Nicolas

