Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRJUVMK>; Sun, 21 Oct 2001 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276766AbRJUVMA>; Sun, 21 Oct 2001 17:12:00 -0400
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:43904 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S276761AbRJUVLs>;
	Sun, 21 Oct 2001 17:11:48 -0400
Date: Sun, 21 Oct 2001 14:12:21 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12 open() Oops
Message-ID: <20011021141221.A2121@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this make any sense to anybody? :)

ksymoops 2.4.3 on i686 2.4.12nn1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12nn1/ (default)
     -m /System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c02044e0, System.map says c01530e0.  Ignoring ksyms_base entry
Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c013d027
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c013d027>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: ffffffff
esi: 00000000   edi: df2a7480   ebp: df56df84   esp: df56df3c
ds: 0018   es: 0018   ss: 0018
Process exim (pid: 102, stackpage=df56d000)
Stack: df2a7480 ffffffff bffff108 df988000 00000402 df988000 df72a1d8 00000000 
       00000006 df480620 c0132123 df988000 00000403 bffff108 df56df84 df56c000 
       00000002 bffff108 df480620 dfffbf20 bffff108 df988000 00000000 00000001 
Call Trace: [<c0132123>] [<c0132494>] [<c0106dbb>] 
Code: 8b 00 ff d0 83 c4 08 bb 00 e0 ff ff 21 e3 83 7b 1c 00 7d 15 

>>EIP; c013d026 <open_namei+56e/6c0>   <=====
Trace; c0132122 <filp_open+3a/5c>
Trace; c0132494 <sys_open+3c/f0>
Trace; c0106dba <system_call+32/38>
Code;  c013d026 <open_namei+56e/6c0>
00000000 <_EIP-0x1>:
Code;  c013d026 <open_namei+56e/6c0>
   0:   8b 00             movl   (%eax),%eax
Code;  c013d026 <open_namei+56e/6c0>
00000001 <_EIP>:
Code;  c013d026 <open_namei+56e/6c0>   <=====
   1:   00 ff             addb   %bh,%bh   <=====
Code;  c013d028 <open_namei+570/6c0>
   3:   d0 83 c4 08 bb    rolb   0xbb08c4(%ebx)
Code;  c013d02e <open_namei+576/6c0>
   8:   00 
Code;  c013d02e <open_namei+576/6c0>
   9:   e0 ff             loopne a <_EIP+0x9> c013d02e <open_namei+576/6c0>
Code;  c013d030 <open_namei+578/6c0>
   b:   ff 21             jmp    *(%ecx)
Code;  c013d032 <open_namei+57a/6c0>
   d:   e3 83             jecxz  ffffff92 <_EIP+0xffffff91> c013cfb6 <open_namei+4fe/6c0>
Code;  c013d034 <open_namei+57c/6c0>
   f:   7b 1c             jnp    2d <_EIP+0x2c> c013d052 <open_namei+59a/6c0>
Code;  c013d036 <open_namei+57e/6c0>
  11:   00 7d 15          addb   %bh,0x15(%ebp)


1 warning issued.  Results may not be reliable.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
