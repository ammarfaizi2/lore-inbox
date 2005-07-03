Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVGCImQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVGCImQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 04:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVGCImQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 04:42:16 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:52107 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261213AbVGCIl6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 04:41:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DFbMkHOKbWZLjI95ZSFc369hIEX/zwZqLJC+oD8Uk2HCdhAOxdjFcZpbdrw2A7ySIUhTxxT3qLY3UyxdIb/r8dzbxifUiAmlKvTdPcw/XSwDIceRXSgiHVbpETpKxXkcpiPvatKjtvMZgb0kWWNZaUmQsJrBgWAAlsGoOoYU4DI=
Message-ID: <a44ae5cd05070301417531fac2@mail.gmail.com>
Date: Sun, 3 Jul 2005 01:41:57 -0700
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mtrr: base(0xe8020000) is not aligned on a size(0x3c0000) boundary
[drm:drm_unlock] *ERROR* Process 4470 using kernel context 0
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x1000000
Unable to handle kernel paging request at virtual address 5f78735f
 printing eip:
c01abbf9
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: pcmcia container ipv6 af_packet ohci1394
yenta_socket rsrc_nonstatic pcmcia_core ipw2200 ieee80211
ieee80211_crypt 8139too mii snd_intel8x0 snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd
uhci_hcd usbcore rtc nls_cp437 sbp2 scsi_mod ieee1394 psmouse ide_cd
cdrom
CPU:    0
EIP:    0060:[<c01abbf9>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13-rc1-mm1)
EIP is at sysfs_release+0x49/0xb0
eax: 5f78725f   ebx: 5f78725f   ecx: 00000001   edx: f7662000
esi: c19520a4   edi: f70b8a80   ebp: f7663f3c   esp: f7663f2c
ds: 007b   es: 007b   ss: 0068
Process hald (pid: 4736, threadinfo=f7662000 task=f7c97a80)
Stack: c19520a4 00000010 f70d2d80 f7703174 f7663f68 c0169a5a f7703174 f70d2d80
       00000000 00000000 c1894180 f7715c8c f70d2d80 c1bcd900 00000000 f7663f78
       c016985a f70d2d80 f70d2d80 f7663f94 c0167dcb f70d2d80 c1bcd900 00000010
Call Trace:
 [<c010415f>] show_stack+0x7f/0xa0
 [<c0104314>] show_registers+0x164/0x1d0
 [<c010452d>] die+0xed/0x180
 [<c0119314>] do_page_fault+0x344/0x68d
 [<c0103d6f>] error_code+0x4f/0x54
 [<c0169a5a>] __fput+0x1da/0x1f0
 [<c016985a>] fput+0x2a/0x50
 [<c0167dcb>] filp_close+0x4b/0x80
 [<c0167e7a>] sys_close+0x7a/0xb0
 [<c010326b>] sysenter_past_esp+0x54/0x75
Code: 85 f6 8b 40 14 8b 58 04 74 08 89 34 24 e8 60 a3 07 00 85 db 74
38 b8 01 00 00 00 e8 b2 25 f7 ff e8 ed f2 07 00 c1 e0 07 8d 04 18 <ff>
88 00 01 00 00 83 3b 02 74 43 b8 01 00 00 00 e8 d2 25 f7 ff
 <6>note: hald[4736] exited with preempt_count 1
scheduling while atomic: hald/0x10000001/4736
 [<c010419e>] dump_stack+0x1e/0x30
 [<c0362052>] schedule+0x682/0x690
 [<c0362a5f>] cond_resched+0x2f/0x50
 [<c015738d>] unmap_vmas+0x16d/0x200
 [<c015c2c1>] exit_mmap+0x81/0x170
 [<c011f982>] mmput+0x42/0x110
 [<c0123f63>] exit_mm+0xe3/0x110
 [<c0124980>] do_exit+0x100/0x550
 [<c01045bf>] die+0x17f/0x180
 [<c0119314>] do_page_fault+0x344/0x68d
 [<c0103d6f>] error_code+0x4f/0x54
 [<c0169a5a>] __fput+0x1da/0x1f0
 [<c016985a>] fput+0x2a/0x50
 [<c0167dcb>] filp_close+0x4b/0x80
 [<c0167e7a>] sys_close+0x7a/0xb0
 [<c010326b>] sysenter_past_esp+0x54/0x75
eth1: no IPv6 routers present

CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_TOSHIBA=m
CONFIG_I8K=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HIGHPTE=y
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_EFI=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_BOOT_IOREMAP=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m

CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_I830=y

CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#
CONFIG_I2C_I801=y
CONFIG_I2C_I810=y
CONFIG_I2C_ISA=m

CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SOFT_CURSOR=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y

0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O
Control Registers (rev 02)
0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH
Configuration Process Registers (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:02:06.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
0000:02:09.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:02:09.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032
0000:02:09.3 Unknown mass storage controller: Texas Instruments:
Unknown device 8033
0000:02:09.4 0805: Texas Instruments: Unknown device 8034
