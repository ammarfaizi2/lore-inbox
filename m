Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUADHs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 02:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUADHs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 02:48:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9822 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264419AbUADHsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 02:48:11 -0500
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1-tiny1 tree for small systems
References: <20040103030814.GG18208@waste.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2004 00:42:43 -0700
In-Reply-To: <20040103030814.GG18208@waste.org>
Message-ID: <m13cawi2h8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Matt Mackall <mpm@selenic.com> writes:

> Contributions and suggestions are encouraged. In particular, it would
> be helpful if people with non-x86 hardware could take a stab at
> extending some of the stuff that's currently only been done for X86 to
> other architectures.

I just tried a kernel build with as much as possible turned off.  This
uncovered a couple of bugs, which I fixed with the attached diff.  But
it looks like there finally is a light at the end of the rainbow.

220K compressed and 371K uncompressed.  This is a serious reduction from
previous versions.  There is still a huge amount of code I can't compile
out but this is certainly progress.  Thank you.

Eric

$ size vmlinux 
   text	   data	    bss	    dec	    hex	filename
 371813	  29914	  24620	 426347	  6816b	vmlinux

$ ls -l arch/i386/boot/bzImage 
-rw-r--r--    1 eric     eric       220348 Jan  4 00:22 arch/i386/boot/bzImage


gcc-3.3 --version
gcc-3.3 (GCC) 3.3.2 20030908 (Debian prerelease)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


--=-=-=
Content-Disposition: attachment; filename=.config

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_SYSCTL is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
CONFIG_EMBEDDED=y
CONFIG_CORE_SMALL=y
CONFIG_NET_SMALL=y
CONFIG_CONSOLE_SMALL=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX is not set
# CONFIG_CPU_SUP_NSC is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_TRANSMETA is not set
# CONFIG_CPU_SUP_RISE is not set
# CONFIG_CPU_SUP_NEXGEN is not set
# CONFIG_CPU_SUP_UMC is not set
# CONFIG_KALLSYMS is not set
# CONFIG_FUTEX is not set
# CONFIG_EPOLL is not set
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_MEASURE_INLINES is not set
# CONFIG_IRQ_DEBUG is not set
# CONFIG_FULL_STACK is not set
# CONFIG_AUDIT_BOOTMEM is not set
# CONFIG_KMALLOC_ACCOUNTING is not set
CONFIG_HERTZ=1000
CONFIG_MAX_USER_RT_PRIO=5
# CONFIG_VM86 is not set
# CONFIG_AIO is not set
# CONFIG_DOUBLEFAULT is not set
# CONFIG_SYSFS is not set
# CONFIG_PRINTK is not set
# CONFIG_BUG is not set
CONFIG_PANIC=y
# CONFIG_FULL_PANIC is not set
# CONFIG_ELF_CORE is not set
# CONFIG_KCORE is not set
CONFIG_MAX_SWAPFILES_SHIFT=0
CONFIG_NR_LDISCS=0
# CONFIG_DMI_SCAN is not set
# CONFIG_CONSOLE_TRANSLATIONS is not set
# CONFIG_SLAB is not set
# CONFIG_TCP_DIAG is not set
# CONFIG_INETPEER is not set
# CONFIG_INLINE_THREADINFO is not set
# CONFIG_DNOTIFY is not set
# CONFIG_PTRACE is not set
# CONFIG_SYSENTER is not set
CONFIG_TINY_CFLAGS=y
CONFIG_TINY_CFLAGS_VAL="-march=i386"
CONFIG_SLOB=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
CONFIG_M486=y
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_BUG=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
# CONFIG_HPET_TIMER is not set
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
# CONFIG_PCI is not set
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#

#
# Networking support
#
# CONFIG_NET is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
# CONFIG_INPUT is not set

#
# Userland interfaces
#

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_SERIO is not set
# CONFIG_SERIO_I8042 is not set

#
# Input Device Drivers
#

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_UNIX98_PTYS is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Algorithms
#

