Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbTCQAEe>; Sun, 16 Mar 2003 19:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbTCQAEe>; Sun, 16 Mar 2003 19:04:34 -0500
Received: from yossman.net ([209.162.234.20]:35076 "EHLO yossman.net")
	by vger.kernel.org with ESMTP id <S261684AbTCQAEX>;
	Sun, 16 Mar 2003 19:04:23 -0500
Message-ID: <3E75138C.7030607@yossman.net>
Date: Sun, 16 Mar 2003 19:15:08 -0500
From: Brian Davids <dlister@yossman.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.64-bk multiple oops on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following oopsen during booting with 2.5.64-bk pulled at 
around 10 AM EST today...  system is running RedHat Phoebe 8.0.94 beta, 
gcc 3.2.1

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05940   ebx: f7997bc0   ecx: 00000000   edx: f7c05940
esi: ffffffed   edi: f7c888c0   ebp: 00000000   esp: f7759f34
ds: 007b   es: 007b   ss: 0068
Process kudzu (pid: 369, threadinfo=f7758000 task=f7ca4cc0)
Stack: f7997bc0 c01a5446 f7c05940 f7759f80 f7c888c0 f7997bc0 f7ffa4c0 
c01482e7
        f7997bc0 f7c888c0 00000802 00000000 f7cee000 f7758000 c0148137 
f79a0200
        f7ffa4c0 00000802 f7759f80 f79a0200 f7ffa4c0 f7cee000 f7cb2d1c 
00000003
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <6>eth0: Setting full-duplex based on MII #1 link partner capability 
of 45e1.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05740   ebx: f79976c0   ecx: 00000000   edx: f7c05740
esi: ffffffed   edi: f73129c0   ebp: 00000000   esp: f7043f34
ds: 007b   es: 007b   ss: 0068
Process parallel (pid: 896, threadinfo=f7042000 task=f7185240)
Stack: f79976c0 c01a5446 f7c05740 f7043f80 f73129c0 f79976c0 f7ffa4c0 
c01482e7
        f79976c0 f73129c0 00000001 ffffffff f7c90000 f7042000 c0148137 
f7994ec0
        f7ffa4c0 00000001 f7043f80 f7994ec0 f7ffa4c0 00000000 f7c1d61c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05940   ebx: f7997bc0   ecx: 00000000   edx: f7c05940
esi: ffffffed   edi: f7407440   ebp: 00000000   esp: f7043f34
ds: 007b   es: 007b   ss: 0068
Process serial (pid: 904, threadinfo=f7042000 task=f7185240)
Stack: f7997bc0 c01a5446 f7c05940 f7043f80 f7407440 f7997bc0 f7ffa4c0 
c01482e7
        f7997bc0 f7407440 00000901 00000000 f7ff3000 f7042000 c0148137 
f79a0200
        f7ffa4c0 00000901 f7043f80 f79a0200 f7ffa4c0 00000000 f7c1d61c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05740   ebx: f79976c0   ecx: 00000000   edx: f7c05740
esi: ffffffed   edi: f7312940   ebp: 00000000   esp: f7043f34
ds: 007b   es: 007b   ss: 0068
Process canon (pid: 925, threadinfo=f7042000 task=f7185240)
Stack: f79976c0 c01a5446 f7c05740 f7043f80 f7312940 f79976c0 f7ffa4c0 
c01482e7
        f79976c0 f7312940 00000002 bffffe04 f7c8f000 f7042000 c0148137 
f7994ec0
        f7ffa4c0 00000002 f7043f80 f7994ec0 f7ffa4c0 00000000 f7c1d61c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05740   ebx: f79976c0   ecx: 00000000   edx: f7c05740
esi: ffffffed   edi: f7312cc0   ebp: 00000000   esp: f7043f34
ds: 007b   es: 007b   ss: 0068
Process epson (pid: 926, threadinfo=f7042000 task=f7185240)
Stack: f79976c0 c01a5446 f7c05740 f7043f80 f7312cc0 f79976c0 f7ffa4c0 
c01482e7
        f79976c0 f7312cc0 00000002 bffffe04 f701c000 f7042000 c0148137 
