Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSIYURt>; Wed, 25 Sep 2002 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSIYURt>; Wed, 25 Sep 2002 16:17:49 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:63657 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S262107AbSIYUQW>; Wed, 25 Sep 2002 16:16:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15762.6899.798603.149518@samba.doc.wustl.edu>
Date: Wed, 25 Sep 2002 15:22:11 -0500
From: Krishnakumar B <kitty@cse.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.5.38
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting the following in my kernel logs with linux-2.5.38, which btw
is the first 2.5 kernel that I am able to boot into. It is a dual Pentium
III machine. I find this in the logs as soon as I log in. So I think that
this happens during boot-up. Kernel was compiled with the latest RedHat
RAWHIDE gcc-3.2 rpm.

The machine does not hang and I am able to use it fine. Please CC me on any
replies as I am not on this list.

-kitty.

Output of dmesg[snipped]
---------------

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 930.0781 MHz.
..... host bus clock speed is 132.0968 MHz.
cpu: 0, clocks: 132968, slice: 4029
CPU0<T0:132960,T1:128928,D:3,S:4029,C:132968>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 132968, slice: 4029
CPU1<T0:132960,T1:124896,D:6,S:4029,C:132968>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
c1531ef0 c0117fd3 c025d380 00000000 00000000 00000000 c1530000 c1531f88 
       c1530000 c1531f68 c011832d 00000000 c152f060 c0118030 00000000 00000000 
       c1531f58 c01173f2 c152f060 00000001 c152f060 c0118030 c1531f90 c1531f90 
Call Trace: [<c0117fd3>] [<c011832d>] [<c0118030>] [<c01173f2>] [<c0118030>] 
   [<c0119686>] [<c01196f5>] [<c01079d9>] [<c01196a0>] [<c01196a0>] [<c010564d>] 
bad: scheduling while atomic!
c152df10 c0117fd3 c025d380 00000000 00000000 00000000 c152c000 c152dfa8 
       c152c000 c152df88 c011832d 00000000 c152f760 c0118030 00000000 00000000 
       c152df78 c01173f2 c152f760 00000001 c152f760 c0118030 c152dfb0 c152dfb0 
Call Trace: [<c0117fd3>] [<c011832d>] [<c0118030>] [<c01173f2>] [<c0118030>] 
   [<c0119686>] [<c0122e80>] [<c0122e20>] [<c010564d>] 
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)

Output from ksymoops
--------------------

ksymoops 2.4.5 on i686 2.5.38.  Options used
     -v /u/scratch/downloads/kernel/linux-2.5.38/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.38/ (default)
     -m /boot/System.map-2.5.38 (specified)

cpu: 0, clocks: 132968, slice: 4029
cpu: 1, clocks: 132968, slice: 4029
CPU 1 IS NOW UP!
c1531ef0 c0117fd3 c025d380 00000000 00000000 00000000 c1530000 c1531f88 
       c1530000 c1531f68 c011832d 00000000 c152f060 c0118030 00000000 00000000 
       c1531f58 c01173f2 c152f060 00000001 c152f060 c0118030 c1531f90 c1531f90 
Call Trace: [<c0117fd3>] [<c011832d>] [<c0118030>] [<c01173f2>] [<c0118030>] 
   [<c0119686>] [<c01196f5>] [<c01079d9>] [<c01196a0>] [<c01196a0>] [<c010564d>] 
c152df10 c0117fd3 c025d380 00000000 00000000 00000000 c152c000 c152dfa8 
       c152c000 c152df88 c011832d 00000000 c152f760 c0118030 00000000 00000000 
       c152df78 c01173f2 c152f760 00000001 c152f760 c0118030 c152dfb0 c152dfb0 
Call Trace: [<c0117fd3>] [<c011832d>] [<c0118030>] [<c01173f2>] [<c0118030>] 
   [<c0119686>] [<c0122e80>] [<c0122e20>] [<c010564d>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0117fd3 <schedule+343/350>
Trace; c011832d <wait_for_completion+9d/100>
Trace; c0118030 <default_wake_function+0/40>
Trace; c01173f2 <try_to_wake_up+142/190>
Trace; c0118030 <default_wake_function+0/40>
Trace; c0119686 <set_cpus_allowed+f6/110>
Trace; c01196f5 <migration_thread+55/310>
Trace; c01079d9 <ret_from_fork+5/14>
Trace; c01196a0 <migration_thread+0/310>
Trace; c01196a0 <migration_thread+0/310>
Trace; c010564d <kernel_thread_helper+5/18>
Trace; c0117fd3 <schedule+343/350>
Trace; c011832d <wait_for_completion+9d/100>
Trace; c0118030 <default_wake_function+0/40>
Trace; c01173f2 <try_to_wake_up+142/190>
Trace; c0118030 <default_wake_function+0/40>
Trace; c0119686 <set_cpus_allowed+f6/110>
Trace; c0122e80 <ksoftirqd+60/130>
Trace; c0122e20 <ksoftirqd+0/130>
Trace; c010564d <kernel_thread_helper+5/18>

WARNING: USB Mass Storage data integrity not assured
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR A5)

1 warning issued.  Results may not be reliable.

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
