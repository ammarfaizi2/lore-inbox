Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279201AbRKAPxN>; Thu, 1 Nov 2001 10:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279202AbRKAPxD>; Thu, 1 Nov 2001 10:53:03 -0500
Received: from smtp-rt-14.wanadoo.fr ([193.252.19.224]:26276 "EHLO
	adansonia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279201AbRKAPwx>; Thu, 1 Nov 2001 10:52:53 -0500
Message-ID: <3BE1C260.2010507@free.fr>
Date: Thu, 01 Nov 2001 16:45:04 -0500
From: FORT David <popo.enlighted@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011012
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Oops on 2.4.13
Content-Type: multipart/mixed;
 boundary="------------050804020701040100020003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050804020701040100020003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I got this Oops last night, the funny thing is that the Ooops occured in
kswapd and that my box doesn't have any swap. The box is SMP with
768M ram, the kernel is tainted but by a kernel driver which hasn't set
any licence(can't remember which one). When the Ooops occured i was
encoding some mp3 and compiling a big thing(TAO+ACE). The call stack
trace is really close to an oops i've seen there( a "suspicious memory" 
thread
started and finally linus claimed that it could be a real bug, but no 
solution
were posted).


-- 
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/PHP/java/JSPs              |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlightened....          |  ^^-^^                        %
%                              HomePage: http://www.enlightened-popo.net  %
%---------- -- This was sent by Djinn running Linux 2.4.13 -- ------------%


--------------050804020701040100020003
Content-Type: text/plain;
 name="31-10-2001-oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="31-10-2001-oops"

ksymoops 2.4.3 on i686 2.4.13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel paging request at virtual address 00008008
c013c7e4
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c013c7e4>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00008000   ebx: e228f220   ecx: 00008000   edx: e228f240
esi: efee5f34   edi: e02ee608   ebp: efee5f48   esp: efee5efc
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=efee5000)
Stack: c0149840 00008000 c0148bcd c1c0a37c e228f040 e228f040 e228f220 c0149898 
       e228f220 e02ee7e8 e02ee7e0 c0149b25 efee5f34 00004f8c e228f408 e27379a8 
       00000011 000001d0 00000006 000001d0 c0149b60 00000000 c012f0e6 00000006 
Call Trace: [<c0149840>] [<c0148bcd>] [<c0149898>] [<c0149b25>] [<c0149b60>] 
   [<c012f0e6>] [<c012f12c>] [<c012f1e1>] [<c012f256>] [<c012f3a1>] [<c012f300>] 
   [<c0105000>] [<c0105656>] [<c012f300>] 
Code: f0 ff 49 08 0f 94 c0 84 c0 74 2d f0 fe 0d 08 92 25 c0 0f 88 

>>EIP; c013c7e4 <cdput+4/40>   <=====
Trace; c0149840 <clear_inode+c0/e0>
Trace; c0148bcc <destroy_inode+2c/40>
Trace; c0149898 <dispose_list+38/50>
Trace; c0149b24 <prune_icache+f4/110>
Trace; c0149b60 <shrink_icache_memory+20/40>
Trace; c012f0e6 <shrink_caches+76/90>
Trace; c012f12c <try_to_free_pages+2c/60>
Trace; c012f1e0 <kswapd_balance_pgdat+50/a0>
Trace; c012f256 <kswapd_balance+26/50>
Trace; c012f3a0 <kswapd+a0/c0>
Trace; c012f300 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105656 <kernel_thread+26/30>
Trace; c012f300 <kswapd+0/c0>
Code;  c013c7e4 <cdput+4/40>
00000000 <_EIP>:
Code;  c013c7e4 <cdput+4/40>   <=====
   0:   f0 ff 49 08               lock decl 0x8(%ecx)   <=====
Code;  c013c7e8 <cdput+8/40>
   4:   0f 94 c0                  sete   %al
Code;  c013c7ea <cdput+a/40>
   7:   84 c0                     test   %al,%al
Code;  c013c7ec <cdput+c/40>
   9:   74 2d                     je     38 <_EIP+0x38> c013c81c <cdput+3c/40>
Code;  c013c7ee <cdput+e/40>
   b:   f0 fe 0d 08 92 25 c0      lock decb 0xc0259208
Code;  c013c7f6 <cdput+16/40>
  12:   0f 88 00 00 00 00         js     18 <_EIP+0x18> c013c7fc <cdput+1c/40>


1 warning issued.  Results may not be reliable.

--------------050804020701040100020003--

