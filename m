Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291729AbSB0D56>; Tue, 26 Feb 2002 22:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSB0D5t>; Tue, 26 Feb 2002 22:57:49 -0500
Received: from mx2.fuse.net ([216.68.1.120]:23708 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S291729AbSB0D5h>;
	Tue, 26 Feb 2002 22:57:37 -0500
Message-ID: <3C7C5930.6010703@fuse.net>
Date: Tue, 26 Feb 2002 22:57:36 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5-dj2 compile failures
In-Reply-To: <3C7C4BBF.2020505@fuse.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This *might * just be a FAQ, but I think it's actually a 
Makefile bug (it's happened twice, each time after a make mrproper).

$ strings vmlinux | grep __ver
__verify_write_Rsmp_203afbeb
vmalloc_to_page_R__ver_vmalloc_to_page
idle_cpu_R__ver_idle_cpu
set_cpus_allowed_R__ver_set_cpus_allowed

The first is not a problem, but the rest are.  Grepping 
include/linux/modules/* gave no matches:
$ find include/linux/modules/* | xargs grep -e idle_cpu
$ find include/linux/modules/* | xargs grep -e set_cpu
$ find include/linux/modules/* | xargs grep -e vmalloc_to_page

Config (I think this is all that matters... if something else is needed, 
lemme know.):
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM4G_HIGHPTE is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM64G_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y




