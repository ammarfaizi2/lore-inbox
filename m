Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbRG0Str>; Fri, 27 Jul 2001 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268889AbRG0Sth>; Fri, 27 Jul 2001 14:49:37 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:50954 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267878AbRG0StW>; Fri, 27 Jul 2001 14:49:22 -0400
Message-ID: <3B61B7AF.FC57C80D@delusion.de>
Date: Fri, 27 Jul 2001 20:49:19 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-ac1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.7-ac1 PNP Oops on shutdown
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi Alan,

2.4.7-ac1 oopses reproduceably during every shutdown. As far as I can tell,
2.4.6-ac5 didn't exhibit this behaviour.

Oops is attached.

Regards,
Udo.

ksymoops 2.4.1 on i686 2.4.7-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-ac1/ (default)
     -m /boot/System.map-2.4.7-ac1 (specified)
 
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0112b5d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0112b5d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: c0317670   ebx: 00000000   ecx: 00000246   edx: cff0ff94
esi: cff16000   edi: c0317674   ebp: cff17fc8   esp: cff17fb4
ds: 0018   es: 0018   ss: 0018
Process kpnpbios (pid: 2, stackpage=cff17000)
Stack: 00010f00 cff16000 ffffe000 00000001 00000286 00010f00 c011792d c01dde51
       c0317670 00000000 00010f00 c144bfc0 00000000 0008e000 cff16000 c01054c8
       00000000 00000078 c02b1fc0
Call Trace: [<c011792d>] [<c01dde51>] [<c01054c8>]
Code: 8b 03 0f 0d 00 eb 64 8b 4b fc 8b 01 a8 03 74 54 31 c0 9c 5e

>>EIP; c0112b5d <complete+1d/a0>   <=====
Trace; c011792d <complete_and_exit+d/20>
Trace; c01dde51 <pnp_dock_thread+d1/e0>
Trace; c01054c8 <kernel_thread+28/40>
Code;  c0112b5d <complete+1d/a0>
00000000 <_EIP>:
Code;  c0112b5d <complete+1d/a0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0112b5f <complete+1f/a0>
   2:   0f 0d 00                  prefetch (%eax)
Code;  c0112b62 <complete+22/a0>
   5:   eb 64                     jmp    6b <_EIP+0x6b> c0112bc8 <complete+88/a0>
Code;  c0112b64 <complete+24/a0>
   7:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c0112b67 <complete+27/a0>
   a:   8b 01                     mov    (%ecx),%eax
Code;  c0112b69 <complete+29/a0>
   c:   a8 03                     test   $0x3,%al
Code;  c0112b6b <complete+2b/a0>
   e:   74 54                     je     64 <_EIP+0x64> c0112bc1 <complete+81/a0>
Code;  c0112b6d <complete+2d/a0>
  10:   31 c0                     xor    %eax,%eax
Code;  c0112b6f <complete+2f/a0>
  12:   9c                        pushf
Code;  c0112b70 <complete+30/a0>
  13:   5e                        pop    %esi
