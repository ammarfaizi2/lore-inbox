Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289850AbSAWNYk>; Wed, 23 Jan 2002 08:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289854AbSAWNYb>; Wed, 23 Jan 2002 08:24:31 -0500
Received: from wasala.fi ([212.50.129.162]:38417 "EHLO wasala.fi")
	by vger.kernel.org with ESMTP id <S289850AbSAWNYN>;
	Wed, 23 Jan 2002 08:24:13 -0500
Date: Wed, 23 Jan 2002 15:24:06 +0200
From: Antti Salmela <asalmela@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] 2.4.17, SMP, AMD, devfs, highmem.
Message-ID: <20020123152406.A4992@wasala.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel compiled with gcc version 2.95.4 (Debian prerelease).

If any additional information is required, please ask.

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01cccc0, System.map says c0154200.  Ignoring ksyms_base entry
1151MB HIGHMEM available.
cpu: 0, clocks: 2654979, slice: 884993
cpu: 1, clocks: 2654979, slice: 884993
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0147da1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 5a5a5a00   ebx: f702a6c0   ecx: c5379c80   edx: f702a6f0
esi: c5379c80   edi: f7746c80   ebp: f702a6c0   esp: f76aff18
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 27, stackpage=f76af000)
Stack: f70d3ac0 c01677be f702a6c0 c5379c80 f702a6c0 00000000 f76affa4 f7748ac0 
       c013f2ce f702a6c0 00000000 f76aff74 c013fab1 f7748ac0 f76aff74 00000000 
       c6c0d000 00000000 f76affa4 00000009 00000009 c6c0d005 00000000 c6c0d004 
Call Trace: [<c01677be>] [<c013f2ce>] [<c013fab1>] [<c013fd2a>] [<c01401b5>] 
   [<c013ccb9>] [<c0135be3>] [<c0106edb>] 
Code: 0f 0b f0 fe 0d c0 23 2c c0 0f 88 47 b1 0d 00 85 c9 74 12 8b 

>>EIP; c0147da0 <d_instantiate+10/50>   <=====
Trace; c01677be <devfs_d_revalidate_wait+8e/c0>
Trace; c013f2ce <cached_lookup+2e/60>
Trace; c013fab0 <link_path_walk+580/7e0>
Trace; c013fd2a <path_walk+1a/20>
Trace; c01401b4 <__user_walk+34/50>
Trace; c013ccb8 <sys_stat64+18/70>
Trace; c0135be2 <sys_read+c2/d0>
Trace; c0106eda <system_call+32/38>
Code;  c0147da0 <d_instantiate+10/50>
00000000 <_EIP>:
Code;  c0147da0 <d_instantiate+10/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0147da2 <d_instantiate+12/50>
   2:   f0 fe 0d c0 23 2c c0      lock decb 0xc02c23c0
Code;  c0147da8 <d_instantiate+18/50>
   9:   0f 88 47 b1 0d 00         js     db156 <_EIP+0xdb156> c0222ef6 <stext_lock+2cf2/84bc>
Code;  c0147dae <d_instantiate+1e/50>
   f:   85 c9                     test   %ecx,%ecx
Code;  c0147db0 <d_instantiate+20/50>
  11:   74 12                     je     25 <_EIP+0x25> c0147dc4 <d_instantiate+34/50>
Code;  c0147db2 <d_instantiate+22/50>
  13:   8b 00                     mov    (%eax),%eax


2 warnings issued.  Results may not be reliable.
