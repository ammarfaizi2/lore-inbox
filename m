Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUDEA5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUDEA5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 20:57:07 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:14223 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262271AbUDEA5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 20:57:01 -0400
Subject: [USB, 2.6.5] NULL pointer deref. at virt. address
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uDpZWonsCrYFiULsu52H"
Message-Id: <1081126615.31599.9.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 02:56:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uDpZWonsCrYFiULsu52H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, I haven't seen anything about this on LKML yet (via
marc.theaimsgroup.com) but it might have been reported.

This is on boot, prior to mounting root fs. EHCI usb is used,
reproducable on 2 types of hardware, mail me if you want more
information.

PS. CC since i'm not subbed.
DS.

usb 3-2.3: new full speed USB device using address 6
Unable to handle kernel NULL pointer dereference at virtual address
00000004
 printing eip:
c029ff5b
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c029ff5b>]    Not tainted
EFLAGS: 00010246   (2.6.5)
EIP is at usb_disable_interface+0xb/0x40
eax: f76f3400   ebx: 00000000   ecx: c1b70000   edx: f7bcf080
esi: 00000001   edi: 00000000   ebp: f76f3400   esp: c1b71d7c
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=3Dc1b70000 task=3Dc1a3e040)
Stack: f76f3400 00000001 00000002 f7780770 c02a0183 00000001 00000002
00000001
       00000000 00000000 00001388 00000000 f7bcf080 00000000 f7780680
f7780738
       f74a0ec0 c02d4e90 ddc5892a 0000000a 00000018 00000003 00000002
00000001
Call Trace:
 [<c02a0183>] usb_set_interface+0x93/0x150
 [<c02d4e90>] hci_usb_probe+0x210/0x450
 [<c029a933>] usb_probe_interface+0x53/0x70
 [<c0253102>] bus_match+0x32/0x60
 [<c025316a>] device_attach+0x3a/0x90
 [<c0185038>] sysfs_create_group+0x48/0x80
 [<c0253334>] bus_add_device+0x54/0x90
 [<c02523a4>] device_add+0x94/0x110
 [<c02a04de>] usb_set_configuration+0x1be/0x250
 [<c029b63e>] usb_new_device+0x22e/0x3a0
 [<c011ea1d>] printk+0x11d/0x170
 [<c029cde9>] hub_port_connect_change+0x159/0x250
 [<c029d169>] hub_events+0x289/0x300
 [<c029d20b>] hub_thread+0x2b/0xe0
 [<c011aec0>] default_wake_function+0x0/0x10
 [<c029d1e0>] hub_thread+0x0/0xe0
 [<c01052dd>] kernel_thread_helper+0x5/0x18
=20
Code: 80 7b 04 00 74 1d 31 f6 8b 43 0c 47 0f b6 54 30 02 83 c6 14

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-uDpZWonsCrYFiULsu52H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAcK7X7F3Euyc51N8RAmwyAKC/ofRaHOKExov8zhWXWMz/teGn2QCgjNhf
0B4UbEo/VCvRdd5BFz/Qmi0=
=oais
-----END PGP SIGNATURE-----

--=-uDpZWonsCrYFiULsu52H--

