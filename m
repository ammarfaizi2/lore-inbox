Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316094AbSEJVHa>; Fri, 10 May 2002 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316101AbSEJVH3>; Fri, 10 May 2002 17:07:29 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:65044 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S316094AbSEJVH2>; Fri, 10 May 2002 17:07:28 -0400
Message-Id: <200205102107.AWB17222@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.4.19pre8-jp11
Date: Fri, 10 May 2002 23:05:22 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel patch set 2.4.19pre8-jp11

This is the eleventh release of the -jp kernel patch set. 

Status: 10 May 2002 21:30 CEST

Changes from jp10 to jp11 

Many updates. New versions: rmap13a, ALSA 0.9.0rc1, preempt 2.4.19pre8,
RAID MD for 2.4.19pre7, XFS CVS of 4 May 2002, Crypto patch 2.4.18-2,
grsecurity 1.9.5pre3. New patches: Robert Love's additional preemption
patches (including migration-thread and remove-wakeup-sync), 
IDE CD DMA, mini lowlatency (from jam kernel patch set), ACPI 20020503, 
ACPI PCIIRQ 17, TUX 2 final A3, and some minor addons and fixups.  
khttpd has been removed in preference of TUX. 
OSS sound driver has been removed in preference of ALSA OSS API 
emulation layer. System shutdown hang fixed. 

Known Issues 

With ACPI enabled and APM disabled, Dell Inspiron 8100 power cable 
can't be pulled off, system will immediately power off. There are
obviously some ACPI flaws, but no real bugs. See http://acpi.sf.net
The miroSound PCM20 radio audio driver depends on OSS sound include file 
and is no longer compileable.

What is it? 

The -jp kernels are development kernels for testing purpose only. 
They will appear regularly two or three times a month. Their purpose 
is to provide a service for developers who can't keep up to date with 
the latest kernel and patch versions, but want to test new features and 
evaluate enhancements that are not to be expected for inclusion into 
the mainstream 2.4 kernel. 

Download 

The patch set is provided as a single archive where you will find all
patches as separate .bz2 packed files. Please take care if you split 
the set and try to use parts of it. The recommended way is downloading 
the set, unpacking the archive, and apply the patches with the 
addpatches shell script. 

http://infolinux.de/jp11

Installation 

The addpatches shell script is very useful to apply the 
patch set. Here are the basic commands how to build a new kernel 
with -jp patches: 

Download 2.4.18 Linux kernel sources 
Unpack into /usr/src/linux 
Download -jp patch set 
Unpack into your patchdir 
cd patchdir 
sh addpatches
cd /usr/src/linux
make menuconfig
make dep clean bzImage modules
su
make modules_install
cp System.map /boot/System.map-2.4.1X-preX-jpX
cp arch/i386/boot/bzImage /boot/vmlinuz.2.4.1X-preX-jpX
 edit /etc/lilo.conf 
lilo
 reboot ... and take a deep breath! You are running a jp kernel now!   

Contact 

You feel happy with a jp kernel? Just let me know if my work is good 
for you. 

Feel free to contact me, send e-mail to joerg@infolinux.de 
I try to help as much as I can. It's fun to hack the Linux kernel! 
If you are lucky, you can find me hanging out at IRC: #kernelnewbies at 
irc.openprojects.net Credits to all the fine people out there. 

You have successfully booted a -jp kernel? You want to know if your 
system can run a -jp kernel? If you like to send your 'dmesg' output 
of successful booting into a -jp kernel, please let me know about 
your system. Please attach the system name, your kernel '.config' 
and other valuable information in your mail. Also, I like to know 
if certain hardware or .config's don't work, or when build errors 
occur. I will add this information on my web page. 

You are missing a patch? Patches will be added by request. 
Please be patient, some patches must be carefully tested.    

Jörg Prante 
joerg@infolinux.de
http://infolinux.de/jp11

Patch Overview

Detailed description is available on http://infolinux.de/jp11

00_patch-2.4.19-pre0-pre1      25_mdp-major
00_patch-2.4.19-pre1-pre2      26_autofs4
00_patch-2.4.19-pre2-pre3      27_isrdonly
00_patch-2.4.19-pre3-pre4      28_new-stat
00_patch-2.4.19-pre4-pre5      29_mediactl
00_patch-2.4.19-pre5-pre6      30_llseek
00_patch-2.4.19-pre6-pre7      31_mount
00_patch-2.4.19-pre7-pre8      32_device
01_kernel-sound-remove-0-pre8  33_supermount
01_kernel-sound-remove-1-pre7  34_xfs-kdb-from-cvs-04May2002
01_kernel-sound-remove-2-pre6  35_xfs-kdb-adapt
01_kernel-sound-remove-3-pre5  36_xfs-kdb-fixups
01_kernel-sound-remove-4-pre4  37_jfs-1.0.14-0
01_kernel-sound-remove-5-pre3  38_jfs-1.0.14-15
01_kernel-sound-remove-6-pre2  39_jfs-1.0.15-16
01_kernel-sound-remove-7-core  40_jfs-1.0.16-17
02_alsa-sound-0.9.0rc1         41_jfs-adapt
03_alsa-adapt-2.4.19pre8       42_ftpfs-0.6.2
04_TIOCGDEV                    43_cdfs-0.5b
05_boot-time-ioremap           44_cdfs-0.5bc
06_via-northbridge-fixup       45_patch-int-2.4.18.2
07_jiffies-for-i386            46_loop-jari
08_rmap-13                     47_grsecurity-1.9.5-pre3
08a_rmap13a                    48_grsecurity-adapt
09_sched-O1-K3                 50_i2c-2.6.3
10_up-apic-fix                 51_lmsensors-2.6.3
11_remove-wake-up-sync         52_freeswan-1.97
12_need-resched-abstraction    53_ide-cd-dma-3
13_frozen-lock                 54_lowlatency-mini
14_sched-yield                 55_lowlatency-fixes-5
15_need-resched-check          56_mmx-init
16_maxrtprio-1                 57_p4-xeon
17_migration-thread            58_x86-fast-pte
18_misc-stuff                  59_acpi-20020503
19_preempt-2.4.19pre8          60_acpi-pciirq-17
20_lockbreak                   61_remove-khttpd
21_ide-6                       62_tux2-final-A3
22_md-locks                    63_sis-740-961
23_raid-split                  98_tkparse-4096
24_md-part                     99_VERSION
