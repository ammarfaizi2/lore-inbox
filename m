Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUD1Tou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUD1Tou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUD1Tog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:44:36 -0400
Received: from dialin-212-144-167-044.arcor-ip.net ([212.144.167.44]:36483
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S265036AbUD1STn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:19:43 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <936D457C-9915-11D8-B40E-000A958E35DC@fhm.edu>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-27--376003280"
To: Linux Kernel <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: 2.4.26 crash in USB HID
Date: Wed, 28 Apr 2004 15:11:35 +0200
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-27--376003280
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hija,

trying to recover from a hanging usblp driver I rebooted
the machine and experienced an OOPS upon boot. This is not
reproducible so I cannot provide much further details.

System: Athlon XP-1700 with SiS 735 chipset
Kernel: 2.4.26 as provided by kernel-image-2.4.26-k7 in
         Debian unstable.

The keyboard is a Logitech Internet Navigator keyboard and
was connected at boottime. It normally works like a charm.

Unable to handle kernel paging request at virtual address 89d4ed13
e092f447
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e092f447>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: dd85c000   ebx: 00000000   ecx: 89d4ebff   edx: dd85c000
esi: dd85c000   edi: dd869e80   ebp: dd763000   esp: dd869db8
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 207, stackpage=dd869000)
Stack: dd763000 00000000 000086dd 000001f0 00000000 00000000 dd85c000 
dd869e80
        dd763000 e092fa75 dd85c000 00000000 00000000 dd869e52 dd85c000 
e092fdcb
        dd85c000 dd869e04 dd869e04 00000000 00080000 00000000 00000000 
00000000
Call Trace:    [<e092fa75>] [<e092fdcb>] [<e0930ce3>] [<e0930c17>] 
[<e0934240>]
   [<e09342a0>] [<e0930f9b>] [<c015403d>] [<e0934240>] [<e09342a0>] 
[<e091bdf6>]
   [<e0934240>] [<e0934280>] [<e092a040>] [<e091c26b>] [<e091e4ed>] 
[<e09200ae>]
   [<e091fc2c>] [<e0920443>] [<e09204d5>] [<c010726b>] [<e09204a0>]
Code: 8b 91 14 01 00 00 8b a8 cc 20 00 00 89 54 24 10 89 c2 8b 40


 >>EIP; e092f447 <[hid]hid_add_field+47/190>   <=====

 >>eax; dd85c000 <_end+1d55a660/2050b6e0>
 >>edx; dd85c000 <_end+1d55a660/2050b6e0>
 >>esi; dd85c000 <_end+1d55a660/2050b6e0>
 >>edi; dd869e80 <_end+1d5684e0/2050b6e0>
 >>ebp; dd763000 <_end+1d461660/2050b6e0>
 >>esp; dd869db8 <_end+1d568418/2050b6e0>

Trace; e092fa75 <[hid]hid_parser_main+95/e0>
Trace; e092fdcb <[hid]hid_parse_report+16b/1f0>
Trace; e0930ce3 <[hid]usb_hid_configure+163/400>
Trace; e0930c17 <[hid]usb_hid_configure+97/400>
Trace; e0934240 <[hid]hid_usb_ids+0/28>
Trace; e09342a0 <[hid]hid_driver+20/40>
Trace; e0930f9b <[hid]hid_probe+1b/180>
Trace; c015403d <get_new_inode+4d/110>
Trace; e0934240 <[hid]hid_usb_ids+0/28>
Trace; e09342a0 <[hid]hid_driver+20/40>
Trace; e091bdf6 <[usbcore]usb_find_interface_driver+116/210>
Trace; e0934240 <[hid]hid_usb_ids+0/28>
Trace; e0934280 <[hid]hid_driver+0/40>
Trace; e092a040 <[usbcore]usb_driver_list+0/0>
Trace; e091c26b <[usbcore]usb_find_drivers+8b/a0>
Trace; e091e4ed <[usbcore]usb_new_device+15d/1b0>
Trace; e09200ae <[usbcore]usb_hub_port_connect_change+15e/280>
Trace; e091fc2c <[usbcore]usb_hub_port_status+6c/a0>
Trace; e0920443 <[usbcore]usb_hub_events+273/2d0>
Trace; e09204d5 <[usbcore]usb_hub_thread+35/c0>
Trace; c010726b <arch_kernel_thread+2b/40>
Trace; e09204a0 <[usbcore]usb_hub_thread+0/c0>

Code;  e092f447 <[hid]hid_add_field+47/190>
00000000 <_EIP>:
Code;  e092f447 <[hid]hid_add_field+47/190>   <=====
    0:   8b 91 14 01 00 00         mov    0x114(%ecx),%edx   <=====
Code;  e092f44d <[hid]hid_add_field+4d/190>
    6:   8b a8 cc 20 00 00         mov    0x20cc(%eax),%ebp
Code;  e092f453 <[hid]hid_add_field+53/190>
    c:   89 54 24 10               mov    %edx,0x10(%esp,1)
Code;  e092f457 <[hid]hid_add_field+57/190>
   10:   89 c2                     mov    %eax,%edx
Code;  e092f459 <[hid]hid_add_field+59/190>
   12:   8b 40 00                  mov    0x0(%eax),%eax


Servus,
       Daniel

--Apple-Mail-27--376003280
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQI+thzBkNMiD99JrAQIWDQgAucP36FCKIPiuht/9ik2MmQl3QApl37nc
bqGXUyE/8qabEeK+6fKA+L/ui8XargrJ6tnIBRFei8rfszuRkkF33t7Z4GOVZFcg
gY1Py/AA0/+v54rJ9RMcA/K/BU6nj5/hRXIXqtRsdAfcE06A/FDKFWfjI7J2SLRB
B8laf9h/mqEQVNeyVYDAdb+v2x0mkos5ukcEDNI8/MhvRuBbSRTACxuD07qXfewr
OiOePMVbdvlmRAmk3y+B2QVpzUp5liG+LlzgXpHqhqtmcEU4dHIc2INDVlYzEU9n
VOlig07FX+kkKoO9mspZnKxdcPt6MF2HPZcmxzYTBVMPDCT5QH5nig==
=/ZOU
-----END PGP SIGNATURE-----

--Apple-Mail-27--376003280--

