Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWGMFfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWGMFfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWGMFfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:35:38 -0400
Received: from www.polish-dvd.com ([69.222.0.225]:9947 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1751397AbWGMFfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:35:38 -0400
Message-ID: <20060713052037.26594.qmail@mail.webhostingstar.com>
From: "art" <art@usfltd.com>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, alexey.y.starikovskiy@intel.com,
       akpm@osdl.org
Subject: cpufreq ondemand governor problem on SMP DUALCORE AMD
Date: Thu, 13 Jul 2006 00:20:37 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc1-git5-64-smp cpufreq ondemand governor problem on SMP DUALCORE AMD 
64bit system
 - start 2 processes with infinite loop in each - OK both cores 100% 
utilization cpu speed max
 - kill one - BAD now one core utilization ~100% but cpu speed dropped to 
core with lowest utilization - fluctuating from min at this level depending 
on system activity.
any possibility to setup ondemand governor for max speed if only 1 core 
utilization is maxed - full speed for single-process/single-thread activity 
?
looks like cpufreq ondemand governor sets two frequency dependent cores to 
speed level ok for that one with lowest utilization slowing down 
process/thread working on other core. For now it is ok for independent 
multiprocessor bad for multicore-freq-dependent.

xboom 

art@usfltd.com 

(observe cpu-freq and utilization
terminal-1: awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<10000;j++);}'
terminal-2: awk 'BEGIN {for(i=0;i<100000;i++)for(j=0;j<10000;j++);}'
kill one awk)
