Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291894AbSBASB5>; Fri, 1 Feb 2002 13:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291895AbSBASBj>; Fri, 1 Feb 2002 13:01:39 -0500
Received: from splat.lanl.gov ([128.165.17.254]:20652 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S291891AbSBASBU>; Fri, 1 Feb 2002 13:01:20 -0500
Date: Fri, 1 Feb 2002 11:01:20 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Cc: Mark Gardner <mkg@lanl.gov>
Subject: [question] peculiar scheduler execution pattern
Message-ID: <20020201180120.GF24524@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning-

Summary: I am measuring how long the kernel spends in schedule(). On a
dual CPU machine, the time for one CPU is lower than the other. Regularly
(about every second) the results switch. Why is the time spent in schedule()
longer on one CPU than the other and why do the results switch periodically?
I vaguely remember seeing something about this on the list recently (with
all the O(1) discussion), but searched the archives to no avail.

Details: The machine is a dual 400 MHz Pentium II running Debian testing with a
2.4.17 SMP kernel. I am using an instrumentation package we are developing [1]
to save a timestamp at the beginning and end of kernel/sched.c:schedule(). The
time source is get_cycles(). Other than an empty infinite loop program,
the usual daemons and my ssh shell, nothing is running on the machine. (When
not running the CPU bound process, uptime reports a load of 0.00.)

A graph [2] of the time spent in schedule as a function of time shows one
CPU spends less time in schedule than the other one (approximately 2 usec
and 6 usec respectively). After about a minute they switch places.

Why is the time spent in schedule() longer on one CPU than the other and
why do the results switch periodically?

Any information, links, etc. would be appreciated (and I'm on the list,
so a CC is not required).
-Eric

[1] http://www.lanl.gov/radiant/website/research/measurement/magnet.html
[2] http://public.lanl.gov/mkg/cpubound_normal_ctx_time.png

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
