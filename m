Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAWWUM>; Tue, 23 Jan 2001 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131203AbRAWWUD>; Tue, 23 Jan 2001 17:20:03 -0500
Received: from dns2.chaven.com ([207.238.162.18]:53127 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S129983AbRAWWT4>;
	Tue, 23 Jan 2001 17:19:56 -0500
Message-ID: <00a301c0858a$7e9be1a0$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <x888zo29jyj.fsf@adglinux1.hns.com>
Subject: Kernel panic v2.4.0 (P3CPU/Tyan S2505MB)
Date: Tue, 23 Jan 2001 16:18:59 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry to bug this list but I hope that someone here can help me
pin-point a problem with a kernel panic.  I am currently running
v2.4.0 on several tyan S1668 MB's.  I went to migrate to the new
Tyan S2505 MB.  I run the kernel monolithic, and have the built-in
video (ATI Rage) enabled, built-in Promise FastTrak raid disabled.
Everything else standard.

Any help would be appreciated.  If more information is needed please
let me know.

This is what I got and the ksymoops output:

----------------------<panic text copied from screen>------
/dev/scsi/host0/bus0/target3/lun0: p1
linear personality registered
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1541.526 MB/sec
   32regs    :  1171.194 MB/sec
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01d3b95>]
EFLAGS: 00010206
eax: dffedf5c   ebx: c190ef40   ecx: 0000000f   edx: 8005003b
esi: c190c000   edi: 00000001   ebp: 00000000   esp: dffedf54
ds: 0018        es: 0018        ss: 0018
Process swapper ( pid:1, stackpage=dffed000)
Stack:  00000000 000004a3 00000001 c027b244 c02cd383 c0116fe7 00000493
000004a2
        00000005 00000c42 00000282 00000001 c02cd383 00000020 c01d4d82
c0266ece
        c0266ec7 00000493 c01d4d12 00000f40 c190e000 c190ef40 c190c000
c190ef40
Call Trace: [<c0116fe7>] [<c01d4d82>] [<c01d4d12>] [<c01d4e0b7>]
[<c01070e9>] [<c01074bc>]
Code:   0f 11 00 0f 11 48 10 0f 11 50 20 0f 11 58 30 0f 18 4e 00 0f
Kernel Panic:   Attempted to kill init!
---------> Ksymooops output <------
ksymoops 2.3.7 on i686 2.4.0.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01d3b95>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: dffedf5c   ebx: c190ef40   ecx: 0000000f   edx: 8005003b
esi: c190c000   edi: 00000001   ebp: 00000000   esp: dffedf54
ds: 0018        es: 0018        ss: 0018
Process swapper ( pid:1, stackpage=dffed000)
Stack:  00000000 000004a3 00000001 c027b244 c02cd383 c0116fe7 00000493
000004a2
        00000005 00000c42 00000282 00000001 c02cd383 00000020 c01d4d82
c0266ece
        c0266ec7 00000493 c01d4d12 00000f40 c190e000 c190ef40 c190c000
c190ef40
Call Trace: [<c0116fe7>] [<c01d4d82>] [<c01d4d12>] [<c01d4e0b7>]
[<c01070e9>] [<c01074bc>]
Code:   0f 11 00 0f 11 48 10 0f 11 50 20 0f 11 58 30 0f 18 4e 00 0f

>>EIP; c01d3b95 <xor_sse_2+1d/1dc>   <=====
Trace; c0116fe7 <printk+167/174>
Trace; c01d4d82 <do_xor_speed+c2/cc>
Trace; c01d4d12 <do_xor_speed+52/cc>
Trace; c01d4e0b7 <END_OF_CODE+b41a44ca3/????>
Trace; c01070e9 <init+e9/160>
Trace; c01074bc <kernel_thread+28/38>
Code;  c01d3b95 <xor_sse_2+1d/1dc>
00000000 <_EIP>:
Code;  c01d3b95 <xor_sse_2+1d/1dc>   <=====
   0:   0f 11 00                  movups %xmm0,(%eax)   <=====
Code;  c01d3b98 <xor_sse_2+20/1dc>
   3:   0f 11 48 10               movups %xmm1,0x10(%eax)
Code;  c01d3b9c <xor_sse_2+24/1dc>
   7:   0f 11 50 20               movups %xmm2,0x20(%eax)
Code;  c01d3ba0 <xor_sse_2+28/1dc>
   b:   0f 11 58 30               movups %xmm3,0x30(%eax)
Code;  c01d3ba4 <xor_sse_2+2c/1dc>
   f:   0f 18 4e 00               prefetcht0 0x0(%esi)
Code;  c01d3ba8 <xor_sse_2+30/1dc>
  13:   0f 00 00                  sldt   (%eax)

Kernel Panic:   Attempted to kill init!
---------------> .config options that are enabled for kernel <-----

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_M586=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_DAC960=y
CONFIG_LOOP_DEP=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_BOOT=y
CONFIG_AUTODETECT_RAID=y
CONFIG_BLK_DEV_LVM=y
CONFIG_LVM_PROC_FS=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_DE4X5=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_ISO9660_FS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

---------------------------------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
