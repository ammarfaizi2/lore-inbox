Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289481AbSAJPLH>; Thu, 10 Jan 2002 10:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289488AbSAJPK5>; Thu, 10 Jan 2002 10:10:57 -0500
Received: from [62.98.202.87] ([62.98.202.87]:260 "EHLO
	gandalf.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S289481AbSAJPKv>; Thu, 10 Jan 2002 10:10:51 -0500
Date: Thu, 10 Jan 2002 16:05:58 +0100
From: Cristiano Paris <c.paris@libero.it>
To: linux-kernel@vger.kernel.org
Subject: USB Mouse OOPS in 2.4.17
Message-ID: <20020110160558.A7899@gandalf.rhpk.springfield.inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the oops as a result from ksymoops :

Unable to handle kernel paging request at virtual address 74203d20
d08a4ce3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d08a4ce3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a83
eax: 74203d04   ebx: 00000000   ecx: cfae115c   edx: 0000070a
esi: 74203d20   edi: cfa7cc80   ebp: cfae1170   esp: cfb0df04
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 53, stackpage=cfb0d000)
Stack: 00000246 cfa7cc88 cfa7cc80 c1421560 6572206f d08a4e1d c1421560 cfa7cc80 
       cfa7c000 cfcd9a80 d08af39c 00000000 c02b8145 cfae115c d089607e cfa7cc80 
       d08acbe1 cfa7cc80 d08af380 d0896d9f cfcc2c00 cfa7c000 00000000 00000100 
Call Trace: [<d08a4e1d>] [<d08af39c>] [<d089607e>] [<d08acbe1>] [<d08af380>] 
   [<d0896d9f>] [<d0898e40>] [<d0899237>] [<d08a082c>] [<d08993f6>] [<c0105478>]
 
Code: 8b 36 8b 50 04 89 d3 81 e3 00 00 80 00 75 e4 8b 40 08 42 81 
Error (Oops_bfd_perror): set_section_contents Bad value

>>EIP; d08a4ce2 <[uhci]uhci_unlink_generic+36/dc>   <=====
Trace; d08a4e1c <[uhci]uhci_unlink_urb+94/164>
Trace; d08af39c <[hid]hid_driver+1c/40>
Trace; d089607e <[usbcore]usb_unlink_urb+26/30>
Trace; d08acbe0 <[hid]hid_disconnect+10/44>
Trace; d08af380 <[hid]hid_driver+0/40>
Trace; d0896d9e <[usbcore]usb_disconnect+76/114>
Trace; d0898e40 <[usbcore]usb_hub_port_connect_change+50/328>
Trace; d0899236 <[usbcore]usb_hub_events+11e/2b8>
Trace; d08a082c <[usbcore]khubd_wait+4/c>
Trace; d08993f6 <[usbcore]usb_hub_thread+26/44>
Trace; c0105478 <kernel_thread+28/38>

I was doing nothing special. I was under X and suddenly the mouse freezed.

Hope this helps.

Cristiano

----
GnuPG Public Key Fingerprint (certserver.pgp.com)
pub  1024D/BF762716 2002-01-08 Cristiano Paris (privata) <c.paris@libero.it>
     Key fingerprint = 91BA C55F 4B75 730D 5FB3  16AB 4202 9ACA BF76 2716
