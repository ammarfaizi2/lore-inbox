Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284810AbRLKB7y>; Mon, 10 Dec 2001 20:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284788AbRLKB7p>; Mon, 10 Dec 2001 20:59:45 -0500
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:34769 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S284810AbRLKB7b>; Mon, 10 Dec 2001 20:59:31 -0500
Subject: Re: [RFC] Multiprocessor Control Interfaces
From: Jason Baietto <jason@baietto.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Dec 2001 20:59:23 -0500
Message-Id: <1008035965.11626.3.camel@tofu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people have asked me for more information before they'll attempt
to download and play with this stuff, so here's the --help output from
the latest version of the run(1) command:


Usage: run [OPTIONS] { COMMAND [ARGS] | PROCESS_SPECIFIER }
Set scheduling parameters and CPU bias for a new process or a list
of existing processes.

OPTIONS can be one or more of the following options:

   -b, --bias=LIST        Set the CPU bias to the LIST of CPUs;
                          CPUs are numbered starting from 0
   -s, --policy=POLICY    Set the scheduling policy to POLICY
   -P, --priority=LEVEL   Set the scheduling priority to LEVEL
   -q, --quantum=QUANTUM  Set the SCHED_RR quantum to QUANTUM
   -v, --version          Output version information and exit
   -h, --help             Display this help and exit

PROCESS_SPECIFIER is exactly one of the following options:

   -p, --pid=LIST         Specify LIST of existing PIDs to modify
   -g, --group=LIST       Specify LIST of process groups to modify; all
                          existing processes in the groups will be modified
   -u, --user=LIST        Specify LIST of users to modify; all existing
                          processes owned by the users will be modified
   -n, --name=LIST        Specify LIST of existing process names to modify

Multiple comma separated values can be specified for all LISTs and ranges
are allowed where appropriate (e.g. "run -b 0,1-3 autopilot").

See the run(1) man page for more information.


Take care,
Jason


> Hello All,
> 
> I'm currently working on adding multiprocessor control interfaces
> to Linux.  My current efforts can be found here:
> 
>    http://www.ccur.com/realtime/oss
> 
> These are clean-room implementations of similar tools that have
> been available in our proprietary *nix for quite some time, and
> so the interfaces have a fair amount of mileage under their belts.
> Note that the scope is somewhat wider than just MP.
> 
> There has been some discussion of "chaff" and other interfaces
> recently on this list, so in an effort to hopefully move towards
> a standard more quickly I've gotten permission from my employer
> to GPL the code I've written.  I'm very interested in comments
> and feedback on any or all of this work.
> 
> Here's the README file from the package:
> 
> 
> This package contains:
> 
>    run(1)
>       A multiprocessor control command line tool.
> 
>    mpadvise(3)
>       A multiprocessor control library interface.
> 
> These services rely upon Robert Love's CPU Affinity patch
> (version 2.4.16-1 was used for testing) which is available here:
> 
>    http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/v2.4/
> 
> To build the code, simply unpack it and type "make".  The code has
> been tested on Red Hat 7.1 and 7.2 systems, though it is still
> fairly new and almost certainly contains bugs.
> 
> An attempt was made to abstract the "cpuset" representation of
> the current system in order to have binaries that in theory
> could work on systems with more than 32 cpus.  For this to work,
> the run(1) command would need to be linked against a shared
> mpadvise(3) library (currently only a static library is made).
> 
> This code is being released in the hopes that it will become
> the basis for the Linux multiprocessor control standard interfaces.
> I am very interested in getting feedback on this package,
> so please contact me via email or LKML if you have any.
> 
> This source code is licensed under the GNU GPL Version 2.
> Copyright (C) 2001  Concurrent Computer Corporation
> 
> --
> Jason Baietto
> jason.baietto@ccur.com
> http://www.ccur.com/realtime/oss



