Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbTDAOTs>; Tue, 1 Apr 2003 09:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbTDAOTs>; Tue, 1 Apr 2003 09:19:48 -0500
Received: from franka.aracnet.com ([216.99.193.44]:27050 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262558AbTDAOTq>; Tue, 1 Apr 2003 09:19:46 -0500
Date: Tue, 01 Apr 2003 06:31:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: New: SSE2 enabled by default on Celeron (P4 based) 
Message-ID: <17080000.1049207466@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=527

           Summary: SSE2 enabled by default on Celeron (P4 based)
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: simon@mtds.com


Distribution: Customised RH 7.1 with many mods
Hardware Environment: Celeron i686 (P4 based)
Software Environment: gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)

Problem Description: Kernel compiles OK, but at boot kernel panics as CPU
doesn't support SSE2

Steps to reproduce: Compile kernel choosing *any* Celeron option

/proc/cpuinfo:-
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Celeron(TM) CPU                1300MHz
stepping        : 1
cpu MHz         : 1302.763
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 2580.48

I tried manually editing the SSE2 flags before compiling, didn't work either. If
I am correct, SSE2 is not a feature of Celerons.

