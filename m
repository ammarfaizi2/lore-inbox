Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132481AbQK3BKK>; Wed, 29 Nov 2000 20:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132489AbQK3BKA>; Wed, 29 Nov 2000 20:10:00 -0500
Received: from enchanter.real-time.com ([206.10.252.9]:28690 "EHLO
        enchanter.real-time.com") by vger.kernel.org with ESMTP
        id <S132481AbQK3BJs>; Wed, 29 Nov 2000 20:09:48 -0500
Date: Wed, 29 Nov 2000 18:39:19 -0600
From: Bob Tanner <tanner@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: do_try_free_pages failed for python
Message-ID: <20001129183919.B7640@real-time.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A2590C8.34459BF9@echostar.com> <20001129181723.A2765@potty.housenet> <9046k7$nrf$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9046k7$nrf$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Nov 29, 2000 at 04:22:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: PROBLEM: do_try_free_pages failed for
python 

[2.] Full description of the problem/report: Running 2.2.18pre22 on a dual
Sparc20 with 128Mb of RAM.

[3.] Keywords (i.e., modules, networking, kernel):
do_try_free_pages, Sparc

[4.] Kernel version (from /proc/version):
Linux version 2.2.18pre22 (natecars@warrior) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 SMP Mon Nov 20 14:16:58 CST 2000

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
Not an Ooops.

[6.] A small shell script or example program which triggers the
     problem (if possible)
qrunner for the mailman-2.0 final package and more then 48 files in the qfiles
directory will trigger the problem.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux warrior 2.2.18pre22 #2 SMP Mon Nov 20 14:16:58 CST 2000 sparc unknown
Kernel modules         2.3.20
Gnu C                  egcs-2.91.66
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):
cpu		: ROSS HyperSparc RT625 or RT626
fpu		: ROSS HyperSparc combined IU/FPU
promlib		: Version 3 Revision 2
prom		: 2.25
type		: sun4m
ncpus probed	: 2
ncpus active	: 2
Cpu0Bogo	: 89.90
Cpu1Bogo	: 89.90
MMU type	: ROSS HyperSparc
invall		: 0
invmm		: 0
invrnge		: 0
invpg		: 0
contexts	: 4096
CPU0		: online
CPU1		: online
[7.3.] Module information (from /proc/modules):
Nothing

[7.4.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST15230N         Rev: 0298
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: EXABYTE  Model: EXB-8505         Rev: 0051
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DNES-318350      Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
$ cat swaps 
Filename			Type		Size	Used	Priority
/dev/sda4                       partition	131804	132	-1
/dev/sdb2                       partition	129596	0	-2

$ cat meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  130293760 127279104  3014656 29020160 81747968 24367104
Swap: 267673600   135168 267538432
MemTotal:    127240 kB
MemFree:       2944 kB
MemShared:    28340 kB
Buffers:      79832 kB
Cached:       23796 kB
SwapTotal:   261400 kB
SwapFree:    261268 kB

[X.] Other notes, patches, fixes, workarounds:

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
