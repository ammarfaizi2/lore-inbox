Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290497AbSAYCRh>; Thu, 24 Jan 2002 21:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSAYCR3>; Thu, 24 Jan 2002 21:17:29 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:34445 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290497AbSAYCRR>; Thu, 24 Jan 2002 21:17:17 -0500
Date: Thu, 24 Jan 2002 21:21:08 -0500
To: linux-kernel@vger.kernel.org
Subject: Oops from 2.5.3-pre5
Message-ID: <20020124212108.B901@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This oops came at boot time.  
kysmoops ran with /usr/src/linux/System.map = 2.5.3-pre5.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0124f45>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: 00000014   edx: 00000000
esi: c021ffd4   edi: c01f22c8   ebp: 00002000   esp: c177df94
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c177d000)
Stack: c02514b4 c021ffd4 00000000 0008e000 c177dfb0 c16069a0 00000020 c02116ac
       c015bf35 c01f22b3 00000184 00000000 00002000 c015bef0 00000000 c0227d96
       c02514b4 c0220646 00010f00 c0220682 c0105023 00010f00 c021ffd4 c0106ee0
Call Trace: [<c015bf35>] [<c015bef0>] [<c0105023>] [<c0106ee0>]
Code: 0f 0b f7 c5 ff 0f ff ff 74 02 0f 0b 68 f0 01 00 00 68 40 f8

>>EIP; c0124f44 <kmem_cache_create+60/314>   <=====
Trace; c015bf34 <init_inodecache+1c/34>
Trace; c015bef0 <init_once+0/28>
Trace; c0105022 <init+6/114>
Trace; c0106ee0 <kernel_thread+28/38>
Code;  c0124f44 <kmem_cache_create+60/314>
00000000 <_EIP>:
Code;  c0124f44 <kmem_cache_create+60/314>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0124f46 <kmem_cache_create+62/314>
   2:   f7 c5 ff 0f ff ff         test   $0xffff0fff,%ebp
Code;  c0124f4c <kmem_cache_create+68/314>
   8:   74 02                     je     c <_EIP+0xc> c0124f50 <kmem_cache_create+6c/314>
Code;  c0124f4e <kmem_cache_create+6a/314>
   a:   0f 0b                     ud2a
Code;  c0124f50 <kmem_cache_create+6c/314>
   c:   68 f0 01 00 00            push   $0x1f0
Code;  c0124f54 <kmem_cache_create+70/314>
  11:   68 40 f8 00 00            push   $0xf840

 <0>Kernel panic: Attempted to kill init!


CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
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
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
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
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

-- 
Randy Hron

