Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTJEV44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTJEV44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:56:56 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:10370 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S263885AbTJEV4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:56:46 -0400
Message-ID: <3F80939C.1020802@comcast.net>
Date: Sun, 05 Oct 2003 14:56:44 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030927
X-Accept-Language: en-us
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6-mm4
References: <3F80717E.6060300@comcast.net>
In-Reply-To: <3F80717E.6060300@comcast.net>
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050105070703000005020602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050105070703000005020602
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Walt H wrote:
> Reverting RD0-initrd-B6.patch allows initrd to
> work again, and my machine to boot. 

However, I get an oops after kernel init and while running the init
scripts.


--------------050105070703000005020602
Content-Type: text/plain;
 name="decodedoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="decodedoops.txt"

ksymoops 2.4.9 on i686 2.6.0-test6-mm1.  Options used
     -v /usr/src/linux-2.6.0-test6-mm4/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.0-test6-mm4/ (specified)
     -m /boot/System.map-2.6.0-test6-mm4 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000034
c01a36d4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01a36d4>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000000   ebx: 00000000   ecx: 00007dec   edx: 00000001
esi: 0000000a   edi: f75c46a0   ebp: f7fa2a80   esp: f6cb3e40
ds: 007b   es: 007b   ss: 0068
Stack: f75c46a0 c03221c0 f6b9fc50 c0305643 c01a11c4 f6ba1240 f6b9fc50 0000000d 
       c030563f f75c46a0 ffffffea fffffff4 f6ba213c f6ba20d0 f6ba1240 c01792ef 
       f6ba20d0 f6ba1240 c0322160 00000000 f6cb3f70 f767f500 00000000 f6ba1300 
Call Trace:
 [<c01a11c4>] proc_pident_lookup+0x104/0x260
 [<c01792ef>] real_lookup+0xcf/0x100
 [<c0183592>] dput+0x22/0x2d0
 [<c0179c58>] link_path_walk+0x668/0x9f0
 [<c014ce7d>] buffered_rmqueue+0xed/0x1d0
 [<c012bb4c>] do_exit+0x39c/0x4c0
 [<c019fde4>] proc_info_read+0x74/0x160
 [<c0168ea8>] filp_open+0x68/0x70
 [<c0169ede>] vfs_read+0xbe/0x130
 [<c016a1b2>] sys_read+0x42/0x70
 [<c02cc36e>] sysenter_past_esp+0x43/0x65
Code: f3 01 c0 29 c2 be 0a 00 00 00 89 c8 f7 f6 89 da 89 94 24 b4 00 00 00 89 84 24 b0 00 00 00 8b 87 ac 05 00 00 8b 94 24 c0 00 00 00 <8b> 58 34 8b 70 2c 8b 47 40 89 84 24 ac 00 00 00 8b 87 64 01 00 


>>EIP; c01a36d4 <proc_pid_stat+2c4/5a0>   <=====

>>edi; f75c46a0 <_end+3718bbb0/3fbc4510>
>>ebp; f7fa2a80 <_end+37b69f90/3fbc4510>
>>esp; f6cb3e40 <_end+3687b350/3fbc4510>

Trace; c01a11c4 <proc_pident_lookup+104/260>
Trace; c01792ef <real_lookup+cf/100>
Trace; c0183592 <dput+22/2d0>
Trace; c0179c58 <link_path_walk+668/9f0>
Trace; c014ce7d <buffered_rmqueue+ed/1d0>
Trace; c012bb4c <do_exit+39c/4c0>
Trace; c019fde4 <proc_info_read+74/160>
Trace; c0168ea8 <filp_open+68/70>
Trace; c0169ede <vfs_read+be/130>
Trace; c016a1b2 <sys_read+42/70>
Trace; c02cc36e <sysenter_past_esp+43/65>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01a36a9 <proc_pid_stat+299/5a0>
00000000 <_EIP>:
Code;  c01a36a9 <proc_pid_stat+299/5a0>
   0:   f3 01 c0                  repz add %eax,%eax
Code;  c01a36ac <proc_pid_stat+29c/5a0>
   3:   29 c2                     sub    %eax,%edx
Code;  c01a36ae <proc_pid_stat+29e/5a0>
   5:   be 0a 00 00 00            mov    $0xa,%esi
Code;  c01a36b3 <proc_pid_stat+2a3/5a0>
   a:   89 c8                     mov    %ecx,%eax
Code;  c01a36b5 <proc_pid_stat+2a5/5a0>
   c:   f7 f6                     div    %esi
Code;  c01a36b7 <proc_pid_stat+2a7/5a0>
   e:   89 da                     mov    %ebx,%edx
Code;  c01a36b9 <proc_pid_stat+2a9/5a0>
  10:   89 94 24 b4 00 00 00      mov    %edx,0xb4(%esp,1)
Code;  c01a36c0 <proc_pid_stat+2b0/5a0>
  17:   89 84 24 b0 00 00 00      mov    %eax,0xb0(%esp,1)
Code;  c01a36c7 <proc_pid_stat+2b7/5a0>
  1e:   8b 87 ac 05 00 00         mov    0x5ac(%edi),%eax
Code;  c01a36cd <proc_pid_stat+2bd/5a0>
  24:   8b 94 24 c0 00 00 00      mov    0xc0(%esp,1),%edx

This decode from eip onwards should be reliable

Code;  c01a36d4 <proc_pid_stat+2c4/5a0>
00000000 <_EIP>:
Code;  c01a36d4 <proc_pid_stat+2c4/5a0>   <=====
   0:   8b 58 34                  mov    0x34(%eax),%ebx   <=====
Code;  c01a36d7 <proc_pid_stat+2c7/5a0>
   3:   8b 70 2c                  mov    0x2c(%eax),%esi
Code;  c01a36da <proc_pid_stat+2ca/5a0>
   6:   8b 47 40                  mov    0x40(%edi),%eax
Code;  c01a36dd <proc_pid_stat+2cd/5a0>
   9:   89 84 24 ac 00 00 00      mov    %eax,0xac(%esp,1)
Code;  c01a36e4 <proc_pid_stat+2d4/5a0>
  10:   8b                        .byte 0x8b
Code;  c01a36e5 <proc_pid_stat+2d5/5a0>
  11:   87 64 01 00               xchg   %esp,0x0(%ecx,%eax,1)


--------------050105070703000005020602--


