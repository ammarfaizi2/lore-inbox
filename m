Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUACSf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUACSf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:35:28 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:15014 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263711AbUACSfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:35:04 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Sat, 3 Jan 2004 13:35:01 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1, scanner.ko, oops
Message-ID: <20040103183501.GA2906@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i tried my canoscan 670u scanner with 2.6.1-rc1's scanner module,
xsane 0.91, sane 1.0.13.  (also, i'm using ohci-hcd on a tyan
thunder s2462ung.)

i had some trouble with "funky results" when all my usb devices
were connected with a hub and all, but i'll continue to research
that myself.

with just the scanner and my apc ups plugged into separate
ports, the scanner worked nicely, but when i tried to rmmod
scanner, rmmod segfaulted and i got this error in dmesg:

drivers/usb/core/usb.c: deregistering driver usbscanner
ohci_hcd 0000:00:07.4: shutdown urb dd9d07c0 pipe 40008280 ep1in-intr
drivers/usb/core/file.c: removing 1 minor
drivers/usb/core/file.c: release_usb_class_dev - scanner1
usb 1-1: hcd_unlink_urb dd9d07c0 fail -22
Unable to handle kernel NULL pointer dereference at virtual address 0000001e
 printing eip:
e0d0d0cc
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<e0d0d0cc>]    Not tainted
EFLAGS: 00210246
EIP is at disconnect_scanner+0x2c/0x5d [scanner]
eax: ffffffff   ebx: dfd79bd4   ecx: e0d0d0a0   edx: 00000007
esi: 00000000   edi: dd9d086c   ebp: de6c7e5c   esp: de6c7e4c
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2989, threadinfo=3Dde6c6000 task=3Dc426ad20)
Stack: dfd79bc0 e0d11498 dfd79bc0 e0d11500 de6c7e78 e0c52167 dfd79bc0 dfd79=
bc0=20
       dfd79c00 dfd79bd4 e0d11520 de6c7e90 c0230ed0 dfd79bd4 dfd79c00 dd9d0=
884=20
       dd9d0840 de6c7eac e0d0c9f0 dfd79bd4 dfd79bc0 dd9d0884 e0d11430 00000=
000=20
Call Trace:
 [<e0c52167>] usb_unbind_interface+0x77/0x80 [usbcore]
 [<c0230ed0>] device_release_driver+0x60/0x70
 [<e0d0c9f0>] destroy_scanner+0x50/0xb0 [scanner]
 [<c01dd61d>] kobject_cleanup+0x8d/0x90
 [<e0c52167>] usb_unbind_interface+0x77/0x80 [usbcore]
 [<c0230ed0>] device_release_driver+0x60/0x70
 [<c0230f02>] driver_detach+0x22/0x40
 [<c023113a>] bus_remove_driver+0x3a/0x70
 [<c0231534>] driver_unregister+0x14/0x28
 [<e0c52242>] usb_deregister+0x32/0x40 [usbcore]
 [<e0d0d222>] usb_scanner_exit+0x12/0x14 [scanner]
 [<c013a797>] sys_delete_module+0x147/0x1a0
 [<c0153604>] sys_munmap+0x44/0x70
 [<c010950f>] syscall_call+0x7/0xb

Code: 80 7e 1e 00 75 1e 85 f6 74 12 8d 46 44 8b 5d f8 8b 75 fc 89=20
=20

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/9wtVCGPRljI8080RAkimAJ9nZMhekj64jKSWfrkiFw5LLMTz7QCcD6HB
LiOyL5k69syMo32fAEae8LA=
=iBab
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
