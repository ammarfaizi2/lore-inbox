Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314865AbSDVW1Z>; Mon, 22 Apr 2002 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314864AbSDVW1W>; Mon, 22 Apr 2002 18:27:22 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:2397 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S314862AbSDVW1K>; Mon, 22 Apr 2002 18:27:10 -0400
Message-Id: <200204222227.AVO91139@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre7-jp10 #2 Mon Apr 22 19:28:48 CEST 2002 i686 unknown
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.4.19pre7-jp10
Date: Tue, 23 Apr 2002 00:25:31 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel patch set 2.4.19pre7-jp10

Jörg Prante 
joerg@infolinux.de
http://infolinux.de/jp10

This is the tenth release of the -jp patch set. 

Status: 22 Apr 2002 22:00 

Changes from jp9 to jp10 

Supermount patch is suspended, it needs some rework. 
It will rejoin in -jp11. HZ is set to 1000 on i386 architectures. 
This improves throughput under high loads. Minor RTC timer fix 
for Alsa timer. CDFS fixed. The sdmany patch is obsolete. 

Known Issues 

The root fs can't get unmounted since -jp9. The system hangs at 
shutdown time. This will cause the system doing a file system 
recovery at the next time it is booted. 

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

http://infolinux.de/jp10

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

Some systems running with -jp10 kernels 

Dell Inspiron 8100 SuSE 7.3 - 
Linux jungle 2.4.19-pre7-jp10 #1 Mon Apr 22 21:53:02 CEST 2002 i686 unknown 

Overview

Detailed description is available on http://infolinux.de/jp10

00_patch-2.4.19-pre0-pre1.bz2
00_patch-2.4.19-pre1-pre2.bz2
00_patch-2.4.19-pre2-pre3.bz2
00_patch-2.4.19-pre3-pre4.bz2
00_patch-2.4.19-pre4-pre5.bz2
00_patch-2.4.19-pre5-pre6.bz2
00_patch-2.4.19-pre6-pre7.bz2
00_serial-fixup.bz2
01_kernel-sound-remove-0-2.4.19pre7.bz2
01_kernel-sound-remove-1-2.4.19pre6.bz2
01_kernel-sound-remove-2-2.4.19pre5.bz2
01_kernel-sound-remove-3-2.4.19pre4.bz2
01_kernel-sound-remove-4-2.4.19pre3.bz2
01_kernel-sound-remove-5-2.4.19pre2.bz2
01_kernel-sound-remove-6-core.bz2
01_rtc.bz2
02_alsa-0.9.0beta10-0.bz2
02_alsa-0.9.0beta10-beta12-include.bz2
02_alsa-0.9.0beta10-beta12-sound.bz2
02_alsa-0.9.0beta12-no-modem-probe.bz2
02_alsa-0.9.0beta12-part1.bz2
02_rtc-timer-fixup.bz2
03_boot-time-ioremap.bz2
03_dmi-apic-fixups.bz2
04_1000-HZ-for-i386.bz2
11_rmap-13.bz2
12_sched-O1-K3.bz2
13_preempt.bz2
14_lockbreak-rml.bz2
15_lockbreak-1.bz2
20_ide-all-convert-6.bz2
21_via-northbridge-fixup.bz2
28_raidsplit.bz2
29_mdp-major.bz2
29_mdpart.bz2
30_xfs-kdb-from-cvs-20Apr2002.bz2
31_xfs-kdb-1.bz2
31_xfs-kdb-2.bz2
32_jfs-1.0.14-common.bz2
33_jfs-1.0.14-1.0.15.bz2
33_jfs-1.0.15-to-1.0.16.bz2
33_jfs-1.0.16-to-1.0.17.patch.gz
34_jfs-1.bz2
35_ftpfs-0.6.2.bz2
36_cdfs-0.5b-0.5c.bz2
36_cdfs-0.5b.bz2
40_TIOCGDEV.bz2
41_twofish-2.4.3.bz2
50_crypto-patch-int-2.4.18.1-1.bz2
50_crypto-patch-int-2.4.18.1.bz2
51_loop-jari-2.4.16.0.bz2
70_grsecurity-1.9.4-1.bz2
71_grsecurity-1.9.4-2.bz2
80_i2c-2.6.3.bz2
81_lmsensors-2.6.3.bz2
90_freeswan-1.97.bz2
98_tkparse-4096.bz2
99_VERSION.bz2
