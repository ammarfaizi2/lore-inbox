Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSDEHsu>; Fri, 5 Apr 2002 02:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312363AbSDEHsd>; Fri, 5 Apr 2002 02:48:33 -0500
Received: from [203.199.83.24] ([203.199.83.24]:23773 "HELO
	mailweb12.rediffmail.com") by vger.kernel.org with SMTP
	id <S312357AbSDEHsT>; Fri, 5 Apr 2002 02:48:19 -0500
Date: 5 Apr 2002 07:42:51 -0000
Message-ID: <20020405074251.22007.qmail@mailweb12.rediffmail.com>
MIME-Version: 1.0
From: "Umaid Singh Rajpurohit" <sunadm@rediffmail.com>
Reply-To: "Umaid Singh Rajpurohit" <sunadm@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel NULL pointer dereference 
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

we are running clearcase,sun grid engine on RedHat Linux 7.1 
(kernel 2.4.2) on IBM Xseries one U servers that has
two CPU's and we mount all the files to be processed using 
autofs.
Here is uname -a
Linux  2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686 
unknown

I have more then sufficient physical memory and swap space
Here is some swap space detail form top

Mem:  1543868K av,  507684K used, 1036184K free, 0K shrd, 317576K 
buff Swap: 5116576K av,0K used, 5116576K free 33076K  cached


we are running n number of IBM X Series server every now and then   
one or two servers crashes and don't allow me to do anything 
except hard reset.

   The /var/log/messages says something like:

                      Jan  6 17:59:45  kernel: Unable to handle 
kernel NULL pointer
                      dereference at virtual address 00000014
                      Jan  6 17:59:45  kernel:  printing eip:
                      Jan  6 17:59:45  kernel: f8b510b2
                      Jan  6 17:59:45  kernel: pgd entry eb571000: 
0000000000000000
                      Jan  6 17:59:45  kernel: pmd entry eb571000: 
0000000000000000
                      Jan  6 17:59:45  kernel: ... pmd not 
present!
                      Jan  6 17:59:45  kernel: Oops: 0000
                      Jan  6 17:59:45  kernel: CPU:    1
                      Jan  6 17:59:45  kernel: EIP:    
0010:[<f8b510b2>]
                      Jan  6 17:59:45  kernel: EFLAGS: 00010246
                      Jan  6 17:59:45  kernel: eax: d951f220   
ebx: 00000040   ecx: c027e140
                      edx: 00000000
                      Jan  6 17:59:45  kernel: esi: 00000000   
edi: ea10fe60   ebp: ea10fe20
                      esp: ea10fde8
                      Jan  6 17:59:45  kernel: ds: 0018   es: 0018   
ss: 0018
                      Jan  6 17:59:45  kernel: Process tcsh (pid: 
31185, stackpage=ea10f000)
                      Jan  6 17:59:45  kernel: Stack: 00000040 
f68c86c4 ea10fea0 d32e2ca0
                      00000040 f68c86c4 ea10fea0 00000000
                      Jan  6 17:59:45  kernel:        00000000 
00000000 f68c86c4 d951f220
                      00029508 00000002 ea10fe70 f8b4c6cf
                      Jan  6 17:59:45  kernel:        00000001 
ea10fe60 d32e2ca0 f8b4c423
                      00000040 f68c86c4 d32e2ca0 000079d1
                      Jan  6 17:59:45  kernel: Call Trace: 
[<f8b4c6cf>] [<f8b4c423>]
                      [<f8b56034>] [<f8b8a764>] [<f8b4d497>] 
[<f8b754cc>] [<f8b7042a>]
                      Jan  6 17:59:45  kernel:        [<f8b70420>] 
[<f8b6fbef>] [dput+59/416]
                      [permission+69/144] [<f8b6ee70>] 
[path_walk+2392/2432]
                      [__user_walk+58/96] [sys_stat64+19/112]
                      Jan  6 17:59:45  kernel:        [<f8b70420>] 
[<f8b6fbef>] [<c014e8cb>]
                      [<c01458a5>] [<f8b6ee70>] [<c01465f8>] 
[<c0146b0a>] [<c0143143>]
                      Jan  6 17:59:45  kernel:        
[error_code+52/60] [system_call+51/56]
                      Jan  6 17:59:45  kernel:        [<c0109300>] 
[<c01091cb>]
                      Jan  6 17:59:45  kernel:
                      Jan  6 17:59:45  kernel: Code: 83 7e 14 06 
0f 85 f7 00 00 00 83 c4 f8 6a
                      00 56 e8 3d a8 ff
                      Jan  6 17:59:45  kernel: Unable to handle 
kernel NULL pointer
                      dereference at virtual address 00000014
                      Jan  6 17:59:45  kernel:  printing eip:
                      Jan  6 17:59:45  kernel: f8b510b2
                      Jan  6 17:59:45  kernel: pgd entry d4f8d000: 
0000000000000000
                      Jan  6 17:59:45  kernel: pmd entry d4f8d000: 
0000000000000000
                      Jan  6 17:59:45  kernel: ... pmd not 
present!
                      Jan  6 17:59:45  kernel: Oops: 0000
                      Jan  6 17:59:45  kernel: CPU:    0
                      Jan  6 17:59:45  kernel: EIP:    
0010:[<f8b510b2>]
                      Jan  6 17:59:45  kernel: EFLAGS: 00010246
                      Jan  6 17:59:45  kernel: eax: d951f220   
ebx: 00000040   ecx: c027e140
                      edx: 00000000
                      Jan  6 17:59:45  kernel: esi: 00000000   
edi: e6041e60   ebp: e6041e20
                      esp: e6041de8
                      Jan  6 17:59:45  kernel: ds: 0018   es: 0018   
ss: 0018
                      Jan  6 17:59:45  kernel: Process tcsh (pid: 
31184, stackpage=e6041000)
                      Jan  6 17:59:45  kernel: Stack: 00000040 
f68c8ec8 e6041ea0 eca3ace0
                      00000040 f68c8ec8 e6041ea0 00000000
                      Jan  6 17:59:45  kernel:        00000000 
00000000 f68c8ec8 d951f220
                      00029508 00000002 e6041e70 f8b4c6cf
                      Jan  6 17:59:45  kernel:        00000001 
e6041e60 eca3ace0 f8b4c423
                      00000040 f68c8ec8 eca3ace0 000079d0
                      Jan  6 17:59:45  kernel: Call Trace: 
[<f8b4c6cf>] [<f8b4c423>]
                      [<f8b56034>] [<f8b8a764>] [<f8b4d497>] 
[<f8b754cc>] [<f8b7042a>]
                      Jan  6 17:59:45  kernel:        [<f8b70420>] 
[<f8b6fbef>] [dput+59/416]
                      [permission+69/144] [<f8b6ee70>] 
[path_walk+2392/2432]
                      [__user_walk+58/96] [sys_stat64+19/112]
                      Jan  6 17:59:45  kernel:        [<f8b70420>] 
[<f8b6fbef>] [<c014e8cb>]
                      [<c01458a5>] [<f8b6ee70>] [<c01465f8>] 
[<c0146b0a>] [<c0143143>]


  I am unable to find any information on it.Can any one help me 
out.If you need any other information please mail me.

Warm Regard
umaid
linux support (TI india)
