Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRBHDcC>; Wed, 7 Feb 2001 22:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRBHDb4>; Wed, 7 Feb 2001 22:31:56 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:41884 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S129694AbRBHDbl>; Wed, 7 Feb 2001 22:31:41 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: 2.4.2-pre1: kernel oops during unmount
Date: Thu, 8 Feb 2001 04:35:54 +0100
X-Mailer: KMail [version 1.2]
Cc: "Jens Axboe" <axboe@suse.de>, "Chris Mason" <mason@suse.com>
MIME-Version: 1.0
Message-Id: <01020804355400.09234@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.2-pre1 + ReiserFS 3.6.25 (included) + loop-4

ksymoops 2.3.7 on i686 2.4.2-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-pre1/ (default)
     -m /boot/System.map (specified)
 
Unable to handle kernel NULL pointer dereference at virtual address 
00000000
c0143023
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0143023>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013206
eax: c14d3e00   ebx: c81051c0   ecx: cfa3f000   edx: cf7f36c0
esi: 00000000   edi: 00000000   ebp: ce469f3c   esp: ce469f04
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 9117, stackpage=ce469000)
Stack: c14d3e00 ce469f3c ce469f3c c025d5b8 00000000 00000000 c01430d5 
c025bf1c
       c14d3e00 ce469f3c c14d3e00 cf9b32c0 c025d580 c025d5b8 ce469f3c 
ce469f3c
       c01354d3 c14d3e00 c14c0440 c14d3e00 00000000 bffff53c c0134839 
c01358d1
Call Trace: [<c01430d5>] [<c01354d3>] [<c0134839>] [<c01358d1>] 
[<c01359aa>] [<c0122fcb>] [<c01359eb>]
       [<c0108fe7>]
Code: 8b 3f 3b 74 24 1c 74 65 8d 5e f8 8b 44 24 20 39 83 8c 00 00
 
>>EIP; c0143023 <invalidate_list+23/b0>   <=====
Trace; c01430d5 <invalidate_inodes+25/60>
Trace; c01354d3 <kill_super+83/130>
Trace; c0134839 <remove_vfsmnt+89/90>
Trace; c01358d1 <do_umount+1c1/1d0>
Trace; c01359aa <sys_umount+ca/100>
Trace; c0122fcb <sys_munmap+2b/40>
Trace; c01359eb <sys_oldumount+b/10>
Trace; c0108fe7 <system_call+33/38>
Code;  c0143023 <invalidate_list+23/b0>
00000000 <_EIP>:
Code;  c0143023 <invalidate_list+23/b0>   <=====
   0:   8b 3f                     mov    (%edi),%edi   <=====
Code;  c0143025 <invalidate_list+25/b0>
   2:   3b 74 24 1c               cmp    0x1c(%esp,1),%esi
Code;  c0143029 <invalidate_list+29/b0>
   6:   74 65                     je     6d <_EIP+0x6d> c0143090 
<invalidate_list+90/b0>
Code;  c014302b <invalidate_list+2b/b0>
   8:   8d 5e f8                  lea    0xfffffff8(%esi),%ebx
Code;  c014302e <invalidate_list+2e/b0>
   b:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c0143032 <invalidate_list+32/b0>
   f:   39 83 8c 00 00 00         cmp    %eax,0x8c(%ebx)

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
