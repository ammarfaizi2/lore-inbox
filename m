Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbRAQUQZ>; Wed, 17 Jan 2001 15:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130299AbRAQUQQ>; Wed, 17 Jan 2001 15:16:16 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:51979 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130107AbRAQUQI>; Wed, 17 Jan 2001 15:16:08 -0500
Message-ID: <3A65FD84.129CA315@Hell.WH8.TU-Dresden.De>
Date: Wed, 17 Jan 2001 21:16:04 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] with 2.2.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Below is a decoded oops from a standard 2.2.18 kernel.
If you need any additional info, please let me know.

Regards,
Udo.


ksymoops 2.3.5 on i686 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map-2.2.18 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000001
current->tss.cr3 = 051f3000, %cr3 = 051f3000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0130fc0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000001   ebx: c5ffe5c0   ecx: 00000000   edx: cb1bec60
esi: c01fde25   edi: c01fde28   ebp: 00000000   esp: c3037f4c
ds: 0018   es: 0018   ss: 0018
Process sslwrap (pid: 10350, process nr: 44, stackpage=c3037000)
Stack: ca85dd1c bffffc68 c5ffe620 c0131028 00000000 c01fde28 cb1beae0 00000003
       c01796d8 ca85dd1c 00000000 00000000 00000000 080ae3d6 c0179eb3 ca85dd1c
       00000000 ca85ddbc c017ab34 00000002 00000001 00000000 c3036000 00000002
Call Trace: [<c0131028>] [<c01fde28>] [<c01796d8>] [<c0179eb3>] [<c017ab34>] [<c01094bd>] [<c01093ac>]
Code: 89 00 44 8b 47 08 89 43 48 00 43 50 00 00 00 00 c7 00 5c 00

>>EIP; c0130fc0 <d_alloc+12c/150>   <=====
Trace; c0131028 <d_alloc_root+18/3c>
Trace; c01fde28 <cprt+168/b316>
Trace; c01796d8 <get_fd+54/d0>
Trace; c0179eb3 <sys_socket+33/78>
Trace; c017ab34 <sys_socketcall+64/1e0>
Trace; c01094bd <error_code+2d/34>
Trace; c01093ac <system_call+34/38>
Code;  c0130fc0 <d_alloc+12c/150>
00000000 <_EIP>:
Code;  c0130fc0 <d_alloc+12c/150>   <=====
   0:   89 00                     movl   %eax,(%eax)   <=====
Code;  c0130fc2 <d_alloc+12e/150>
   2:   44                        incl   %esp
Code;  c0130fc3 <d_alloc+12f/150>
   3:   8b 47 08                  movl   0x8(%edi),%eax
Code;  c0130fc6 <d_alloc+132/150>
   6:   89 43 48                  movl   %eax,0x48(%ebx)
Code;  c0130fc9 <d_alloc+135/150>
   9:   00 43 50                  addb   %al,0x50(%ebx)
Code;  c0130fcc <d_alloc+138/150>
   c:   00 00                     addb   %al,(%eax)
Code;  c0130fce <d_alloc+13a/150>
   e:   00 00                     addb   %al,(%eax)
Code;  c0130fd0 <d_alloc+13c/150>
  10:   c7 00 5c 00 00 00         movl   $0x5c,(%eax)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
