Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262736AbTC0BGR>; Wed, 26 Mar 2003 20:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262737AbTC0BGR>; Wed, 26 Mar 2003 20:06:17 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:51179 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S262736AbTC0BGN>; Wed, 26 Mar 2003 20:06:13 -0500
Message-ID: <3E8252A2.3080501@seme.com.au>
Date: Thu, 27 Mar 2003 09:23:46 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE problem in 2.4.21-pre1 --> pre5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

Just upgraded a system I am developing from 2.4.20 to 2.4.21-preX and 
noticed this 20 second hang with ide on bootup.

I am loading a system from a CF card using 2.4.19 as a bootstrap using 
two kernel monte to load the new kernel off the filesystem.

With 2.4.20 this was smooth and quick, with the new ide in 2.4.21-pre
it hangs for about 20 seconds while detecting the flash disk. It 
proceeds fine from here after resetting the interface, but it never used 
to do this. I have tried most combinations of config settings, and 
cmdline settings like ide=nodma hda=autotune hda=flash and whaterver 
else I could find in ide.c that looked like a likley suspect. Also tried 
with use Multimode by default and DMA by default.

Hardware is VIA EPIA800 Mini-ITX board with a homebrew ide-CF adapter.
This has not been an issue previously.

Kernels 2.4.21-pre1 --> pre5 all behave the same.

dmesg snip and .config | grep ^[C] follow.

==================
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: APACER_CF_32MB, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: lost interrupt
hda: task_no_data_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: 62976 sectors (32 MB) w/1KiB Cache, CHS=123/16/32
Partition check:
  hda:hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
  hda1 hda2
NET4: Linux TCP/IP 1.0 for NET4.0

==================


CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_M486=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=4
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_ISA=y
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_TULIP=m
CONFIG_EEPRO100=m
CONFIG_NE2K_PCI=m
CONFIG_VIA_RHINE=m
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_USB=m
CONFIG_USB_UHCI=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_FTDI_SIO=m

-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

