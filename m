Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129119AbQJaWgA>; Tue, 31 Oct 2000 17:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbQJaWfu>; Tue, 31 Oct 2000 17:35:50 -0500
Received: from fep01.swip.net ([130.244.199.129]:9600 "EHLO fep01-svc.swip.net")
	by vger.kernel.org with ESMTP id <S129119AbQJaWfo>;
	Tue, 31 Oct 2000 17:35:44 -0500
Message-ID: <39FF4BB0.3030002@swipnet.se>
Date: Tue, 31 Oct 2000 23:46:08 +0100
From: Jarek Luberek <jarek@swipnet.se>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test9 i686; en-US; m18) Gecko/20001010
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jarek@swipnet.se
Subject: Oops in test10 during module loading of 3c509
Content-Type: multipart/mixed;
 boundary="------------090201050301060308060401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201050301060308060401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090201050301060308060401
Content-Type: text/plain;
 name="oops-mail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops-mail"

Just a short Oops report for test10. 

Extra Patches: reiserfs: linux-2.4.0-test9-reiserfs-3.6.18
no patch collisions with this patch and test10

test10-pre7 worked fine.

Oops during loading of 3c509-module. 
System: Dual PIII/450 256M 

Greetings,
jarek

-------------------------------------------------

Oct 31 23:18:52 marvin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000070 
Oct 31 23:18:52 marvin kernel: d08b85ab 
Oct 31 23:18:52 marvin kernel: *pde = 00000000 
Oct 31 23:18:52 marvin kernel: Oops: 0002 
Oct 31 23:18:52 marvin kernel: CPU:    1 
Oct 31 23:18:52 marvin kernel: EIP:    0010:[3c509:el3_probe+1355/5024] 
Oct 31 23:18:53 marvin kernel: EFLAGS: 00010202 
Oct 31 23:18:53 marvin kernel: eax: 00000000   ebx: 00000070   ecx: 00000000   edx: 385a1000 
Oct 31 23:18:53 marvin kernel: esi: 00000003   edi: cf6ddf2e   ebp: 00000220   esp: cf6ddee4 
Oct 31 23:18:53 marvin kernel: ds: 0018   es: 0018   ss: 0018 
Oct 31 23:18:53 marvin kernel: Process modprobe (pid: 220, stackpage=cf6dd000) 
Oct 31 23:18:53 marvin kernel: Stack: 00000000 00000000 00000000 ffffffea c02c3e18 00000000 ffffffea c02c3c40  
Oct 31 23:18:53 marvin kernel:        0000e68c 0000e68d 00000000 0000000b 00ff0000 00000000 ffffffea c1044010  
Oct 31 23:18:53 marvin kernel:        c02c3c40 385a1000 fffff8e8 d08b935b 00000000 d08b8000 00000000 c011a6cf  
Oct 31 23:18:53 marvin kernel: Call Trace: [3c509:el3_probe+4859/5024] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+0/96] [sys_init_module+1143/1324] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+72/96] [3c509:__insmod_3c509_O/lib/modules/2.4.0-test10/kernel/drivers/ne+72/96] [system_call+51/56]  
Oct 31 23:18:53 marvin kernel: Code: 89 50 70 8b 54 24 48 66 89 53 04 89 68 20 8b 54 24 2c 89 50  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 50 70                  mov    %edx,0x70(%eax)
Code;  00000003 Before first symbol
   3:   8b 54 24 48               mov    0x48(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   66 89 53 04               mov    %dx,0x4(%ebx)
Code;  0000000b Before first symbol
   b:   89 68 20                  mov    %ebp,0x20(%eax)
Code;  0000000e Before first symbol
   e:   8b 54 24 2c               mov    0x2c(%esp,1),%edx
Code;  00000012 Before first symbol
  12:   89 50 00                  mov    %edx,0x0(%eax)

------------------------------------------------------------------

Module                  Size  Used by
es1371                 29968   0  (unused)
ac97_codec              7888   0  [es1371]
3c509                   7472   1  (initializing)

--------------090201050301060308060401--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
