Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312555AbSCUXDd>; Thu, 21 Mar 2002 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312556AbSCUXDY>; Thu, 21 Mar 2002 18:03:24 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:52108 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S312555AbSCUXDN>; Thu, 21 Mar 2002 18:03:13 -0500
Date: Thu, 21 Mar 2002 18:08:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac5
Message-ID: <20020321180811.A12688@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> stuff. If you want a peaceful life and a production -ac system please
> stick at 2.4.18-ac3 or 2.4.19pre3-ac4. IDE and large NFS changes do not
> in general make for stability first time around.

No complaints.  Maybe this ksymoops output is helpful.

Oops occured at boot time:

VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 51536U3, ATA DISK drive
hdb: ATAPI CDROM, ATAPI CD/DVD-ROM drive
hdc: Maxtor 52049U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(33)
hdc: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63, UDMA(33)
kernel BUG at ide-cd.c:790!
invalid operand: 0000

ksymoops output:

Code: 0f 0b 16 03 62 32 23 c0 68 9c 27 1c c0 56 ff 74 24 28 53 e8
 <0>Kernel panic: Attempted to kill init!
kernel BUG at ide-cd.c:790!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01c29c1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c151b160   ebx: c02b054c   ecx: 0880bf37   edx: 000001f7
esi: 000001f4   edi: c151deac   ebp: c01c348c   esp: c151dccc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c151d000)
Stack: c02b054c d7f36c00 00000000 c01c348c 00803272 c01c34b8 c02b054c c151de94
       c01c32c0 c01c2915 c02b054c c02b054c d7f36c00 c151dde4 00000000 00000190
       c01c34fe c02b054c 00000018 c01c348c c01c3a38 c02b054c 00000000 c02b054c
Call Trace: [<c01c348c>] [<c01c34b8>] [<c01c32c0>] [<c01c2915>] [<c01c34fe>]
   [<c01c348c>] [<c01c3a38>] [<c01b8096>] [<c01b83b7>] [<c01b897a>] [<c01c3573>]
   [<c0107e1c>] [<c01bc421>] [<c01c43db>] [<c01c716e>] [<c01c4acb>] [<c01c4b3b>]
   [<c01c546c>] [<c01c5934>] [<c0105023>] [<c01054dc>]
Code: 0f 0b 16 03 62 32 23 c0 68 9c 27 1c c0 56 ff 74 24 28 53 e8


>>EIP; c01c29c1 <cdrom_transfer_packet_command+71/a0>   <=====

>>eax; c151b160 <END_OF_CODE+1265ae4/????>
>>ebx; c02b054c <ide_hwifs+18c/2198>
>>ecx; 0880bf37 Before first symbol
>>edi; c151deac <END_OF_CODE+1268830/????>
>>ebp; c01c348c <cdrom_do_pc_continuation+0/30>
>>esp; c151dccc <END_OF_CODE+1268650/????>

Trace; c01c348c <cdrom_do_pc_continuation+0/30>
Trace; c01c34b8 <cdrom_do_pc_continuation+2c/30>
Trace; c01c32c0 <cdrom_pc_intr+0/1cc>
Trace; c01c2915 <cdrom_start_packet_command+141/17c>
Trace; c01c34fe <cdrom_do_packet_command+42/48>
Trace; c01c348c <cdrom_do_pc_continuation+0/30>
Trace; c01c3a38 <ide_do_rw_cdrom+108/144>
Trace; c01b8096 <start_request+1a6/20c>
Trace; c01b83b7 <ide_do_request+283/2d0>
Trace; c01b897a <ide_do_drive_cmd+ea/11c>
Trace; c01c3573 <cdrom_queue_packet_command+4f/b0>
Trace; c0107e1c <handle_IRQ_event+34/60>
Trace; c01bc421 <ide_timing_compute+b5/164>
Trace; c01c43db <ide_cdrom_packet+6b/78>
Trace; c01c716e <cdrom_mode_sense+5a/64>
Trace; c01c4acb <ide_cdrom_get_capabilities+9f/b4>
Trace; c01c4b3b <ide_cdrom_probe_capabilities+5b/43c>
Trace; c01c546c <ide_cdrom_setup+468/4e8>
Trace; c01c5934 <ide_cdrom_init+e0/17c>
Trace; c0105023 <init+7/114>
Trace; c01054dc <kernel_thread+28/38>

Code;  c01c29c1 <cdrom_transfer_packet_command+71/a0>
00000000 <_EIP>:
Code;  c01c29c1 <cdrom_transfer_packet_command+71/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01c29c3 <cdrom_transfer_packet_command+73/a0>
   2:   16                        push   %ss
Code;  c01c29c4 <cdrom_transfer_packet_command+74/a0>
   3:   03 62 32                  add    0x32(%edx),%esp
Code;  c01c29c7 <cdrom_transfer_packet_command+77/a0>
   6:   23 c0                     and    %eax,%eax
Code;  c01c29c9 <cdrom_transfer_packet_command+79/a0>
   8:   68 9c 27 1c c0            push   $0xc01c279c
Code;  c01c29ce <cdrom_transfer_packet_command+7e/a0>
   d:   56                        push   %esi
Code;  c01c29cf <cdrom_transfer_packet_command+7f/a0>
   e:   ff 74 24 28               pushl  0x28(%esp,1)
Code;  c01c29d3 <cdrom_transfer_packet_command+83/a0>
  12:   53                        push   %ebx
Code;  c01c29d4 <cdrom_transfer_packet_command+84/a0>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c01c29d9 <cdrom_transfer_packet_command+89/a0>

 <0>Kernel panic: Attempted to kill init!

The .config worked with 2.4.19-pre3-ac1.
config and lspci -vv output at:
http://home.earthlink.net/~rwhron/kernel/config/config-2.4.19-pre3-ac5
http://home.earthlink.net/~rwhron/kernel/config/lspci

-- 
Randy Hron

