Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTBXX3y>; Mon, 24 Feb 2003 18:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTBXX3y>; Mon, 24 Feb 2003 18:29:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49634 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262394AbTBXX3t>;
	Mon, 24 Feb 2003 18:29:49 -0500
Message-Id: <200302242348.h1ONmQS06178@es175.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: [BENCHMARK][OSDL] DBT2 results 2.5.49 vs 2.5.62dcl
Date: Mon, 24 Feb 2003 15:48:25 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We have been running OSDL's DBT2 database workload against the 
2.5.62-dcl2 kernel.  Our last long series of runs was against 
2.5.49 and we've included them for comparison. See Steve 
Hemminger's thread for a detailed list of -dcl patches. 

We run the database workload with two variations, one which is 
mostly in memory (cached) with log writes, and a second (non-cached) 
does constant data file reads and writes and log writes. Data 
collected on the runs includes vmstat, iostat and sar output and 
graphs, here: 

http://www.osdl.org/projects/dbt2dev/results/8way/LKML3/STP_8way_2.5.49vs2.5.62.html



There is very little difference in the workload metric going from 
2.5.49 to 2.5.62dcl2.  There are some differences in the buffering 
and caching reported by vmstat, but we are not certain if these 
are significant.  The non-cache case shows the context switching 
reduced from a peak of ~8500/sec on 2.5.49 to ~7500 on 2.5.62dcl2.


Some further configuration details: 
Data file devices are:
rd/c0d2 ,  rd/c0d3 ,  rd/c0d4 , rd/c0d5 , rd/c0d6 ,  rd/c0d7,  
rd/c0d8 ,  rd/c0d9 ,  rd/c0d10 , rd/c0d11, rd/c0d12  
Log device is: 	   
rd/c0d13


Regards,
Mary Edie Meredith, Mark Wong, Cliff White
OSDL


**********************************************************
Information regarding the 2.5.62dcl2:

2.5.62dcl2 includes these patch sets:
2.5.62-osdl2:
o Update to Megaraid 2 driver           (Mark Haverkamp, Matt Domsch)

2.5.62-osdl1:
o Cpu Hot Plug                          (Zwane Mwaikambo)
o CFQ disk scheduler                    (Jens Axboe)
o Pentium Performance Counters          (Mikael Pettersson)
o Linux Kernel Crash Dump (LKCD)        (Matt Robinson, LKCD team)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
o Kernel Config (ikconfig)              (Randy Dunlap)

2.5.62-dcl2:
o Bug fix for flock and threads         (Matthew Wilcox)

2.5.62-dcl1:
o Improved boot time TSC synchronization (Jim Houston)
o RCU statistics                        (Dipankar Sarma)
o Scheduler tunables                    (Robert Love)

The 2.5.62-dcl2 is available at  
http://sourceforge.net/projects/osdldcl

or BitKeeper 
       Common    bk://bk.osdl.org/linux-2.5-osdl  {TAG v2.5.62-osdl2)
           + DCL:bk://bk.osdl.org/linux-2.5-dcl   (TAG v2.5.62-dcl2)

or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
        osdl-2.5.62     PLM # 1572
        dcl-2.5.62      PLM # 1573
