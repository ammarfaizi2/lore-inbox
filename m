Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSIZRDy>; Thu, 26 Sep 2002 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbSIZRDy>; Thu, 26 Sep 2002 13:03:54 -0400
Received: from p50846D8A.dip.t-dialin.net ([80.132.109.138]:10466 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S261405AbSIZRDx>;
	Thu, 26 Sep 2002 13:03:53 -0400
To: Adam Goldstein <Whitewlf@Whitewlf.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
References: <EFED8A1D-D02F-11D6-AD2E-000502C90EA3@Whitewlf.net>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Thu, 26 Sep 2002 19:09:09 +0200
In-Reply-To: <EFED8A1D-D02F-11D6-AD2E-000502C90EA3@Whitewlf.net> (Adam
 Goldstein's message of "Tue, 24 Sep 2002 22:38:56 -0400")
Message-ID: <m3adm465l6.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Goldstein <Whitewlf@Whitewlf.net> writes:

> [...]
> cooperative data? Personally, I can't make heads or tails of the
> vmstat  output, and, I still have as of yet to get a -real- answer for
> what   "load" is.. besides the knee-jerk answer of "its the avg load
> over X  minutes".  :)

In the olden days (at least I learnt that definition for a system
based on 3.x BSD), the "load average" is the number of runnable
processes (i.e. those that could do work if they got a slice of CPU
time) averaged over some period of time (1, 2, 5, 10 minutes).

So, naively speaking upgrading the box to the number of CPUs indicated
by an average load average will keep it well busy while getting the
maximum amount of work done. [Yes, of course this rule of thumb does
not include the considerable overhead were one to really implement
that scheme - we used this measure when scaling hardware well before
SMP x86 became competitively available].

For Linux the load average also seems to include some notion of the
fraction of time spent waiting for disk accesses; possibly Linux
counts the number of processes which are either Runnable or Waiting
for Disk.

I don't know the concise definition in Linux's case either.


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
