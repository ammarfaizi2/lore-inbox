Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317433AbSG3XwE>; Tue, 30 Jul 2002 19:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSG3XwE>; Tue, 30 Jul 2002 19:52:04 -0400
Received: from odeon.net ([63.229.205.185]:47769 "HELO titan.odeon.net")
	by vger.kernel.org with SMTP id <S317433AbSG3XwC>;
	Tue, 30 Jul 2002 19:52:02 -0400
Date: Tue, 30 Jul 2002 18:55:16 -0500 (CDT)
From: "Robert A. Hayden" <rhayden@geek.net>
X-X-Sender: <rhayden@titan.odeon.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18 crashdump - P4/3ware/NFS
Message-ID: <Pine.LNX.4.33.0207301837440.1473-100000@titan.odeon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently built a new home file server based around a P4 1.8Ghz CPU and a
3ware 6410 RAID controller along with a 2-port Intel 10/100 NIC.  The 6410
has 4x120GB IDE drives on it for a 360GB RAID5 drive.  I have been
exporting a a large partition (ext3) via NFS to a couple of other machines
to move some things around (I have another 3ware-based system with dual
P2-400s and 4x80GB in raid5, which in this case was where things were
being moved to).

Several times now the p4 system has either frozen (usually with a
crashdump), or just mysteriously rebooted while moving large quantities of
data over the NFS link.

I'm at a loss to explain this unless it starts to point to hardware
problems (bad CPU? Memory? motherboard?).  I thought for a bit it was due
to setiathome running in the background (one screendump mentioned seti) so
I disabled it and had it work fine when I copied 45GB across, but then
freeze and croak when I started another copy session when the first
completed.

Note, I also export a lot of this system over Samba and haven't had any
problems there, but I'm not pushing the samba links very hard (face it,
MP3s being streamed to winamp ain't hard work...)

I don't have a text log of the dump, but I did take a digital picture of
it at http://www.roberthayden.com/crashdump.jpg

If anyone has ANY thoughts here, they would be appreciated.  I hate to
start randomly replacing parts without an idea where to look.

Thanks all.

Robert


System info:
P4 1.8
512MB
SCSI0 - Symbios U160 SCSI with a DD3 Tape drive
SCSI1 - 3ware 6410 RAID w/ 4x120GB IDE (ibm) drives
Ethernet - Dual Intel 10/100
IDE CDrom (channel 1 master)
Distribution Base:  Redhat 7.3, recompiled 2.4.18 kernel

[~] # df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda3              8262068    960484   6881888  13% /
/dev/sda1               101089     11384     84486  12% /boot
/dev/sda5              2071384     34404   2036980   2% /home
/dev/sda6              1035660     34204   1001456   4% /var/log
/dev/sda7            344199916 217349096 126850820  64% /fileserver

[~] # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping        : 2
cpu MHz         : 1800.110
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3591.37

[~] # uname -a
Linux farnsworth 2.4.18 #3 Fri Jul 19 23:52:53 CDT 2002 i686 unknown


