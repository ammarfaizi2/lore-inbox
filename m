Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319146AbSIJOlC>; Tue, 10 Sep 2002 10:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319148AbSIJOlC>; Tue, 10 Sep 2002 10:41:02 -0400
Received: from angband.namesys.com ([212.16.7.85]:2176 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319146AbSIJOkw>; Tue, 10 Sep 2002 10:40:52 -0400
Date: Tue, 10 Sep 2002 18:45:37 +0400
From: Oleg Drokin <green@namesys.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 BUG at kernel/sched.c:944 (partitions code related?)
Message-ID: <20020910184537.A856@namesys.com>
References: <20020910175639.A830@namesys.com> <20020910140622.GX8719@suse.de> <20020910181153.B1095@namesys.com> <20020910142444.GB8719@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020910142444.GB8719@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 10, 2002 at 04:24:44PM +0200, Jens Axboe wrote:

> ok, then please give me the full trace regardless.

Linux version 2.5.34 (green@angband) (gcc version 2.95.3 20010315 (SuSE)) #1 SMP Tue Sep 10 13:26:35 MSD 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003ffffc00 (ACPI data)
 BIOS-e820: 000000003ffffc00 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7510
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262128
  DMA zone: 4096 pages
  Normal zone: 225280 pages
  HighMem zone: 32752 pages
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
Processor #1 6:6 APIC version 16
Processor #0 6:6 APIC version 16
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=t ro root=302 BOOT_FILE=/boot/t enableapic apm=off mem=nopentium hdc=ide-scsi console=ttyS0,38400 console=tty0 profile=2 root=/dev/hda1
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1460.174 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2883.58 BogoMIPS
Memory: 1031924k/1048512k available (1324k kernel code, 16200k reserved, 675k data, 92k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU0: AMD Athlon(tm) MP Processor 1700+ stepping 02
per-CPU timeslice cutoff: 731.02 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2916.35 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (5799.93 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1459.0951 MHz.
..... host bus clock speed is 265.0445 MHz.
cpu: 0, clocks: 265445, slice: 8043
CPU0<T0:265440,T1:257392,D:5,S:8043,C:265445>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 265445, slice: 8043
CPU1<T0:265440,T1:249344,D:10,S:8043,C:265445>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd7e0, last bus=1
PCI: Using configuration type 1
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
aio_setup: sizeof(struct page) = 44
Capability LSM initialized
BIOS failed to enable PCI standards compliance, fixing this error.
I/O APIC: AMD Errata #22 may be present. In the event of instability try
        : booting with the "noapic" option.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
block: 256 slots per queue, batch=32
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:00:4B:51:08:A3, IRQ 10.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 668081-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
hdb: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: host protected area => 1
hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
 hdb: hdb1
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63
 hda: hda1 hda2 hda3 hda4 < hda5kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0115819>]    Not tainted
EFLAGS: 00010206
eax: c02f4000   ebx: c02f4000   ecx: 00000000   edx: c02f4000
esi: c01053a0   edi: c0105000   ebp: c02f5fd0   esp: c02f5fa8
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c02f4000 task=c02ba7e0)
Stack: c02f4000 c01053a0 c0105000 0008e000 00000000 00000068 00000068 ffffff0e 
       c01053c9 00000060 0008e000 c010547e c02f4000 00000000 c010506d c02f68f1 
       c02ba7e0 00000000 00000000 0009fe00 c0330e60 c01001b1 
Call Trace: [<c01053a0>] [<c0105000>] [<c01053c9>] [<c010547e>] [<c010506d>] 

Code: 0f 0b b0 03 a7 63 25 c0 e8 1a d8 02 00 b8 00 e0 ff ff 21 e0 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

ksymoops 2.4.2 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m System.map (specified)

 hda: hda1 hda2 hda3 hda4 < hda5kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0115819>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c02f4000   ebx: c02f4000   ecx: 00000000   edx: c02f4000
esi: c01053a0   edi: c0105000   ebp: c02f5fd0   esp: c02f5fa8
ds: 0068   es: 0068   ss: 0068
Stack: c02f4000 c01053a0 c0105000 0008e000 00000000 00000068 00000068 ffffff0e 
       c01053c9 00000060 0008e000 c010547e c02f4000 00000000 c010506d c02f68f1 
       c02ba7e0 00000000 00000000 0009fe00 c0330e60 c01001b1 
Call Trace: [<c01053a0>] [<c0105000>] [<c01053c9>] [<c010547e>] [<c010506d>] 
Code: 0f 0b b0 03 a7 63 25 c0 e8 1a d8 02 00 b8 00 e0 ff ff 21 e0 

>>EIP; c0115818 <schedule+18/4a0>   <=====
Trace; c01053a0 <default_idle+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c01053c8 <default_idle+28/40>
Trace; c010547e <cpu_idle+4e/50>
Trace; c010506c <rest_init+6c/70>
Code;  c0115818 <schedule+18/4a0>
00000000 <_EIP>:
Code;  c0115818 <schedule+18/4a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011581a <schedule+1a/4a0>
   2:   b0 03                     mov    $0x3,%al
Code;  c011581c <schedule+1c/4a0>
   4:   a7                        cmpsl  %es:(%edi),%ds:(%esi)
Code;  c011581c <schedule+1c/4a0>
   5:   63 25 c0 e8 1a d8         arpl   %sp,0xd81ae8c0
Code;  c0115822 <schedule+22/4a0>
   b:   02 00                     add    (%eax),%al
Code;  c0115824 <schedule+24/4a0>
   d:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c011582a <schedule+2a/4a0>
  12:   21 e0                     and    %esp,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1141 warnings issued.  Results may not be reliable.


My config:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
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
CONFIG_SMP=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_RTC=m
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=y
CONFIG_USB=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_SECURITY_CAPABILITIES=y
