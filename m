Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTGCTlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTGCTlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:41:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:32495 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265295AbTGCTlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:41:39 -0400
Date: Thu, 03 Jul 2003 12:44:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 870] New: kernel BUG at fs/xfs/support/debug.c:106! 
Message-ID: <597600000.1057261472@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=870

           Summary: kernel BUG at fs/xfs/support/debug.c:106!
    Kernel Version: 2.5.73-bk9
            Status: NEW
          Severity: normal
             Owner: hch@sgi.com
         Submitter: robbiew@us.ibm.com


Distribution: SuSE 8.0



Hardware Environment:
---------------------
 # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.267
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1380.35

# cat /proc/meminfo
MemTotal:      4306492 kB
MemFree:          5564 kB
Buffers:        384620 kB
Cached:        3615820 kB
SwapCached:          0 kB
Active:         463532 kB
Inactive:      3543660 kB
HighTotal:     3440612 kB
HighFree:         1280 kB
LowTotal:       865880 kB
LowFree:          4284 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
Dirty:           56052 kB
Writeback:           0 kB
Mapped:          10548 kB
Slab:           215456 kB
Committed_AS:    22476 kB
PageTables:        364 kB
VmallocTotal:   114680 kB
VmallocUsed:      2184 kB
VmallocChunk:   112496 kB

 # mount
/dev/sda3 on / type ext2 (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw)
/dev/sda1 on /boot type ext2 (rw)
/dev/sdb1 on /nfsserver/ext3 type ext3 (rw)
/dev/sdc1 on /nfsserver/jfs type jfs (rw)
/dev/sdd1 on /nfsserver/reiserfs type reiserfs (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)




Software Environment:
 # sh ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux vega 2.5.73 #3 SMP Mon Jun 23 16:18:55 CDT 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11z
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0

CONFIG_SOUND=y

# 
# Advanced Linux Sound Architecture
# 
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

# 
# Generic devices
# 
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

# 
# ISA devices
# 
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

# 
# PCI devices
# 
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

# 
# ALSA USB devices
# 
# CONFIG_SND_USB_AUDIO is not set

# 
# PCMCIA devices
# 
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_VXP440 is not set

# 
# Open Sound System
# 
# CONFIG_SOUND_PRIME is not set

# 
# USB support
# 
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

# 
# Miscellaneous USB options
# 
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

# 
# USB Host Controller Drivers
# 
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y

# 
# USB Device Class drivers
# 
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

# 
# USB Human Interface Devices (HID)
# 
# CONFIG_USB_HID is not set

# 
# USB HID Boot Protocol drivers
# 
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

# 
# USB Imaging devices
# 
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

# 
# USB Multimedia devices
# 
# CONFIG_USB_DABUSB is not set

# 
# Video4Linux support is needed for USB Multimedia device support
# 

# 
# USB Network adaptors
# 
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

# 
# USB port drivers
# 
# CONFIG_USB_USS720 is not set

# 
# USB Serial Converter support
# 
# CONFIG_USB_SERIAL is not set

# 
# USB Miscellaneous drivers
# 
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

# 
# Bluetooth support
# 
# CONFIG_BT is not set

# 
# Profiling support
# 
# CONFIG_PROFILING is not set

# 
# Kernel hacking
# 
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_KALLSYMS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=y

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


Problem Description: While attempting to run the test scenario described at 
http://ltp.sf.net/nfs, the following BUG was caught on the NFS server:
=========================================
xfs_iget_core: ambiguous vns: vp/0xcd89a1c4, invp/0xedf84224
------------[ cut here ]------------
kernel BUG at fs/xfs/support/debug.c:106!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[cmn_err+138/164]    Not tainted
EFLAGS: 00010246
EIP is at cmn_err+0x8a/0xa4
eax: 00000040   ebx: 00000293   ecx: 00000001   edx: c04b37c4
esi: c04380e7   edi: c05955de   ebp: f331db60   esp: f331db40
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1843, threadinfo=f331c000 task=f3332ce0)
Stack: c04380e7 c043809c c05955a0 f743aad8 f77dc634 00000008 00000010 00000000 
       f331db8c c02386a1 00000000 c0433e40 cd89a1c4 edf84224 edf84244 edf84224 
       00000008 f7df2cb8 ea750890 f331dbc8 c02389e8 edf84224 f77dc510 00000000 
Call Trace:
 [xfs_iget_core+249/988] xfs_iget_core+0xf9/0x3dc
 [xfs_iget+100/272] xfs_iget+0x64/0x110
 [xfs_vget+66/172] xfs_vget+0x42/0xac
 [vfs_vget+37/44] vfs_vget+0x25/0x2c
 [linvfs_get_dentry+66/124] linvfs_get_dentry+0x42/0x7c
 [find_exported_dentry+55/1552] find_exported_dentry+0x37/0x610
 [ip_generic_getfrag+0/140] ip_generic_getfrag+0x0/0x8c
 [udp_sendmsg+1684/1844] udp_sendmsg+0x694/0x734
 [sock_alloc_send_skb+27/36] sock_alloc_send_skb+0x1b/0x24
 [ip_append_data+667/1624] ip_append_data+0x29b/0x658
 [udp_sendmsg+1549/1844] udp_sendmsg+0x60d/0x734
 [ip_generic_getfrag+0/140] ip_generic_getfrag+0x0/0x8c
 [udp_sendmsg+1684/1844] udp_sendmsg+0x694/0x734
 [inet_sendmsg+64/72] inet_sendmsg+0x40/0x48
 [sock_sendmsg+134/164] sock_sendmsg+0x86/0xa4
 [inet_sendmsg+64/72] inet_sendmsg+0x40/0x48
 [sock_no_sendpage+113/144] sock_no_sendpage+0x71/0x90
 [sock_no_sendpage+130/144] sock_no_sendpage+0x82/0x90
 [exp_find_key+76/92] exp_find_key+0x4c/0x5c
 [export_decode_fh+96/105] export_decode_fh+0x60/0x69
 [nfsd_acceptable+0/224] nfsd_acceptable+0x0/0xe0
 [fh_verify+822/1260] fh_verify+0x336/0x4ec
 [nfsd_acceptable+0/224] nfsd_acceptable+0x0/0xe0
 [nfsd_lookup+113/988] nfsd_lookup+0x71/0x3dc
 [nfsd_proc_lookup+144/164] nfsd_proc_lookup+0x90/0xa4
 [nfsd_dispatch+222/412] nfsd_dispatch+0xde/0x19c
 [svc_process+973/1632] svc_process+0x3cd/0x660
 [nfsd+317/644] nfsd+0x13d/0x284
 [nfsd+0/644] nfsd+0x0/0x284
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

Code: 0f 0b 6a 00 ce 80 43 c0 8d b6 00 00 00 00 8d 65 ec 5b 5e 5f 
=========================================

Steps to reproduce: Execute the test scenario described in the NFS 2.5 Test 
Plan for approximately 2 hours.


