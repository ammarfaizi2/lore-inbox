Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSLZA0v>; Wed, 25 Dec 2002 19:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSLZA0v>; Wed, 25 Dec 2002 19:26:51 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:32993 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S261523AbSLZA0t> convert rfc822-to-8bit; Wed, 25 Dec 2002 19:26:49 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.4.21-pre2-jp15
Date: Thu, 26 Dec 2002 01:33:54 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212260133.54856.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is my christmas present for you!

Linux kernel patch set 2.4.21-pre2-jp15

This is the fifteenth release of the -jp patch set.

Status: 25 Dec 2002 22:00 CEST

What is it?

The -jp kernel patch sets are development kernels for testing purpose only. 
They provide a service for developers who want keep up to date with the 
latest kernels and interesting patches. If you like to test interesting new 
features of patches and evaluate bleeding-edge enhancements not to be 
expected for inclusion into the standard 2.4 kernel in the near future, the 
-jp kernel patch set is the one for you.

The patches are selected under performance improvement criterias and increased 
stability under load, with an eye on better file system support and security. 
Each patch is carefully evaluated, compiled and adapted to fit into the 
collection. The patch set should compile; but it can't be guarantueed that it 
successfully boots on every machine.

Before being released, the -jp kernel is tested for successful booting into 
SuSE Linux 8.1 on a test machine with the Elitegroup K7S5A board, Duron 1 
Ghz, 256 MB, 40 GB IDE drive, SCSI 4.3 GB drive, Geforce 2 graphics card. It 
will be released if a -jp kernel self-compile and reboot on an XFS file 
system partition succeeds.

The -jp patch sets will appear regularly, depending on the progress of 2.4 
kernel releases. The 2.6 kernel is scheduled for second quarter of 2003, and 
-jp patch sets will be continued for 2.6 kernels.

Download

http://infolinux.de/jp15

The patch set is provided as a single archive where you will find all patches 
as separate files. Please take care if you split the set and try to use parts 
of it. The recommended method is downloading the set, unpacking the archive, 
and apply the patches with the applypatches shell script provided in the 
archive.

Content

001_intermezzo-fix                 038_i2c
002_parport-fix                    039_i2c-fix
003_ncpfs-fix                      040_lmsensors
004_i8k-fix                        041_h323-netmeeting-nat-fix
005_ide-fix                        042_talk-nat-fix
006_ide-hack                       043_net-khttpd-remove
007_aic7xx-trivialdb               044_net-tux2
008_scx200-fix                     045_nfs-all
009_variable-hz-rml                046_xfs
010_amd-cool                       047_xfs-kernel
011_cpufreq                        048_xfs-quota32
012_cpufreq-coppermine             049_xfs-dmapi
013_via-northbridge-fixup          050_xfs-misc
014_TIOCGDEV                       051_xfs-acl
015_vm-rmap                        052_xfs-ia64
016_vm-rmap-fix                    053_ntfs
017_vm-strict-overcommit-rml       054_ftpfs
018_vm-strict-overcommit-rml-fix   055_cdfs
019_sched-O1-rml                   056_ftpfs-fix
020_sched-O1-bluetooth-bnep-fix    057_njbfs
021_sched-hyperthreading           058_evms
021_sched-tunables-rml             059_evms-common
022_preempt-kernel-rml             060_evms-xfs-vfs-lock
022_preempt-log-rml                061_lvm2-devmapper-ioctl
022_preempt-stats-rml              062_lvm2-mempool-alloc-slab-fix
023_preempt-lock-break             063_driver-console-unicon
024_preempt-lowlatency             064_grsecurity
025_read-latency2-rmap             065_patch-int
026_pagecache-radixtree-lockbreak  066_loop-jari
027_driver-scsi-dc395x             067_alsa-kernel
028_driver-net-3c59x               068_alsa-kernel-stubs
029_driver-usbd-net                069_alsa-config
030_driver-usbd-net-fix            070_alsa-doc
031_driver-pdc202xx-pci            071_alsa-pde-airo-fix
032_driver-ide-cd-audio-dma        072_alsa-sb16-fix
033_driver-cdrw-packet-write       073_alsa-devfs-fix
034_supermount                     074_ieee1394-fix
035_supermount-fix                 075_freeswan-nodebug-fix
036_ipsec-freeswan                 100_VERSION
037_acpi

Known Issues

* XFS with preemptive kernel can't sync, a kernel BUG is thrown. Please don't 
use XFS with preemptive kernel.

* Kernel panic: VFS: Unable to mount root fs on ... Please build your root 
fs into the kernel, not as a module.

* The variable 'CONFIG_SOUND' is shared between Alsa and OSS. This is not very 
elegant. Kernel will be bigger than necessary.

* mkinitrd might fail with:
xfs: failed to add module "/lib/modules/2.4.21-pre2-jp15/kernel/fs/xfs/xfs.o"
initrd too small
Please don't switch on xfs debugging. It will bloat xfs.o over 22 MB.
    
* building a "Jumbo Kernel" with *all* possible configuration options selected 
to 'y' will build, but it fails at vmlinux link time due to limitations in 
binutils-2.12.90 (SuSE 8.1).

Have fun!

            Jörg Prante <joerg@infolinux.de> 