f7994ec0
        f7ffa4c0 00000002 f7043f80 f7994ec0 f7ffa4c0 00000000 f7c1d61c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05740   ebx: f79976c0   ecx: 00000000   edx: f7c05740
esi: ffffffed   edi: f68213c0   ebp: 00000000   esp: f66aff34
ds: 007b   es: 007b   ss: 0068
Process parallel (pid: 2132, threadinfo=f66ae000 task=f6822180)
Stack: f79976c0 c01a5446 f7c05740 f66aff80 f68213c0 f79976c0 f7ffa4c0 
c01482e7
        f79976c0 f68213c0 00000001 ffffffff f6810000 f66ae000 c0148137 
f7994ec0
        f7ffa4c0 00000001 f66aff80 f7994ec0 f7ffa4c0 00000000 f685229c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05940   ebx: f7997bc0   ecx: 00000000   edx: f7c05940
esi: ffffffed   edi: f67e3f40   ebp: 00000000   esp: f66aff34
ds: 007b   es: 007b   ss: 0068
Process serial (pid: 2146, threadinfo=f66ae000 task=f6822180)
Stack: f7997bc0 c01a5446 f7c05940 f66aff80 f67e3f40 f7997bc0 f7ffa4c0 
c01482e7
        f7997bc0 f67e3f40 00000901 00000000 f691a000 f66ae000 c0148137 
f79a0200
        f7ffa4c0 00000901 f66aff80 f79a0200 f7ffa4c0 00000000 f6ad945c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05740   ebx: f79976c0   ecx: 00000000   edx: f7c05740
esi: ffffffed   edi: f7407ec0   ebp: 00000000   esp: f664ff34
ds: 007b   es: 007b   ss: 0068
Process canon (pid: 2177, threadinfo=f664e000 task=f6822180)
Stack: f79976c0 c01a5446 f7c05740 f664ff80 f7407ec0 f79976c0 f7ffa4c0 
c01482e7
        f79976c0 f7407ec0 00000002 bffffdf4 f68a3000 f664e000 c0148137 
f7994ec0
        f7ffa4c0 00000002 f664ff80 f7994ec0 f7ffa4c0 00000000 f6ad945c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82
  <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
  printing eip:
c01a4c9b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01a4c9b>]    Not tainted
EFLAGS: 00010283
EIP is at devfs_get_ops+0xb/0x40
eax: f7c05740   ebx: f79976c0   ecx: 00000000   edx: f7c05740
esi: ffffffed   edi: f6821140   ebp: 00000000   esp: f664ff34
ds: 007b   es: 007b   ss: 0068
Process epson (pid: 2178, threadinfo=f664e000 task=f6822180)
Stack: f79976c0 c01a5446 f7c05740 f664ff80 f6821140 f79976c0 f7ffa4c0 
c01482e7
        f79976c0 f6821140 00000002 bffffdf4 f680c000 f664e000 c0148137 
f7994ec0
        f7ffa4c0 00000002 f664ff80 f7994ec0 f7ffa4c0 00000000 f6ad945c 
00000000
Call Trace:
  [<c01a5446>] devfs_open+0x76/0xc0
  [<c01482e7>] dentry_open+0x1a7/0x1d0
  [<c0148137>] filp_open+0x67/0x70
  [<c014852b>] sys_open+0x5b/0x90
  [<c0108ef9>] sysenter_past_esp+0x52/0x71

Code: 8b 11 74 1a 85 d2 bb 01 00 00 00 74 0b 83 3a 02 74 10 ff 82

my .config...

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HUGETLB_PAGE=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IPV6_SCTP__=y
CONFIG_LLC=y
CONFIG_IPX=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_RAW_DRIVER=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_EMU10K1=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y