#
# I2C Hardware Bus support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#

#
# Graphics support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
# CONFIG_PROC_FS is not set
# CONFIG_DEVFS_FS is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_X86_BIOS_REBOOT=y

--=-=-=
Content-Disposition: attachment;
  filename=linux-2.6.1-rc1-tiny1.eb1.diff

diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/arch/i386/kernel/cpu/common.c linux-2.6.1-rc1-tiny1.eb1/arch/i386/kernel/cpu/common.c
--- linux-2.6.1-rc1-tiny1/arch/i386/kernel/cpu/common.c	Sun Jan  4 00:03:51 2004
+++ linux-2.6.1-rc1-tiny1.eb1/arch/i386/kernel/cpu/common.c	Sun Jan  4 00:21:05 2004
@@ -421,7 +421,6 @@
  * They will insert themselves into the cpu_devs structure.
  * Then, when cpu_init() is called, we can just iterate over that array.
  */
-
 extern int intel_cpu_init(void);
 extern int cyrix_init_cpu(void);
 extern int nsc_init_cpu(void);
@@ -431,6 +430,34 @@
 extern int rise_init_cpu(void);
 extern int nexgen_init_cpu(void);
 extern int umc_init_cpu(void);
+
+#ifndef CONFIG_CPU_SUP_INTEL
+#define intel_cpu_init() 
+#endif
+#ifndef CONFIG_CPU_SUP_CYRIX
+#define cyrix_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_NSC
+#define nsc_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_AMD
+#define amd_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_CENTAUR
+#define centaur_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_TRANSMETA
+#define transmeta_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_RISE
+#define rise_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_NEXGEN
+#define nexgen_init_cpu() 
+#endif
+#ifndef CONFIG_CPU_SUP_UMC
+#define umc_init_cpu() 
+#endif
 
 void __init early_cpu_init(void)
 {
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/arch/i386/mm/init.c linux-2.6.1-rc1-tiny1.eb1/arch/i386/mm/init.c
--- linux-2.6.1-rc1-tiny1/arch/i386/mm/init.c	Sun Jan  4 00:03:51 2004
+++ linux-2.6.1-rc1-tiny1.eb1/arch/i386/mm/init.c	Sun Jan  4 00:22:36 2004
@@ -444,9 +444,14 @@
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 #endif
 
+#ifdef CNFIG_CPU_SUP_INTEL
+extern int ppro_with_ram_bug(void);
+#else
+static inline int ppro_with_ram_bug(void) { return 0; }
+#endif
+
 void __init mem_init(void)
 {
-	extern int ppro_with_ram_bug(void);
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 	int bad_ppro;
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/kernel/Makefile linux-2.6.1-rc1-tiny1.eb1/kernel/Makefile
--- linux-2.6.1-rc1-tiny1/kernel/Makefile	Wed Dec 17 19:58:18 2003
+++ linux-2.6.1-rc1-tiny1.eb1/kernel/Makefile	Sun Jan  4 00:02:11 2004
@@ -4,10 +4,11 @@
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    exit.o itimer.o time.o softirq.o resource.o \
-	    sysctl.o capability.o ptrace.o timer.o user.o \
+	    sysctl.o capability.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
 
+obj-$(CONFIG_PTRACE) += ptrace.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -uNr -X linux-ignore-files linux-2.6.1-rc1-tiny1/kernel/printk.c linux-2.6.1-rc1-tiny1.eb1/kernel/printk.c
--- linux-2.6.1-rc1-tiny1/kernel/printk.c	Sun Jan  4 00:03:57 2004
+++ linux-2.6.1-rc1-tiny1.eb1/kernel/printk.c	Sat Jan  3 23:59:30 2004
@@ -101,10 +101,10 @@
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
 
-#ifdef CONFIG_PRINTK
-
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
+
+#ifdef CONFIG_PRINTK
 
 /*
  *	Setup a list of consoles. Called from init/main.c

--=-=-=--
