Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129244AbQJ0Gaf>; Fri, 27 Oct 2000 02:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbQJ0GaZ>; Fri, 27 Oct 2000 02:30:25 -0400
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:59129 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S129094AbQJ0GaP>;
	Fri, 27 Oct 2000 02:30:15 -0400
From: David Won <phlegm@home.com>
Date: Fri, 27 Oct 2000 02:26:10 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: kernel newby help.... What's causing my Oops
MIME-Version: 1.0
Message-Id: <00102702261003.01068@phlegmish.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need some help. My system keeps locking up on me or suddenly rebooting.
Sometimes I'm able to telnet in and shutdown but usually I have to hit
the power button and pray that the disk isn't thrashed. I'm running
RedHat 7 and it happens with the supplied kernel or with a new kernel.
I'm currently running linux-2.4.0-test8 right now and it is compiled
using kgcc. (Found that tip in a message here) I searched through my logs
for help and find lots of these Oops messages. I then did some searching
on what Oops is. I was told to run ksymoops to get more info but this
extra info is way over my head. I'm posting this here in the hopes that
somebody can help me pin down what module or kernel setting is causing
all my problems. Thanks for any help.


Oct 22 22:37:20 phlegmish kernel: Unable to handle kernel paging request at 
virtual address 00018486
Oct 22 22:37:20 phlegmish kernel: c880eae3
Oct 22 22:37:20 phlegmish kernel: *pde = 00000000
Oct 22 22:37:20 phlegmish kernel: Oops: 0000
Oct 22 22:37:20 phlegmish kernel: CPU:    0
Oct 22 22:37:20 phlegmish kernel: EIP:    
0010:[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-234781/96]
Oct 22 22:37:20 phlegmish kernel: EFLAGS: 00010046
Oct 22 22:37:20 phlegmish kernel: eax: 00000012   ebx: 00000000   ecx: 
00000000   edx: 00014402
Oct 22 22:37:20 phlegmish kernel: esi: c1715ef8   edi: 00014402   ebp: 
c697e4e0   esp: c1715ec4
Oct 22 22:37:20 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Oct 22 22:37:20 phlegmish kernel: Process esd (pid: 2356, stackpage=c1715000)
Oct 22 22:37:20 phlegmish kernel: Stack: 00000000 c49e5204 00014402 c697e4e0 
c671c000 00000012 00200203 c71d3008 
Oct 22 22:37:20 phlegmish kernel:        00000086 c8812457 00014402 00000000 
00000012 00000000 00000003 0000ffff 
Oct 22 22:37:20 phlegmish kernel:        10100001 00000000 00000002 0000ffff 
00000000 00000000 00000000 c49e5200 
Oct 22 22:37:20 phlegmish kernel: Call Trace: 
[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-220073/96] 
[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-237584/96] 
[smbfs:__insmod_smbfs_O/lib/modules/2.4.0-test8/kernel/fs/smbfs/sm+-245443/96] 
[__fput+35/144] [_fput+17/64] [fput+18/24] [filp_close+82/92] 
Oct 22 22:37:20 phlegmish kernel: Code: 0f b7 aa 84 40 00 00 89 ef 83 c7 04 
89 4c 24 1c 83 c6 04 8b 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b7 aa 84 40 00 00      movzwl 0x4084(%edx),%ebp
Code;  00000007 Before first symbol
   7:   89 ef                     mov    %ebp,%edi
Code;  00000009 Before first symbol
   9:   83 c7 04                  add    $0x4,%edi
Code;  0000000c Before first symbol
   c:   89 4c 24 1c               mov    %ecx,0x1c(%esp,1)
Code;  00000010 Before first symbol
  10:   83 c6 04                  add    $0x4,%esi
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Oct 22 23:00:02 phlegmish kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000018
Oct 22 23:00:02 phlegmish kernel: c015984b
Oct 22 23:00:02 phlegmish kernel: *pde = 00000000
Oct 22 23:00:02 phlegmish kernel: Oops: 0000
Oct 22 23:00:02 phlegmish kernel: CPU:    0
Oct 22 23:00:02 phlegmish kernel: EIP:    0010:[shm_swap_core+55/168]
Oct 22 23:00:02 phlegmish kernel: EFLAGS: 00013286
Oct 22 23:00:02 phlegmish kernel: eax: 0a0d0a0d   ebx: c1283400   ecx: 
00000031   edx: 00000000
Oct 22 23:00:02 phlegmish kernel: esi: 00000000   edi: c31d0540   ebp: 
00000001   esp: c1217f58
Oct 22 23:00:02 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Oct 22 23:00:02 phlegmish kernel: Process kswapd (pid: 2, stackpage=c1217000)
Oct 22 23:00:02 phlegmish kernel: Stack: c31d0540 00000000 c024b111 00000003 
c01599f7 c31d0540 00000001 001fa100 
Oct 22 23:00:02 phlegmish kernel:        c1217f88 c1217f8c c024b10c c024b114 
00000007 c01272bf 001fa100 c012735d 
Oct 22 23:00:02 phlegmish kernel:       
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
