Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266500AbRGQNbp>; Tue, 17 Jul 2001 09:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266496AbRGQNbf>; Tue, 17 Jul 2001 09:31:35 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:55557 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S266500AbRGQNbV>;
	Tue, 17 Jul 2001 09:31:21 -0400
Message-Id: <200107171331.HAA246192@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6-ac5 not booting on highmem machine
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Tue, 17 Jul 2001 07:31:25 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an 8 processor PIII Xeon machine with 8GB of ram.  The recent
-ac5 patch does not boot, panicking immediately after
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
is printed on the console.  The following ksymoops is printed.  If any
more information would be useful in tracking down this error, please
let me know.

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -v /home/lessem/linux/linux-ac/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.6-ac5/ (specified)
     -m /boot/System.map-2.4.6-ac5 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address f8801000
c024fab6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c024fab6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: f8800000   ebx: f88000e9   ecx: 03ff810c   edx: 000006f0
esi: 00000f17   edi: c0203816   ebp: ecc3ff80   esp: c9cbbfbc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c9cbb000)
Stack: c027f70c c024bfc0 00000000 0008e000 44000000 03ff80e9 00000024 c024c884
       c9cba000 c024c8c2 c0105075 00010f00 c024bfc0 c01054fc 00000000 00000078
       00098700
Call Trace: [<c0105075>] [<c01054fc>]
Code: 8a 04 1e 00 44 24 13 46 39 ee 72 f4 80 7c 24 13 00 74 08 53

>>EIP; c024fab6 <sbf_init+ee/198>   <=====
Trace; c0105075 <init+29/154>
Trace; c01054fc <kernel_thread+28/38>
Code;  c024fab6 <sbf_init+ee/198>
00000000 <_EIP>:
Code;  c024fab6 <sbf_init+ee/198>   <=====
   0:   8a 04 1e                  mov    (%esi,%ebx,1),%al   <=====
Code;  c024fab9 <sbf_init+f1/198>
   3:   00 44 24 13               add    %al,0x13(%esp,1)
Code;  c024fabd <sbf_init+f5/198>
   7:   46                        inc    %esi
Code;  c024fabe <sbf_init+f6/198>
   8:   39 ee                     cmp    %ebp,%esi
Code;  c024fac0 <sbf_init+f8/198>
   a:   72 f4                     jb     0 <_EIP>
Code;  c024fac2 <sbf_init+fa/198>
   c:   80 7c 24 13 00            cmpb   $0x0,0x13(%esp,1)
Code;  c024fac7 <sbf_init+ff/198>
  11:   74 08                     je     1b <_EIP+0x1b> c024fad1 <sbf_init+109/198>
Code;  c024fac9 <sbf_init+101/198>
  13:   53                        push   %ebx

