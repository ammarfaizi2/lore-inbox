Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbTCLQWR>; Wed, 12 Mar 2003 11:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbTCLQWQ>; Wed, 12 Mar 2003 11:22:16 -0500
Received: from asmtp2.prserv.net ([32.97.166.52]:43716 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S261779AbTCLQWM>;
	Wed, 12 Mar 2003 11:22:12 -0500
Message-Id: <5.1.0.14.0.20030312104635.022b1178@shrek>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 12 Mar 2003 11:32:49 -0500
To: linux-kernel@vger.kernel.org
From: Jim Peterson <jpeterson@annapmicro.com>
Subject: v2.5.32 - v2.5.64+ Locks at Boot with Athlon Machine
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I've tried versions 2.5.32, 2.5.59, 2.5.61, and 2.5.64, as well as version 2.5.31 and
  earlier on my machine.  Every version from 2.5.32 and above locks up after printing:

        Uncompressing Linux... Ok, booting the kernel.

  I've noticed there have been some significant changes in what I understand of the boot
  process at this point, but I can't decipher the assembly hardly at all well enough to
  try to investigate further.  Is there any place that I can acquire a set of the
  separate, unrelated patches that happened between 2.5.31 (which boots) and 2.5.32?
  I'm basically a trained monkey when it comes to debugging this kind of thing, so I'm
  going to have to try the old "back out a patch and see if it works" technique.

  My config file is pretty bare-bones, I've tried with and without the "mem=nopentium"
  and "noauto" kernel parameters (as dredged up via Google).  I've also tried replacing
  setup.S from v2.5.31, this just immediately reboots.

Any help would be greatly appreciated,
--Jim

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1391.718
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2778.72

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_BLK_DEV_FD=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_INET=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_I8042_REG_BASE=60
CONFIG_I8042_KBD_IRQ=1
CONFIG_I8042_AUX_IRQ=12
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_VIA=y
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_3=m
CONFIG_USB=y
CONFIG_SECURITY_CAPABILITIES=y

