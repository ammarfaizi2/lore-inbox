Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUGQFX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUGQFX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 01:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUGQFX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 01:23:26 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:11617 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266450AbUGQFXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 01:23:25 -0400
Message-ID: <40F8B7C5.9030201@yahoo.com.au>
Date: Sat, 17 Jul 2004 15:23:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc1-np1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/2.6.8-rc1-np1/

Now that I finally a highmem system, I've been able to make some progress
on the memory management chaneges. Still needs more work though. Feedback
would be nice if anyone is testing.

Scheduler behaviour is generally pretty good now so I've increased the
timeslice size to see how far I can push it. Some workloads really demand
small timeslices though, so I've added /proc/sys/kernel/base_timeslice.
If you have any problems with the default, please report it to me, and
check if lowering this value helps.

Things are working alright on my desktop with base_timeslice at 10000
which corresponds to around 15-20 *second* timeslices, however I don't
do much fancy, and it does have the problem of a newly forked CPU hog
possibly causing a long freeze (fixable by using a smaller value for
the first timeslice).

The -mm version of my patch also removes that kernel's dried gastropod
simulator for 2GB+ systems.

