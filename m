Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTAIL2i>; Thu, 9 Jan 2003 06:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTAIL2i>; Thu, 9 Jan 2003 06:28:38 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:62709 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264931AbTAIL2f>; Thu, 9 Jan 2003 06:28:35 -0500
Date: Thu, 9 Jan 2003 06:42:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030109114206.GA776@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This oops came up running dbench 32 on AMD K6/2.
dbench 32 runs okay on 2.4.21-pre3 on same hardware.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0129c6b
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0129c6b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c13d1acc   ecx: d6ef2000   edx: d6ef205c
esi: c13d1acc   edi: 00000000   ebp: 00003759   esp: d6ef3e50
ds: 0018   es: 0018   ss: 0018
Process dbench (pid: 713, stackpage=d6ef3000)
Stack: c0132f3e 00000000 d71d0924 001f8713 00000000 00000000 c13d1acc c13d1acc
       c13d1acc 00000020 00003759 c012930c 00000000 d6ef2000 00000200 000001d2
       c0257270 00001602 001f8714 c1549ae0 00000000 00000020 000001d2 00000006
Call Trace:    [<c0132f3e>] [<c012930c>] [<c0129486>] [<c01294ec>] [<c0129f44>]
  [<c012a1fb>] [<c012550e>] [<c012f2e8>] [<c012f05e>] [<c0106db3>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 7b 0c ff 41 68 83 c4 1c

>>EIP; c0129c6b <__free_pages_ok+26b/290>   <=====
Trace; c0132f3e <try_to_free_buffers+9e/f0>
Trace; c012930c <shrink_cache+32c/350>
Trace; c0129486 <shrink_caches+56/80>
Trace; c01294ec <try_to_free_pages_zone+3c/60>
Trace; c0129f44 <balance_classzone+54/1f0>
Trace; c012a1fb <__alloc_pages+11b/180>
Trace; c012550e <generic_file_write+47e/7a0>
Trace; c012f2e8 <sys_write+98/100>
Trace; c012f05e <sys_lseek+6e/80>
Trace; c0106db3 <system_call+33/40>
Code;  c0129c6b <__free_pages_ok+26b/290>
00000000 <_EIP>:
Code;  c0129c6b <__free_pages_ok+26b/290>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0129c6e <__free_pages_ok+26e/290>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0129c70 <__free_pages_ok+270/290>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c0129c73 <__free_pages_ok+273/290>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c0129c76 <__free_pages_ok+276/290>
   b:   89 7b 0c                  mov    %edi,0xc(%ebx)
Code;  c0129c79 <__free_pages_ok+279/290>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c0129c7c <__free_pages_ok+27c/290>
  11:   83 c4 1c                  add    $0x1c,%esp


1 warning and 1 error issued.  Results may not be reliable.

grep ^C /usr/src/linux/.config

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64
CONFIG_REISERFS_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

