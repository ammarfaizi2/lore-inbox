Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBWNsH>; Fri, 23 Feb 2001 08:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRBWNr5>; Fri, 23 Feb 2001 08:47:57 -0500
Received: from atlantis.hlfl.org ([213.41.91.231]:28679 "HELO
	atlantis.hlfl.org") by vger.kernel.org with SMTP id <S129065AbRBWNrs>;
	Fri, 23 Feb 2001 08:47:48 -0500
Date: Fri, 23 Feb 2001 14:47:45 +0100
From: "Arnaud S . Launay" <asl@launay.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: OOPS with 2.4.2-ac2
Message-ID: <20010223144745.A28278@profile4u.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm experimenting a 100% reproducable oops, ksymoops filtered
below, when trying to connect via ssh to the 2.4.2-ac2 machine.
(openssh 2.1.1p1)


ksymoops 2.3.7 on i686 2.4.2-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-ac2/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
cff761e0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<cff761e0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cff761e0
esi: 00000000   edi: 00000000   ebp: c140b2a0   esp: cd2b1f98
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 156, stackpage=cd2b1000)
Stack: 00000003 ce2fc680 c1407cc0 00000009 00000001 ce239000 cd2b0000 00000003 
       bfffe238 bffff310 c0108fc3 4016c03b bfffe238 40172ba4 00000003 bfffe238 
       bffff310 00000063 0000002b 0000002b 00000063 4011d691 00000023 00000246 
Call Trace: [<c0108fc3>] 
Code: c0 2b 4a c1 a0 b2 40 c1 60 61 f7 cf ec 60 f7 cf 50 f6 f7 cf 

>>EIP; cff761e0 <_end+fd642b0/10612130>   <=====
Trace; c0108fc3 <system_call+33/38>
Code;  cff761e0 <_end+fd642b0/10612130>
00000000 <_EIP>:
Code;  cff761e0 <_end+fd642b0/10612130>   <=====
   0:   c0 2b 4a                  shrb   $0x4a,(%ebx)   <=====
Code;  cff761e3 <_end+fd642b3/10612130>
   3:   c1 a0 b2 40 c1 60 61      shll   $0x61,0x60c140b2(%eax)
Code;  cff761ea <_end+fd642ba/10612130>
   a:   f7                        (bad)  
Code;  cff761eb <_end+fd642bb/10612130>
   b:   cf                        iret   
Code;  cff761ec <_end+fd642bc/10612130>
   c:   ec                        in     (%dx),%al
Code;  cff761ed <_end+fd642bd/10612130>
   d:   60                        pusha  
Code;  cff761ee <_end+fd642be/10612130>
   e:   f7                        (bad)  
Code;  cff761ef <_end+fd642bf/10612130>
   f:   cf                        iret   
Code;  cff761f0 <_end+fd642c0/10612130>
  10:   50                        push   %eax
Code;  cff761f1 <_end+fd642c1/10612130>
  11:   f6 f7                     div    %bh,%al
Code;  cff761f3 <_end+fd642c3/10612130>
  13:   cf                        iret   


	Arnaud.
