Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbTCRTDf>; Tue, 18 Mar 2003 14:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262549AbTCRTDf>; Tue, 18 Mar 2003 14:03:35 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:13698 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262546AbTCRTDe>; Tue, 18 Mar 2003 14:03:34 -0500
Date: Tue, 18 Mar 2003 13:14:21 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4
 due to wrmsr (performance)
In-Reply-To: <3E7765DE.10609@didntduck.org>
Message-ID: <Pine.LNX.4.44.0303181312490.1261-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You can run this (stupid) test-program to try. On my P4 I get
> > 
> > 	empty overhead=320 cycles
> > 	load overhead=0 cycles
> > 	I$ load overhead=0 cycles
> > 	I$ load overhead=0 cycles
> > 	I$ store overhead=264 cycles

On my Athlon 1.3GHz system I get:
[tmolina@dad tmolina]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1343.030
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2637.82

empty overhead=16 cycles
load overhead=1 cycles
I$ load overhead=1 cycles
I$ load overhead=1 cycles
I$ store overhead=763 cycles


