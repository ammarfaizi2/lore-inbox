Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285055AbRLFIy1>; Thu, 6 Dec 2001 03:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbRLFIyS>; Thu, 6 Dec 2001 03:54:18 -0500
Received: from mail.uklinux.net ([80.84.72.21]:43789 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S285055AbRLFIyB>;
	Thu, 6 Dec 2001 03:54:01 -0500
Envelope-To: <linux-kernel@vger.kernel.org>
Date: Thu, 6 Dec 2001 08:51:41 +0000
From: Mark Hindley <mark@hindley.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.16
Message-ID: <20011206085141.A17074@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii

I have just had an oops with 2.4.16 while trying to mount an empty cdrw to make sure that it was empty before I wrote on it.

It has also left me with a mount process that I cannot kill and blocked CD writer. Any ideas on how to deal with it?

The ksymoops processed trace is attached

Mark



mark@hindley.uklinux.net


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops

ksymoops 2.3.7 on i586 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c1b1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 000007ff   ebx: 00000b00   ecx: 00000800   edx: c11533e0
esi: 00000200   edi: 00000b00   ebp: 00000002   esp: c304bdc0
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 16046, stackpage=c304b000)
Stack: 00000b00 00000200 00000002 00000001 00000882 c012a95b 00000b00 00000002 
       00000200 c22b02e0 c370ec00 00000002 c012ab16 00000b00 00000002 00000200 
       c304be0c c99d2154 00000b00 00000002 00000200 c22b02e0 c370ec00 c22b03b0 
Call Trace: [<c012a95b>] [<c012ab16>] [<c99d2154>] [<c99d0d29>] [<c99d1fbd>] 
   [<c012cc45>] [<c012d18b>] [<c99d4e40>] [<c013aec3>] [<c012d6db>] [<c99d4e40>] 
   [<c013bca1>] [<c013bf0a>] [<c013bd9c>] [<c013bfa0>] [<c0106b23>] 
Code: 0f 0b 8b 44 24 20 05 00 fe ff ff 3d 00 0e 00 00 76 02 0f 0b 

>>EIP; c012c1b1 <block_symlink+2a1/40c>   <=====
Trace; c012a95b <getblk+27/b4>
Trace; c012ab16 <bread+16/bc>
Trace; c99d2154 <[hfs]hfs_buffer_get+24/74>
Trace; c99d0d29 <[hfs]hfs_mdb_get+a9/3c8>
Trace; c99d1fbd <[hfs]hfs_read_super+61/1a4>
Trace; c012cc45 <get_super+121/c44>
Trace; c012d18b <get_super+667/c44>
Trace; c99d4e40 <[hfs]hfs_fs+0/1c>
Trace; c013aec3 <kiobuf_wait_for_io+3af/3dc>
Trace; c012d6db <get_super+bb7/c44>
Trace; c99d4e40 <[hfs]hfs_fs+0/1c>
Trace; c013bca1 <may_umount+641/612c>
Trace; c013bf0a <may_umount+8aa/612c>
Trace; c013bd9c <may_umount+73c/612c>
Trace; c013bfa0 <may_umount+940/612c>
Trace; c0106b23 <__up_wakeup+105f/22d4>
Code;  c012c1b1 <block_symlink+2a1/40c>
00000000 <_EIP>:
Code;  c012c1b1 <block_symlink+2a1/40c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c1b3 <block_symlink+2a3/40c>
   2:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c012c1b7 <block_symlink+2a7/40c>
   6:   05 00 fe ff ff            add    $0xfffffe00,%eax
Code;  c012c1bc <block_symlink+2ac/40c>
   b:   3d 00 0e 00 00            cmp    $0xe00,%eax
Code;  c012c1c1 <block_symlink+2b1/40c>
  10:   76 02                     jbe    14 <_EIP+0x14> c012c1c5 <block_symlink+2b5/40c>
Code;  c012c1c3 <block_symlink+2b3/40c>
  12:   0f 0b                     ud2a   


1 warning and 1 error issued.  Results may not be reliable.

--pf9I7BMVVzbSWLtt--
