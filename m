Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbSI2H3u>; Sun, 29 Sep 2002 03:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSI2H3u>; Sun, 29 Sep 2002 03:29:50 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:33494 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP
	id <S262408AbSI2H3s>; Sun, 29 Sep 2002 03:29:48 -0400
From: Andreas Loong <reflect@phreaker.net>
To: linux-kernel@vger.kernel.org
Date: Sun, 29 Sep 2002 09:30:30 +0500
Message-ID: <yam9037.1502.149170808@smtp.phreaker.net>
X-Mailer: YAM 2.3 [040] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch/
Subject: sparc32 2.4.19: cpu race with modprobe qlogicpti.o
MIME-Version: 1.0
Content-Type: text/plain
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] brief statement
SPARC hangs when doing modprobe

[2.] full description.
when doing modprobe -a qlogicpti a cpu race condition occurs and the machine
goes down to prom-level. unfortunately, none of the messages made it into
any logfiles.
this message is printed to the console:
Warning: loading /lib/modules/2.4.19/kernel/drivers/scsi/qlogicpti.o will
taint the kernel: no license

[3.] keywords.
qlogic cpu race modprobe

[4.] full kernel version. 
Linux version 2.4.19 (root@calamari) (gcc version 2.95.4 20011002
(Debian prerelease)) #5 SMP Wed Sep 25 14:16:58 CEST 2002

[7.1.] Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         openprom slip slhc sg autofs

[7.2.] 
cpu             : ROSS HyperSparc RT625 or RT626
fpu             : ROSS HyperSparc combined IU/FPU
promlib         : Version 3 Revision 2
prom            : 2.25
type            : sun4m
ncpus probed    : 4
ncpus active    : 4
Cpu0Bogo        : 99.73
Cpu1Bogo        : 99.94
Cpu2Bogo        : 99.94
Cpu3Bogo        : 99.94
MMU type        : ROSS HyperSparc
contexts        : 4096
nocache total   : 1048576
nocache used    : 398336
CPU0            : online
CPU1            : online
CPU2            : online
CPU3            : online

[7.3.] Module information (from /proc/modules):
slip                   11764   0 (unused)
slhc                    4752   0 [slip]
sg                     30780   0
autofs                 10772   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
nothing at all

[7.5.] PCI information ('lspci -vvv' as root)
is there an equivalent command for sparc/sbus?

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST34371W SUN4.2G Rev: 7462
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST39173W SUN9.0G Rev: 2815
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: TOSHIBA  Model: XM-4101TASUNSLCD Rev: 1084
  Type:   CD-ROM                           ANSI SCSI revision: 02

[X.] Other notes, patches, fixes, workarounds:
I've been trying to reproduce the problem, but I can't do it in the exact
same way as the first time. However, if it does not go down while loading,
a simple matter of unloading the module brings the machine down hard.
I'm fairly new to linux, but if there's anything I can do to get you the
info needed to fix the problem, I'll do it. All I need is a bit of
guidance.


Wbr
Andreas Loong


