Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288121AbSACBpy>; Wed, 2 Jan 2002 20:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288119AbSACBpp>; Wed, 2 Jan 2002 20:45:45 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:3574 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S288115AbSACBpZ>; Wed, 2 Jan 2002 20:45:25 -0500
Date: Thu, 3 Jan 2002 12:45:07 +1100
From: Jason Thomas <jason@topic.com.au>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oops in devfs
Message-ID: <20020103014507.GB19702@topic.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me I'm not on the list

Hi, I get the following oops, usually after booting. I've done things
like run memtest86 and changed the scsi cable.

Thanks.

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

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
cpu: 0, clocks: 1339387, slice: 446462
cpu: 1, clocks: 1339387, slice: 446462
kernel BUG at dcache.c:654!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0144b52>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: f5f66210   ecx: c028dd20   edx: 00003757
esi: f5da5280   edi: f5f661e0   ebp: f5f661e0   esp: f7a7df08
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 24, stackpage=f7a7d000)
Stack: c02408d3 0000028e f7324b40 f5da5280 f7a869a0 c016a31f f5f661e0 f5da5280 
       f5f661e0 00000000 f7a7dfa4 f7a87c40 c013be5e f5f661e0 00000000 f7a7df74 
       c013c6c1 f7a87c40 f7a7df74 00000000 f7a6a000 00000000 f7a7dfa4 00000009 
Call Trace: [<c016a31f>] [<c013be5e>] [<c013c6c1>] [<c013c94a>] [<c013ce31>] 
   [<c013984d>] [<c0132824>] [<c0106dbb>] 
Code: 0f 0b 83 c4 08 f0 fe 0d a0 36 2e c0 0f 88 a3 63 0e 00 85 f6 

>>EIP; c0144b52 <d_instantiate+22/58>   <=====
Trace; c016a31e <devfs_d_revalidate_wait+8a/bc>
Trace; c013be5e <cached_lookup+2e/54>
Trace; c013c6c0 <link_path_walk+5e0/850>
Trace; c013c94a <path_walk+1a/1c>
Trace; c013ce30 <__user_walk+34/50>
Trace; c013984c <sys_stat64+18/70>
Trace; c0132824 <sys_read+bc/c4>
Trace; c0106dba <system_call+32/38>
Code;  c0144b52 <d_instantiate+22/58>
00000000 <_EIP>:
Code;  c0144b52 <d_instantiate+22/58>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0144b54 <d_instantiate+24/58>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0144b56 <d_instantiate+26/58>
   5:   f0 fe 0d a0 36 2e c0      lock decb 0xc02e36a0
Code;  c0144b5e <d_instantiate+2e/58>
   c:   0f 88 a3 63 0e 00         js     e63b5 <_EIP+0xe63b5> c022af06 <stext_lo
ck+2c22/88ee>
Code;  c0144b64 <d_instantiate+34/58>
  12:   85 f6                     test   %esi,%esi


2 warnings issued.  Results may not be reliable.
