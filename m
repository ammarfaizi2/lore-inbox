Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280900AbRKGSvF>; Wed, 7 Nov 2001 13:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280902AbRKGSuy>; Wed, 7 Nov 2001 13:50:54 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:45955 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S280900AbRKGSug>;
	Wed, 7 Nov 2001 13:50:36 -0500
Date: Wed, 7 Nov 2001 10:50:35 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Oops: 2.4.12: Known problem?
Message-ID: <20011107105035.A6608@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Box was still sort of alive after this (could still ping, ssh, etc.), but
some services had hung.

ksymoops 2.4.3 on i686 2.4.12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12nn1/ (default)
     -m /System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c02044e0, System.map says c01530e0.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000028
c0243791
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0243791>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c263ff80   ebx: cbc4c220   ecx: 00000000   edx: 00000000
esi: c263ff80   edi: c263ff48   ebp: c557de80   esp: c263ff14
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 28415, stackpage=c263f000)
Stack: cbc4c220 c263ff80 00001000 c263ff48 c020f5d5 c557de80 c263ff80 00001000
       c263ff48 00000000 00001000 c557de80 00001000 00006eff 00000050 00000050
       00000000 00000000 c020f80e c557de80 c263ff80 00001000 c3509520 ffffffea
Call Trace: [<c020f5d5>] [<c020f80e>] [<c0132b76>] [<c0106dbb>]
Code: 8b 42 28 ff d0 83 c4 0c 5b c3 90 83 ec 04 55 57 56 53 8b 44

>>EIP; c0243790 <inet_sendmsg+34/40>   <=====
Trace; c020f5d4 <sock_sendmsg+68/88>
Trace; c020f80e <sock_write+b2/bc>
Trace; c0132b76 <sys_write+96/cc>
Trace; c0106dba <system_call+32/38>
Code;  c0243790 <inet_sendmsg+34/40>
00000000 <_EIP-0x1>:
Code;  c0243790 <inet_sendmsg+34/40>
   0:   8b 42 28          movl   0x28(%edx),%eax
Code;  c0243790 <inet_sendmsg+34/40>
00000001 <_EIP>:
Code;  c0243790 <inet_sendmsg+34/40>   <=====
   1:   42                incl   %edx   <=====
Code;  c0243792 <inet_sendmsg+36/40>
   2:   28 ff             subb   %bh,%bh
Code;  c0243794 <inet_sendmsg+38/40>
   4:   d0 83 c4 0c 5b    rolb   0xc35b0cc4(%ebx)
Code;  c0243798 <inet_sendmsg+3c/40>
   9:   c3 
Code;  c024379a <inet_sendmsg+3e/40>
   a:   90                nop    
Code;  c024379a <inet_sendmsg+3e/40>
   b:   83 ec 04          subl   $0x4,%esp
Code;  c024379e <inet_shutdown+2/1e0>
   e:   55                pushl  %ebp
Code;  c024379e <inet_shutdown+2/1e0>
   f:   57                pushl  %edi
Code;  c02437a0 <inet_shutdown+4/1e0>
  10:   56                pushl  %esi
Code;  c02437a0 <inet_shutdown+4/1e0>
  11:   53                pushl  %ebx
Code;  c02437a2 <inet_shutdown+6/1e0>
  12:   8b 44 00 00       movl   0x0(%eax,%eax,1),%eax


1 warning issued.  Results may not be reliable.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
