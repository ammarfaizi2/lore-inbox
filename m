Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKFOOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKFOOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 09:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVKFOOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 09:14:35 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:32743 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750757AbVKFOOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 09:14:34 -0500
Message-ID: <1131286439.436e0fa79e228@webmail.technion.ac.il>
Date: Sun,  6 Nov 2005 16:13:59 +0200
From: erezz@techunix.technion.ac.il
To: linux-kernel@vger.kernel.org
Subject: CPU utilization and hyperthreading
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1255
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.2.4
X-Originating-IP: 132.68.61.112
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using a 2.6.4-52 (Suse 9.1 pro distribution) kernel on a 3.2 dual
XEON machine (with hyperthreading).

I'm trying to analyze the performance of a kernel module that contains
4 kernel threads (3 of them are more active). Also, some of the work is
done in a tasklet. The CPU load (as shown in vmstat) doesn't reach more
than 50%.  When trying to artificially stress the system with some
useless loops, the CPU load reaches 65% (but I cannot reach 100%). Also, the
interrupts count in vmstat is around 20000 (1000 when idle).
 
My questions are:
1. Why can't I reach 100%? 
2. I guess that since I have 4 virtual CPUs (as shown in /proc/cpuinfo), not all
of them are stressed. Is there a way to see the CPU utilization for each CPU
(vmstat doesn't allow that)? 
3. When I load a module with a kernel thread that runs an infinite loop, I get
25% CPU utilization (50% if I run 2 threads). Is it because I'm using 100% of a
single CPU (out of 4)?
4. How is the time spent in interrupt context estimated? Is it possible to view
it somehow?

Thanks
Erez



