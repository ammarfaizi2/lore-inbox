Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTI0Q1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTI0Q1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 12:27:41 -0400
Received: from tristate.vision.ee ([194.204.30.144]:52710 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S262494AbTI0Q1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 12:27:35 -0400
From: Lenar =?iso-8859-15?q?L=F5hmus?= <lenar@vision.ee>
Organization: Vision Group
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5-mm4 OOPS when initializing MD devices
Date: Sat, 27 Sep 2003 19:27:31 +0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zpbd/2ynoy6wo59"
Message-Id: <200309271927.31418.lenar@vision.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zpbd/2ynoy6wo59
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Attached is decoded oops. Happened when booting with 2.6.0-test5-mm4.
Machine booted and still boots with 2.6.0-test4-mm6. RAID1 in use.

Lenar

--Boundary-00=_zpbd/2ynoy6wo59
Content-Type: text/plain;
  charset="us-ascii";
  name="result"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="result"

ksymoops 2.4.9 on i686 2.6.0-test4-mm6.  Options used
     -v /usr/src/linux-2.6.0-test5/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5-mm4 (specified)
     -m /boot/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Machine check exception polling timer started.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c024902c
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c024902c>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: f7c29c00   ecx: f7c05ec0   edx: f7c05ecc
esi: f7c05ecc   edi: f7fadde0   ebp: f7fadd7c   esp: f7fadd64
ds: 007b   es: 007b   ss: 0068
Stack: f7fadde0 f7fadd7c c0143251 f7c29c00 f7c05ecc f7fadde0 f7faddcc c0249238 
       00000005 00000000 00000000 00000246 00000001 00000003 f7c05ecc 0000000a 
       00000400 c02bbbe1 f7faddd8 f7c05ecc f7fadde0 f7faddcc c0187e1a f7c29c00 
Call Trace:
 [<c0143251>] invalidate_inode_pages+0x21/0x30
 [<c0249238>] do_md_run+0x128/0x480
 [<c0187e1a>] bdevname+0x2a/0x30
 [<c02498bf>] autorun_array+0x9f/0xd0
 [<c0121adc>] printk+0x13c/0x190
 [<c0187e1a>] bdevname+0x2a/0x30
 [<c0249afc>] autorun_devices+0x20c/0x250
 [<c024c82d>] autostart_arrays+0x2d/0xc9
 [<c016e798>] igrab+0x48/0x50
 [<c024ae49>] md_ioctl+0x719/0x750
 [<c015da5a>] blkdev_open+0x3a/0x80
 [<c018cddb>] devfs_open+0x10b/0x110
 [<c018ccd0>] devfs_open+0x0/0x110
 [<c0154812>] dentry_open+0x142/0x210
 [<c01546cb>] filp_open+0x5b/0x60
 [<c0210c70>] blkdev_ioctl+0x90/0x3ca
 [<c0167404>] sys_ioctl+0xf4/0x270
 [<c032e11d>] md_run_setup+0x6d/0xd0
 [<c032ce89>] prepare_namespace+0x19/0x110
 [<c01301b2>] init_workqueues+0x12/0x60
 [<c01070da>] init+0x3a/0x160
 [<c01070a0>] init+0x0/0x160
 [<c0109329>] kernel_thread_helper+0x5/0xc
Code: 44 24 04 e8 97 89 ed ff 89 34 24 e8 ef f5 ff ff e9 36 ff ff ff 89 75 cc e9 ca fe ff ff 89 f6 55 89 e5 57 56 53 83 ec 0c 8b 45 0c <8b> 18 89 1c 24 e8 fa de ff ff 85 c0 89 c6 0f 84 89 00 00 00 bf 


>>EIP; c024902c <md_probe+c/d0>   <=====

>>ebx; f7c29c00 <_end+37869e08/3fc3d208>
>>ecx; f7c05ec0 <_end+378460c8/3fc3d208>
>>edx; f7c05ecc <_end+378460d4/3fc3d208>
>>esi; f7c05ecc <_end+378460d4/3fc3d208>
>>edi; f7fadde0 <_end+37bedfe8/3fc3d208>
>>ebp; f7fadd7c <_end+37bedf84/3fc3d208>
>>esp; f7fadd64 <_end+37bedf6c/3fc3d208>

Trace; c0143251 <invalidate_inode_pages+21/30>
Trace; c0249238 <do_md_run+128/480>
Trace; c0187e1a <bdevname+2a/30>
Trace; c02498bf <autorun_array+9f/d0>
Trace; c0121adc <printk+13c/190>
Trace; c0187e1a <bdevname+2a/30>
Trace; c0249afc <autorun_devices+20c/250>
Trace; c024c82d <autostart_arrays+2d/c9>
Trace; c016e798 <igrab+48/50>
Trace; c024ae49 <md_ioctl+719/750>
Trace; c015da5a <blkdev_open+3a/80>
Trace; c018cddb <devfs_open+10b/110>
Trace; c018ccd0 <devfs_open+0/110>
Trace; c0154812 <dentry_open+142/210>
Trace; c01546cb <filp_open+5b/60>
Trace; c0210c70 <blkdev_ioctl+90/3ca>
Trace; c0167404 <sys_ioctl+f4/270>
Trace; c032e11d <md_run_setup+6d/d0>
Trace; c032ce89 <prepare_namespace+19/110>
Trace; c01301b2 <init_workqueues+12/60>
Trace; c01070da <init+3a/160>
Trace; c01070a0 <init+0/160>
Trace; c0109329 <kernel_thread_helper+5/c>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0249001 <analyze_sbs+191/1b0>
00000000 <_EIP>:
Code;  c0249001 <analyze_sbs+191/1b0>
   0:   44                        inc    %esp
Code;  c0249002 <analyze_sbs+192/1b0>
   1:   24 04                     and    $0x4,%al
Code;  c0249004 <analyze_sbs+194/1b0>
   3:   e8 97 89 ed ff            call   ffed899f <_EIP+0xffed899f>
Code;  c0249009 <analyze_sbs+199/1b0>
   8:   89 34 24                  mov    %esi,(%esp,1)
Code;  c024900c <analyze_sbs+19c/1b0>
   b:   e8 ef f5 ff ff            call   fffff5ff <_EIP+0xfffff5ff>
Code;  c0249011 <analyze_sbs+1a1/1b0>
  10:   e9 36 ff ff ff            jmp    ffffff4b <_EIP+0xffffff4b>
Code;  c0249016 <analyze_sbs+1a6/1b0>
  15:   89 75 cc                  mov    %esi,0xffffffcc(%ebp)
Code;  c0249019 <analyze_sbs+1a9/1b0>
  18:   e9 ca fe ff ff            jmp    fffffee7 <_EIP+0xfffffee7>
Code;  c024901e <analyze_sbs+1ae/1b0>
  1d:   89 f6                     mov    %esi,%esi
Code;  c0249020 <md_probe+0/d0>
  1f:   55                        push   %ebp
Code;  c0249021 <md_probe+1/d0>
  20:   89 e5                     mov    %esp,%ebp
Code;  c0249023 <md_probe+3/d0>
  22:   57                        push   %edi
Code;  c0249024 <md_probe+4/d0>
  23:   56                        push   %esi
Code;  c0249025 <md_probe+5/d0>
  24:   53                        push   %ebx
Code;  c0249026 <md_probe+6/d0>
  25:   83 ec 0c                  sub    $0xc,%esp
Code;  c0249029 <md_probe+9/d0>
  28:   8b 45 0c                  mov    0xc(%ebp),%eax

This decode from eip onwards should be reliable

Code;  c024902c <md_probe+c/d0>
00000000 <_EIP>:
Code;  c024902c <md_probe+c/d0>   <=====
   0:   8b 18                     mov    (%eax),%ebx   <=====
Code;  c024902e <md_probe+e/d0>
   2:   89 1c 24                  mov    %ebx,(%esp,1)
Code;  c0249031 <md_probe+11/d0>
   5:   e8 fa de ff ff            call   ffffdf04 <_EIP+0xffffdf04>
Code;  c0249036 <md_probe+16/d0>
   a:   85 c0                     test   %eax,%eax
Code;  c0249038 <md_probe+18/d0>
   c:   89 c6                     mov    %eax,%esi
Code;  c024903a <md_probe+1a/d0>
   e:   0f 84 89 00 00 00         je     9d <_EIP+0x9d>
Code;  c0249040 <md_probe+20/d0>
  14:   bf                        .byte 0xbf


1 error issued.  Results may not be reliable.

--Boundary-00=_zpbd/2ynoy6wo59--
