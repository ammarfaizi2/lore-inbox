Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271594AbRIBI3F>; Sun, 2 Sep 2001 04:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIBI24>; Sun, 2 Sep 2001 04:28:56 -0400
Received: from quechua.inka.de ([212.227.14.2]:20532 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S271594AbRIBI2p>;
	Sun, 2 Sep 2001 04:28:45 -0400
Date: Sun, 2 Sep 2001 10:10:03 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.9, oops
Message-ID: <20010902101003.A23909@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.3.4 on i686 2.4.2.  Options used
     -v kernel/linux-2.4.9/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.9 (specified)

Status: RO
8139too Fast Ethernet driver 0.9.18a
Unable to handle kernel paging request at virtual address 92917873
c01c55a7
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c55a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: f77800c8   ebx: f75a00c0   ecx: 92917873   edx: f7780000
esi: 00000019   edi: f75a00c0   ebp: c02700c8   esp: f7551eb8
ds: 0018   es: 0018   ss: 0018
Process master (pid: 248, stackpage=3Df7551000)
Stack: f75a00c0 00000019 00000003 c02700c8 00000292 c01dae9b f77800c8
c01d0562
       f75a00c0 00000019 f75882cc f7551f14 00000010 bffffbbc ffffffea
c01a2444
       f75882cc f7551f14 00000010 00000001 0805c488 000001f4 00000000
19000002
Call Trace: [<c01dae9b>] [<c01d0562>] [<c01a2444>] [<c01a32c7>]
[<c01a1871>]
   [<c01a29ec>] [<c01a2a10>] [<c01a2f7c>] [<c0106c2b>]
Code: 66 39 31 75 f4 85 c9 74 68 8b 51 08 85 d2 74 61 66 83 79 02

>>EIP; c01c55a7 <tcp_v4_get_port+d7/220>   <=====
Trace; c01dae9b <vsnprintf+3bb/400>
Trace; c01d0562 <inet_bind+152/220>
Trace; c01a2444 <sys_bind+54/80>
Trace; c01a32c7 <sock_setsockopt+37/520>
Trace; c01a1871 <sockfd_lookup+11/80>
Trace; c01a29ec <sys_setsockopt+4c/80>
Trace; c01a2a10 <sys_setsockopt+70/80>
Trace; c01a2f7c <sys_socketcall+7c/200>
Trace; c0106c2b <system_call+33/38>
Code;  c01c55a7 <tcp_v4_get_port+d7/220>
00000000 <_EIP>:
Code;  c01c55a7 <tcp_v4_get_port+d7/220>   <=====
   0:   66 39 31                  cmp    %si,(%ecx)   <=====
Code;  c01c55aa <tcp_v4_get_port+da/220>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> c01c55a0 <tcp_v4_get_port+d0/220>
Code;  c01c55ac <tcp_v4_get_port+dc/220>
   5:   85 c9                     test   %ecx,%ecx
Code;  c01c55ae <tcp_v4_get_port+de/220>
   7:   74 68                     je     71 <_EIP+0x71> c01c5618 <tcp_v4_get_port+148/220>
Code;  c01c55b0 <tcp_v4_get_port+e0/220>
   9:   8b 51 08                  mov    0x8(%ecx),%edx
Code;  c01c55b3 <tcp_v4_get_port+e3/220>
   c:   85 d2                     test   %edx,%edx
Code;  c01c55b5 <tcp_v4_get_port+e5/220>
   e:   74 61                     je     71 <_EIP+0x71> c01c5618 <tcp_v4_get_port+148/220>
Code;  c01c55b7 <tcp_v4_get_port+e7/220>
  10:   66 83 79 02 00            cmpw   $0x0,0x2(%ecx)


CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
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
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
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
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y

