Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281825AbRK1BLw>; Tue, 27 Nov 2001 20:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281848AbRK1BLh>; Tue, 27 Nov 2001 20:11:37 -0500
Received: from mail.fluke.com ([129.196.128.53]:18694 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S281825AbRK1BLW>; Tue, 27 Nov 2001 20:11:22 -0500
Date: Tue, 27 Nov 2001 17:11:23 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
Subject: oops in 2.5.1-pre2
Message-ID: <Pine.LNX.4.33.0111271708020.4053-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



while booting 2.5.1-pre2 I got the following oops

ksymoops 2.4.3 on i686 2.5.1-pre2.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre2/ (default)
     -m /usr/src/linux/System.map (default)

kernel BUG at elevator.c:123!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01c1cf4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001e   ebx: c12f2160   ecx: c0273328   edx: 0000112f
esi: 00000000   edi: c12f5ba0   ebp: 00000002   esp: c7fa5d9c
ds: 0018   es: 0018   ss: 0018
Process fsck.ext2 (pid: 17, stackpage=c7fa5000)
Stack: c024fe8e 0000007b c02e7134 c02e7104 c12f5ba0 00000002 00000000 00000000
       c120b600 c01c30a6 c02e7104 c7fa5e0c c02e7134 c12f5ba0 00000030 c12093e0
       c02e7104 c12f5ba0 c12e3260 c02e7134 005bcc8d c02e713c c12e3260 00000000
Call Trace: [<c01c30a6>] [<c01c35b8>] [<c01c373f>] [<c01c383a>] [<c012d2bb>]
   [<c011f3cc>] [<c01309fb>] [<c0130968>] [<c011f475>] [<c011f9f4>] [<c011fc52>]
   [<c0120192>] [<c01200ac>] [<c012acae>] [<c0106bc7>]
Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00 53 e8 de cc f6 ff 83 c4

>>EIP; c01c1cf4 <elevator_linus_merge+74/274>   <=====
Trace; c01c30a6 <__make_request+10a/4e8>
Trace; c01c35b8 <generic_make_request+134/1b0>
Trace; c01c373e <submit_bio+b6/c4>
Trace; c01c383a <submit_bh+ee/f4>
Trace; c012d2ba <block_read_full_page+1fa/210>
Trace; c011f3cc <add_to_page_cache_unique+6c/78>
Trace; c01309fa <blkdev_readpage+e/14>
Trace; c0130968 <blkdev_get_block+0/44>
Trace; c011f474 <page_cache_read+9c/bc>
Trace; c011f9f4 <generic_file_readahead+100/140>
Trace; c011fc52 <do_generic_file_read+1ee/418>
Trace; c0120192 <generic_file_read+8e/188>
Trace; c01200ac <file_read_actor+0/58>
Trace; c012acae <sys_read+8e/c4>
Trace; c0106bc6 <system_call+32/38>
Code;  c01c1cf4 <elevator_linus_merge+74/274>
00000000 <_EIP>:
Code;  c01c1cf4 <elevator_linus_merge+74/274>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01c1cf6 <elevator_linus_merge+76/274>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c01c1cf8 <elevator_linus_merge+78/274>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01c1d00 <elevator_linus_merge+80/274>
   c:   53                        push   %ebx
Code;  c01c1d00 <elevator_linus_merge+80/274>
   d:   e8 de cc f6 ff            call   fff6ccf0 <_EIP+0xfff6ccf0> c012e9e4 <bio_put+0/6c>
Code;  c01c1d06 <elevator_linus_merge+86/274>
  12:   83 c4 00                  add    $0x0,%esp


