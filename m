Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263411AbTC2Mvy>; Sat, 29 Mar 2003 07:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263412AbTC2Mvy>; Sat, 29 Mar 2003 07:51:54 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:54199 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S263411AbTC2Mvw>; Sat, 29 Mar 2003 07:51:52 -0500
Date: Sat, 29 Mar 2003 13:03:00 +0000
From: Craig Robinson <craig.robinson@btinternet.com>
X-Mailer: The Bat! (v1.61) Business
Reply-To: Craig Robinson <craig.robinson@btinternet.com>
Organization: BT
X-Priority: 3 (Normal)
Message-ID: <188481168784.20030329130300@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: 845GE Chipset severe performance problems
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there, I would appreciate any help any of you guys can give..

Having built 3 identical machines based on:

MSI 845GE Max-L mainboard
P4 (533) 2.4GHz CPU
512Mb PC2700 DDR
Maxtor DiamondMax9 80GB

... we're experiencing very strange and severe performance problems with the systems.

They all have RH8 installed, we have tried both the default kernel and the latest 2.4.20. The problem manifests itself in overall slow system performance. I'll give an example below:

When running 'make menuconfig', this normally takes about a second to make and load, however on these machines it takes about 20-30 seconds! We've got a Celeron which does it faster.

A bit of background on what we've tried:

-HD's are running 32bit I/O and UDMA, infact hdparm tests report some very nice figures.
-There is no excessive HD activity, infact HD activity seems normal.
-Onboard Sound and all USB is disabled, and on the 2.4.20 we're using, these have been removed from the kernel.
-We've tried various combinations of just about every BIOS setting which could effect this, so we're resigned to thinking this is some sort of OS/Kernel/Support issue.

The best way to describe the problem is; it's like trying to use the system while it's under excessive load. Obviously there is no load on the system however, the problem occurs when using the system from idle.

We have tried a number of different kernels and also tried fresh
installs of Redhat8 and Redhat 7.3, both make the same problems.

Kernels tried:
2.5.66
2.4.21-grsec-xfs
2.4.20
 
All bring up the same results.

We have run tests on the memory and cpu and each seem to
running fine (CPU is very quick actually..)

If anyone needs any more info feel free to ask, we're beginning to tear our hair out on this one, it's very frustrating... ANY help at all is really appreciated.

Here is some info:


cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2405.506
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4784.26

cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  525225984 215515136 309710848        0 93630464 74813440
Swap: 1069244416        0 1069244416
MemTotal:       512916 kB
MemFree:        302452 kB
MemShared:           0 kB
Buffers:         91436 kB
Cached:          73060 kB
SwapCached:          0 kB
Active:         190012 kB
Inact_dirty:      2200 kB
Inact_clean:      4036 kB
Inact_target:    39248 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       512916 kB
LowFree:        302452 kB
SwapTotal:     1044184 kB
SwapFree:      1044184 kB
Committed_AS:    63376 kB

fdisk -l

Disk /dev/hda: 255 heads, 63 sectors, 9964 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        13    104391   83  Linux
/dev/hda2            14      1543  12289725   83  Linux
/dev/hda3          1544      2563   8193150   83  Linux
/dev/hda4          2564      9964  59448532+   f  Win95 Ext'd (LBA)
/dev/hda5          2564      2690   1020096   83  Linux
/dev/hda6          2691      2820   1044193+  82  Linux swap
/dev/hda7          2821      9964  57384148+  83  Linux


