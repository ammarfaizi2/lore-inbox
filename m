Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSHHCmi>; Wed, 7 Aug 2002 22:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHHCmh>; Wed, 7 Aug 2002 22:42:37 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:4537 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S317286AbSHHCmg>; Wed, 7 Aug 2002 22:42:36 -0400
Message-ID: <3D51DB52.6000200@verizon.net>
Date: Wed, 07 Aug 2002 22:45:38 -0400
From: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 BUG in page_alloc.c:91
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040806030409020209080201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040806030409020209080201
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 My info: Pentium III PC, kernel 2.4.19 vanilla, redhat 7.3, reiserfs.

It's not pretty. Let me know what I can do to help.

Aug  7 19:23:30 manic kernel:  kernel BUG at page_alloc.c:89!
Aug  7 19:23:30 manic kernel: invalid operand: 0000
Aug  7 19:23:30 manic kernel: CPU:    0
Aug  7 19:23:30 manic kernel: EIP:    0010:[<c012c331>]    Tainted: P
Aug  7 19:23:30 manic kernel: EFLAGS: 00010286
Aug  7 19:23:30 manic kernel: eax: 00000000   ebx: c116980c   ecx:
c116980c   edx: 00000000
Aug  7 19:23:30 manic kernel: esi: 00000000   edi: cc5a3e00   ebp:
c2b3fae0   esp: e7fe1f44
Aug  7 19:23:30 manic kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 19:23:30 manic kernel: Process kupdated (pid: 6, stackpage=e7fe1000)
Aug  7 19:23:30 manic kernel: Stack: e7fe0000 00000246 c1167b58 c0125a53
00000000 c116980c c116980c c116980c
Aug  7 19:23:30 manic kernel:        c2b3fad0 00000000 c2b3fae0 c01256b0
c016b320 00000004 c2b3fa20 c2b3fa20
Aug  7 19:23:30 manic kernel:        e7d86c60 c0143316 c2b3fad0 e7d86c00
e7fe1f9c e7fe1f9c 00000000 00000000
Aug  7 19:23:30 manic kernel: Call Trace:    [<c0125a53>] [<c01256b0>]
[<c016b320>] [<c0143316>] [<c0113490>]
Aug  7 19:23:30 manic kernel:   [<c0135355>] [<c0135600>] [<c0105000>]
[<c0105000>] [<c0107066>] [<c0135510>]
Aug  7 19:23:30 manic kernel:
Aug  7 19:23:30 manic kernel: Code: 0f 0b 59 00 b4 74 25 c0 8b 4b 08 85
c9 74 08 0f 0b 5b 00 b4


-- tony

--------------040806030409020209080201
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.4 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Aug  7 19:23:30 manic kernel:  kernel BUG at page_alloc.c:89!
Aug  7 19:23:30 manic kernel: invalid operand: 0000
Aug  7 19:23:30 manic kernel: CPU:    0
Aug  7 19:23:30 manic kernel: EIP:    0010:[<c012c331>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  7 19:23:30 manic kernel: EFLAGS: 00010286
Aug  7 19:23:30 manic kernel: eax: 00000000   ebx: c116980c   ecx: c116980c   edx: 00000000
Aug  7 19:23:30 manic kernel: esi: 00000000   edi: cc5a3e00   ebp: c2b3fae0   esp: e7fe1f44
Aug  7 19:23:30 manic kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 19:23:30 manic kernel: Process kupdated (pid: 6, stackpage=e7fe1000)
Aug  7 19:23:30 manic kernel: Stack: e7fe0000 00000246 c1167b58 c0125a53 00000000 c116980c c116980c c116980c
Aug  7 19:23:30 manic kernel:        c2b3fad0 00000000 c2b3fae0 c01256b0 c016b320 00000004 c2b3fa20 c2b3fa20
Aug  7 19:23:30 manic kernel:        e7d86c60 c0143316 c2b3fad0 e7d86c00 e7fe1f9c e7fe1f9c 00000000 00000000
Aug  7 19:23:30 manic kernel: Call Trace:    [<c0125a53>] [<c01256b0>] [<c016b320>] [<c0143316>] [<c0113490>]
Aug  7 19:23:30 manic kernel:   [<c0135355>] [<c0135600>] [<c0105000>] [<c0105000>] [<c0107066>] [<c0135510>]
Aug  7 19:23:30 manic kernel: Code: 0f 0b 59 00 b4 74 25 c0 8b 4b 08 85 c9 74 08 0f 0b 5b 00 b4

>>EIP; c012c331 <__free_pages_ok+21/270>   <=====
Trace; c0125a53 <___wait_on_page+b3/c0>
Trace; c01256b0 <filemap_fdatasync+80/90>
Trace; c016b320 <reiserfs_writepage+0/30>
Trace; c0143316 <sync_unlocked_inodes+96/170>
Trace; c0113490 <process_timeout+0/50>
Trace; c0135355 <sync_old_buffers+5/40>
Trace; c0135600 <kupdate+f0/110>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0107066 <kernel_thread+26/30>
Trace; c0135510 <kupdate+0/110>
Code;  c012c331 <__free_pages_ok+21/270>
00000000 <_EIP>:
Code;  c012c331 <__free_pages_ok+21/270>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c333 <__free_pages_ok+23/270>
   2:   59                        pop    %ecx
Code;  c012c334 <__free_pages_ok+24/270>
   3:   00 b4 74 25 c0 8b 4b      add    %dh,0x4b8bc025(%esp,%esi,2)
Code;  c012c33b <__free_pages_ok+2b/270>
   a:   08 85 c9 74 08 0f         or     %al,0xf0874c9(%ebp)
Code;  c012c341 <__free_pages_ok+31/270>
  10:   0b 5b 00                  or     0x0(%ebx),%ebx
Code;  c012c344 <__free_pages_ok+34/270>
  13:   b4 00                     mov    $0x0,%ah


1 warning issued.  Results may not be reliable.


--------------040806030409020209080201--

