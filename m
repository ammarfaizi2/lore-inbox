Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSGWXwc>; Tue, 23 Jul 2002 19:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSGWXwc>; Tue, 23 Jul 2002 19:52:32 -0400
Received: from bru-cse-369.cisco.com ([144.254.12.31]:63208 "EHLO
	bru-cse-369.cisco.com") by vger.kernel.org with ESMTP
	id <S314529AbSGWXwR>; Tue, 23 Jul 2002 19:52:17 -0400
Date: Wed, 24 Jul 2002 01:55:22 +0200
From: Marc Duponcheel <mduponch@cisco.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc2 -> 2.4.19rc3 : no more eth
Message-ID: <20020723235522.GA3365@cisco.com>
Reply-To: Marc Duponcheel <mduponch@cisco.com>
References: <20020723130221.GF29367@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020723130221.GF29367@cisco.com>
User-Agent: Mutt/1.4i
Organization: Cisco Systems
X-uname: SunOS 5.8 sun4u
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Note:

I -did- find the Oops in the logs.

The machine runs 2.4.18 again so I weeded out 'compare_maps' warnings

If one needs more info, I'll try to provide it.

In general, I use lastest stable software

(e.g gcc 3.1 modutils 2.4.18 etc ...)

============================================================================================================================
ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.19-rc3 (specified)
     -m /boot/System.map-2.4.19-rc3 (specified)

Warning (compare_Version): Version mismatch.  3c59x says 2.4.18, System.map says 2.4.19.  Expect lots of address mismatches.
cpu: 0, clocks: 1340016, slice: 670008
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c12a38fc
esi: d0cb5d00   edi: 00000000   ebp: d0cb1000   esp: cf5e9ef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 357, stackpage=cf5e9000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cb4302 d0cb5d00 00000000 
ffffffea c011d82b d0cb1060 08083c80 00004cf0 00000000 0808844c 0000482c 
00000060 00000060 00000008 cfc7ee80 cfa76000 cfa77000 00000060 d0cae000 
Call Trace:    [<d0cb4302>] [<d0cb5d00>] [<c011d82b>] [<d0cb1060>] [<d0cb1060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cb4302 <[eepro100]eepro100_cleanup_module+12/20>
Trace; d0cb5d00 <[eepro100].bss.end+31/3331>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

<1>Unable to handle kernel paging request at virtual address d0ca6640
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281e4
esi: d0cbdc00   edi: 00000000   ebp: d0cb7000   esp: cfbd3ef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 382, stackpage=cfbd3000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cbb569 d0cbdc00 ffffffea 
00000000 c011d82b d0cb7060 08086a08 00006c08 00000000 0808cd08 00006360 
00000060 00000060 00000005 cfc7eec0 cf597000 cf598000 00000060 d0cb1000 
Call Trace:    [<d0cbb569>] [<d0cbdc00>] [<c011d82b>] [<d0cb7060>] [<d0cb7060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cbb569 <[3c59x]vortex_start_xmit+a9/190>
Trace; d0cbdc00 <[3c59x].rodata.end+2c5/1b05>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010296
eax: d0ca6640   ebx: 00000202   ecx: c102c01c   edx: c02281e4
esi: d0d705a0   edi: 00000000   ebp: d0d704a0   esp: cd3b1e9c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1359, stackpage=cd3b1000)
Stack: c02281d0 c0228350 00000202 00000000 d0d704a0 d0d58433 d0d705a0 00000202 
d0d53962 d0d704a0 00001000 00000202 00000000 00000001 d0d4571c d0d704a0 
c02281d0 c0228334 000001ff 00000206 00000000 c100001c c123fa8c c02281d0 
Call Trace:    [<d0d704a0>] [<d0d58433>] [<d0d705a0>] [<d0d53962>] [<d0d704a0>]
[<d0d4571c>] [<d0d704a0>] [<d0d57191>] [<d0d704a0>] [<d0d704a0>] [<c011d82b>]
[<d0d53060>] [<d0d6ff08>] [<d0d53060>] [<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d58433 <[aic7xxx]ahc_format_transinfo+43/170>
Trace; d0d705a0 <[aic7xxx]seqprog+7e0/da0>
Trace; d0d53962 <[scsi_mod].bss.end+1243/18e1>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d4571c <[scsi_mod]scsi_wait_req+4c/b0>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d57191 <[aic7xxx]ahc_linux_queue_recovery_cmd+201/a90>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0d53060 <[scsi_mod].bss.end+941/18e1>
Trace; d0d6ff08 <[aic7xxx]seqprog+148/da0>
Trace; d0d53060 <[scsi_mod].bss.end+941/18e1>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

cpu: 0, clocks: 1340048, slice: 670024
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281e4
esi: d0cb5d00   edi: 00000000   ebp: d0cb1000   esp: cfb75ef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 361, stackpage=cfb75000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cb4302 d0cb5d00 00000000 
ffffffea c011d82b d0cb1060 08083c80 00004cf0 00000000 0808844c 0000482c 
00000060 00000060 00000008 cfc7ee80 cf5bb000 cf5bc000 00000060 d0cae000 
Call Trace:    [<d0cb4302>] [<d0cb5d00>] [<c011d82b>] [<d0cb1060>] [<d0cb1060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cb4302 <[eepro100]eepro100_cleanup_module+12/20>
Trace; d0cb5d00 <[eepro100].bss.end+31/3331>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

<1>Unable to handle kernel paging request at virtual address d0ca6640
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281f0
esi: d0cbdc00   edi: 00000000   ebp: d0cb7000   esp: cf5cfef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 386, stackpage=cf5cf000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cbb569 d0cbdc00 ffffffea 
00000000 c011d82b d0cb7060 08086a08 00006c08 00000000 0808cd08 00006360 
00000060 00000060 00000005 cfc7eec0 cf59c000 cf59d000 00000060 d0cb1000 
Call Trace:    [<d0cbb569>] [<d0cbdc00>] [<c011d82b>] [<d0cb7060>] [<d0cb7060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cbb569 <[3c59x]vortex_start_xmit+a9/190>
Trace; d0cbdc00 <[3c59x].rodata.end+2c5/1b05>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010296
eax: d0ca6640   ebx: 00000202   ecx: c102c01c   edx: c02281e4
esi: d0d705a0   edi: 00000000   ebp: d0d704a0   esp: cd3f1e9c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1363, stackpage=cd3f1000)
Stack: c02281d0 c0228350 00000202 00000000 d0d704a0 d0d58433 d0d705a0 00000202 
d0d53962 d0d704a0 00001000 00000202 00000000 00000001 d0d4571c d0d704a0 
c02281d0 c0228334 000001ff 00000206 00000000 c100001c c123fed8 c02281d0 
Call Trace:    [<d0d704a0>] [<d0d58433>] [<d0d705a0>] [<d0d53962>] [<d0d704a0>]
[<d0d4571c>] [<d0d704a0>] [<d0d57191>] [<d0d704a0>] [<d0d704a0>] [<c011d82b>]
[<d0d53060>] [<d0d6ff08>] [<d0d53060>] [<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d58433 <[aic7xxx]ahc_format_transinfo+43/170>
Trace; d0d705a0 <[aic7xxx]seqprog+7e0/da0>
Trace; d0d53962 <[scsi_mod].bss.end+1243/18e1>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d4571c <[scsi_mod]scsi_wait_req+4c/b0>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d57191 <[aic7xxx]ahc_linux_queue_recovery_cmd+201/a90>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0d53060 <[scsi_mod].bss.end+941/18e1>
Trace; d0d6ff08 <[aic7xxx]seqprog+148/da0>
Trace; d0d53060 <[scsi_mod].bss.end+941/18e1>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

cpu: 0, clocks: 1340068, slice: 670034
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281fc
esi: d0cb5d00   edi: 00000000   ebp: d0cb1000   esp: cf70def8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 361, stackpage=cf70d000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cb4302 d0cb5d00 00000000 
ffffffea c011d82b d0cb1060 08083c80 00004cf0 00000000 0808844c 0000482c 
00000060 00000060 00000008 cfc7ee80 cfa62000 cfa63000 00000060 d0cae000 
Call Trace:    [<d0cb4302>] [<d0cb5d00>] [<c011d82b>] [<d0cb1060>] [<d0cb1060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cb4302 <[eepro100]eepro100_cleanup_module+12/20>
Trace; d0cb5d00 <[eepro100].bss.end+31/3331>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

<1>Unable to handle kernel paging request at virtual address d0ca6640
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281e4
esi: d0cbdc00   edi: 00000000   ebp: d0cb7000   esp: cfd2fef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 386, stackpage=cfd2f000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cbb569 d0cbdc00 ffffffea 
00000000 c011d82b d0cb7060 08086a08 00006c08 00000000 0808cd08 00006360 
00000060 00000060 00000005 cfc7eec0 cf5ab000 cf5ac000 00000060 d0cb1000 
Call Trace:    [<d0cbb569>] [<d0cbdc00>] [<c011d82b>] [<d0cb7060>] [<d0cb7060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cbb569 <[3c59x]vortex_start_xmit+a9/190>
Trace; d0cbdc00 <[3c59x].rodata.end+2c5/1b05>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

cpu: 0, clocks: 1340060, slice: 670030
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281f0
esi: d0cb5d00   edi: 00000000   ebp: d0cb1000   esp: cf9bbef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 359, stackpage=cf9bb000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cb4302 d0cb5d00 00000000 
ffffffea c011d82b d0cb1060 08083c80 00004cf0 00000000 0808844c 0000482c 
00000060 00000060 00000008 cfc7ee80 cfa80000 cfa81000 00000060 d0cae000 
Call Trace:    [<d0cb4302>] [<d0cb5d00>] [<c011d82b>] [<d0cb1060>] [<d0cb1060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cb4302 <[eepro100]eepro100_cleanup_module+12/20>
Trace; d0cb5d00 <[eepro100].bss.end+31/3331>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

<1>Unable to handle kernel paging request at virtual address d0ca6640
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281e4
esi: d0cbdc00   edi: 00000000   ebp: d0cb7000   esp: cf623ef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 384, stackpage=cf623000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cbb569 d0cbdc00 ffffffea 
00000000 c011d82b d0cb7060 08086a08 00006c08 00000000 0808cd08 00006360 
00000060 00000060 00000005 cfc7eec0 cf591000 cf592000 00000060 d0cb1000 
Call Trace:    [<d0cbb569>] [<d0cbdc00>] [<c011d82b>] [<d0cb7060>] [<d0cb7060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cbb569 <[3c59x]vortex_start_xmit+a9/190>
Trace; d0cbdc00 <[3c59x].rodata.end+2c5/1b05>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; d0cb7060 <[eepro100].bss.end+1391/3331>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010296
eax: d0ca6640   ebx: 00000202   ecx: c102c01c   edx: c02281e4
esi: d0d705a0   edi: 00000000   ebp: d0d704a0   esp: cd2dde9c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1361, stackpage=cd2dd000)
Stack: c02281d0 c0228350 00000202 00000000 d0d704a0 d0d58433 d0d705a0 00000202 
d0d53962 d0d704a0 00001000 00000202 00000000 00000001 d0d4571c d0d704a0 
c02281d0 c0228334 000001ff 00000202 00000000 c100001c c123ff88 c02281d0 
Call Trace:    [<d0d704a0>] [<d0d58433>] [<d0d705a0>] [<d0d53962>] [<d0d704a0>]
[<d0d4571c>] [<d0d704a0>] [<d0d57191>] [<d0d704a0>] [<d0d704a0>] [<c011d82b>]
[<d0d53060>] [<d0d6ff08>] [<d0d53060>] [<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d58433 <[aic7xxx]ahc_format_transinfo+43/170>
Trace; d0d705a0 <[aic7xxx]seqprog+7e0/da0>
Trace; d0d53962 <[scsi_mod].bss.end+1243/18e1>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d4571c <[scsi_mod]scsi_wait_req+4c/b0>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d57191 <[aic7xxx]ahc_linux_queue_recovery_cmd+201/a90>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; d0d704a0 <[aic7xxx]seqprog+6e0/da0>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0d53060 <[scsi_mod].bss.end+941/18e1>
Trace; d0d6ff08 <[aic7xxx]seqprog+148/da0>
Trace; d0d53060 <[scsi_mod].bss.end+941/18e1>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx


1121 warnings issued.  Results may not be reliable.
============================================================================================================================

On Tue, Jul 23, 2002 at 03:02:21PM +0200, Marc Duponcheel wrote:
> Dear kernel crew.
> 
> I follow the stable kernel and run 2.4.18 just fine on 3 machines.
> 
> Recently I thought about trying 2.4.19rc kernels.  That went fine as
> well with one exception.
> 
> One machine (with 2 ethernet controllers)
>  Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0c)
>  3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
> will no longer recognise -any- of those.
> 
> Note that this 'artifact' only happens with 2.4.19rc3.  The .config
> between 2.4.19rc2 did not change 2.4.19rc3
> 
> During boot I see OOPses (which for some reason, my syslog does not
> see).
> 
> Because this is a rather severe change [:-)] I wonder if I this rings
> a bell.
> 
> Thanks for your valuable time

--
 Greetings,

Marc Duponcheel     Multicast Development Engineer      Cisco Systems
email: mduponch@cisco.com tel: +32 2 704 52 40 cell: +32 478 68 10 91
