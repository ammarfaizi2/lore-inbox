Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTLKVxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTLKVxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:53:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45839 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264340AbTLKVxC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:53:02 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t
Date: 11 Dec 2003 21:41:39 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <braoaj$5dh$1@gatekeeper.tmr.com>
References: <20031209045929.437362C002@lists.samba.org> <3FD5CFE1.8080800@cyberone.com.au>
X-Trace: gatekeeper.tmr.com 1071178899 5553 192.168.12.62 (11 Dec 2003 21:41:39 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FD5CFE1.8080800@cyberone.com.au>,
Nick Piggin  <piggin@cyberone.com.au> wrote:

| Well if (something like) cpu_sibling_map is to become architecture
| independant code, it should probably get something like cpu_to_package,
| package_to_cpumask sort of things like NUMA has.
| 
| I don't know if SMT should become just another level of NUMA because
| its not NUMA of course. For the scheduler it seems to make sense because
| SMT/SMP/NUMA basically want slight variations of the same thing.
| 
| Possibly as you say slab cache could be SMTed, but I'm not convinced
| that SMT and NUMA should become inseperable. Anyway I doubt 2.6 will
| see a general multi level NUMA framework.

It would seem that what concerns all of these levels is the process
migration cost, so perhaps it will be possible in 2.6 after all. Right
now a lot of clever people are actively working on scheduling, so now
is the time for a breakthrough which gives a big boost. Absent that I
predict all of the clever folks and most of us "build a bunch of
kernels and play" types will conclude the low hanging fruit have all
been picked and move on. Scheduling will be stable again.

Before that perhaps one of you will suddenly see some way to make this
all very simple and elegant, so everyone can look and say "of course"
and everything will work optimally.

What we have in all of these patches is a big gain over base, so the
efforts have produced visable gains.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
