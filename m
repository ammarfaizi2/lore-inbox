Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTBPAvb>; Sat, 15 Feb 2003 19:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTBPAvb>; Sat, 15 Feb 2003 19:51:31 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55469 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265197AbTBPAv2>; Sat, 15 Feb 2003 19:51:28 -0500
Date: Sat, 15 Feb 2003 17:01:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 363] New: ACPI && SMP -> hard lockup within 5 min. 
Message-ID: <32770000.1045357277@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=363

           Summary: ACPI && SMP -> hard lockup within 5 min.
    Kernel Version: 2.5.61
            Status: NEW
          Severity: normal
             Owner: andrew.grover@intel.com
         Submitter: tim@physik3.uni-rostock.de


Distribution: SuSE 7.0 (modified to run kernel 2.4)
Hardware Environment:dual P3-850 on Asus P2B-DS (Intel BX chipset), 128 Mb
ECC RAM, 30 GB UDMA-33 HD , RTL8029-based Ethernet card 
Software Environment: Kernel 2.5.61, GCC 2.95.3, in-tree ACPI, no modules
Problem Description:

With both ACPI and SMP enabled the machine will lock up hard (no oops, no
keyboard) within about approx. 5 minutes.
Problem occurs with kernels 2.5.60 and 2.5.61, but not with 2.5.59.
Problem does not occur if either ACPI or SMP is turned off.

Steps to reproduce:

Compile kernel with 'Symmetric multi-processing support' and 'ACPI support'
both set to yes. Install, boot, wait.
To (maybe) trigger the bug more likely build a new kernel. My box never
survived a whole build with this configuration.

.config excerpt:
# 
# Automatically generated make config: don't edit
# 
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

# 
# Code maturity level options
# 
CONFIG_EXPERIMENTAL=y

# 
# General setup
# 
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15

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
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
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
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=y
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_NR_CPUS=2
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

# 
# Power management options (ACPI, APM)
# 
# CONFIG_PM is not set

# 
# ACPI Support
# 
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_CPU_FREQ is not set


