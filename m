Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSJQMrz>; Thu, 17 Oct 2002 08:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJQMrz>; Thu, 17 Oct 2002 08:47:55 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:48328 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261696AbSJQMrw> convert rfc822-to-8bit; Thu, 17 Oct 2002 08:47:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20pre11aa1
Date: Thu, 17 Oct 2002 23:02:24 +1000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021016165155.GE30254@dualathlon.random> <200210172204.50297.harisri@bigpond.com> <20021017141005.A8863@oldwotan.suse.de>
In-Reply-To: <20021017141005.A8863@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210172302.24409.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> please try to find which is this module, replace modprobe with a script
> that does:
>
> #!/bin/sh
> echo $@ >>/tmp/log
> sync
> modprobe.orig $@

I will try that.

> then look at log after the crash. You said in your last email that the
> gart code wasn't the culprit. If it isn't the sound drivers I've no
> clue what it is. What does it mean the without agpgart it is very
> stable? That it crashes less frequently? (I recalled it crashed even
> without those modules)

Sorry if it was not clear. The -aa kernel crashes _only_ when I have agpgart 
and radeon support (either as modules or as built-in the kernel). If there is 
no agpgart and radeon support enabled, it does not crash.

> It doesn't make any sense that 2.4.20-pre11 works and my tree doesn't,
> there are no changes to those sound and graphics driver. Can you make
> sure that modversions is enabled, and please send me your .config.

Here is my current .config. While this one doesn't have modversions enabled I 
have seen crashes even when it is enabled.

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG8=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_1GB=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_BLK_DEV_FD=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_RAID0=m
CONFIG_PACKET=m
CONFIG_NETFILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
CONFIG_UNIX98_PTYS=y
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_RTC=m
CONFIG_AGP=y
CONFIG_AGP_AMD=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

Thanks
-- 
Hari
harisri@bigpond.com

