Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129237AbQKLTXm>; Sun, 12 Nov 2000 14:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbQKLTXc>; Sun, 12 Nov 2000 14:23:32 -0500
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:53756 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S129237AbQKLTXS>;
	Sun, 12 Nov 2000 14:23:18 -0500
From: David Won <phlegm@home.com>
Date: Sun, 12 Nov 2000 14:19:11 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Newby help. Tons and tons of Oops
MIME-Version: 1.0
Message-Id: <00111214191100.01043@phlegmish.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not really that much of a newby (2 years of linux) but I am a newby to 
kernel dumps.
I'm running Redhat 7 with the latest kernel compiled using kgcc. I get many 
many oops, lockups and mysterious reboots. Can anybody help me determine what 
is causing this from ksymoops output below. I thought it might be something 
with my swapper file so I deleted and recreated the partition. I still have 
the same problem. This system was rock solid under 6.2 but is pretty much 
useless now. This is pnly the last couple of Oops after a reboot. I have 
dozens in my messages file. :(

Nov 12 14:10:08 phlegmish kernel: Unable to handle kernel paging request at 
virtual address ff57da13
Nov 12 14:10:08 phlegmish kernel: c012fe98
Nov 12 14:10:08 phlegmish kernel: *pde = 00000000
Nov 12 14:10:08 phlegmish kernel: Oops: 0002
Nov 12 14:10:08 phlegmish kernel: CPU:    0
Nov 12 14:10:08 phlegmish kernel: EIP:    0010:[<c012fe98>]
Nov 12 14:10:08 phlegmish kernel: EFLAGS: 00210286
Nov 12 14:10:08 phlegmish kernel: eax: c6550800   ebx: fffffff7   ecx: 
00000001   edx: ff57d9ff
Nov 12 14:10:08 phlegmish kernel: esi: 0000003c   edi: 0000003c   ebp: 
bffff5f0   esp: c0d55fb0
Nov 12 14:10:08 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 14:10:08 phlegmish kernel: Process bash (pid: 875, stackpage=c0d55000)
Nov 12 14:10:08 phlegmish kernel: Stack: c012f319 c0d54000 0000003c 080cd40c 
c010a407 00000001 080cd40c 0000003c 
Nov 12 14:10:08 phlegmish kernel:        0000003c 080cd40c bffff5f0 00000004 
0000002b 0000002b 00000004 400fb6a4 
Nov 12 14:10:08 phlegmish kernel:        00000023 00200206 bffff5c0 0000002b 
Nov 12 14:10:08 phlegmish kernel: Call Trace: [<c012f319>] [<c010a407>] 
Nov 12 14:10:08 phlegmish kernel: Code: ff 42 14 89 d0 c3 89 f6 8b 4c 24 04 
ff 49 14 0f 94 c0 84 c0 

>>EIP; c012fe98 <fget+20/28>   <=====
Trace; c012f319 <sys_write+15/c8>
Trace; c010a407 <system_call+33/38>
Code;  c012fe98 <fget+20/28>
00000000 <_EIP>:
Code;  c012fe98 <fget+20/28>   <=====
   0:   ff 42 14                  incl   0x14(%edx)   <=====
Code;  c012fe9b <fget+23/28>
   3:   89 d0                     mov    %edx,%eax
Code;  c012fe9d <fget+25/28>
   5:   c3                        ret    
Code;  c012fe9e <fget+26/28>
   6:   89 f6                     mov    %esi,%esi
Code;  c012fea0 <put_filp+0/38>
   8:   8b 4c 24 04               mov    0x4(%esp,1),%ecx
Code;  c012fea4 <put_filp+4/38>
   c:   ff 49 14                  decl   0x14(%ecx)
Code;  c012fea7 <put_filp+7/38>
   f:   0f 94 c0                  sete   %al
Code;  c012feaa <put_filp+a/38>
  12:   84 c0                     test   %al,%al

Nov 12 14:10:08 phlegmish kernel: Unable to handle kernel paging request at 
virtual address 8b103f15
Nov 12 14:10:08 phlegmish kernel: c012ef56
Nov 12 14:10:08 phlegmish kernel: *pde = 00000000
Nov 12 14:10:08 phlegmish kernel: Oops: 0000
Nov 12 14:10:08 phlegmish kernel: CPU:    0
Nov 12 14:10:08 phlegmish kernel: EIP:    0010:[<c012ef56>]
Nov 12 14:10:08 phlegmish kernel: EFLAGS: 00210282
Nov 12 14:10:08 phlegmish kernel: eax: 8b103f01   ebx: 8b103f01   ecx: 
8b103f01   edx: 00000400
Nov 12 14:10:08 phlegmish kernel: esi: 00000000   edi: c437c420   ebp: 
00000001   esp: c0d55e84
Nov 12 14:10:08 phlegmish kernel: ds: 0018   es: 0018   ss: 0018
Nov 12 14:10:08 phlegmish kernel: Process bash (pid: 875, stackpage=c0d55000)
Nov 12 14:10:08 phlegmish kernel: Stack: 00000007 00000000 c011b3ba 8b103f01 
c437c420 c55210e0 c0d54000 0000000b 
Nov 12 14:10:08 phlegmish kernel:        ff57da13 c011b9ba c437c420 00000000 
000003fd c01129f0 c010a8be 0000000b 
Nov 12 14:10:08 phlegmish kernel:        c0112d16 c021155e 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
