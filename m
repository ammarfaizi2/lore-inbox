Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUDLKTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbUDLKTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:19:19 -0400
Received: from mh57.com ([217.160.185.21]:5578 "EHLO mithrin.mh57.de")
	by vger.kernel.org with ESMTP id S262860AbUDLKTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:19:15 -0400
Date: Mon, 12 Apr 2004 12:19:11 +0200
From: Martin Hermanowski <martin@mh57.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4 (hci_usb module unloading oops)
Message-ID: <20040412101911.GA3823@mh57.de>
References: <20040410200551.31866667.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20040410200551.31866667.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Broken-Reverse-DNS: no host name found for IP address 2001:8d8:81:4d0:8000::1
X-Spam-Score: 0.4 (/)
X-Authenticated-ID: martin
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I get an oops when I try to unload the hci_usb module.

What other useful information can I provide?

LLAP, Martin

Apr 12 12:07:48 localhost kernel: usbcore: deregistering driver hci_usb
Apr 12 12:07:48 localhost kernel: Unable to handle kernel NULL pointer dere=
ference at virtual address 00000000
Apr 12 12:07:48 localhost kernel:  printing eip:
Apr 12 12:07:48 localhost kernel: c01a05c6
Apr 12 12:07:48 localhost kernel: *pde =3D 00000000
Apr 12 12:07:48 localhost kernel: Oops: 0000 [#1]
Apr 12 12:07:48 localhost kernel: CPU:    0
Apr 12 12:07:48 localhost kernel: EIP:    0060:[get_kobj_path_length+38/64]=
    Ta inted: PF  VLI
Apr 12 12:07:48 localhost kernel: EFLAGS: 00010246   (2.6.5-mm4)=20
Apr 12 12:07:48 localhost kernel: EIP is at get_kobj_path_length+0x26/0x40
Apr 12 12:07:48 localhost kernel: eax: 00000000   ebx: 00000000   ecx: ffff=
ffff  edx: d0ffed38
Apr 12 12:07:48 localhost kernel: esi: 00000001   edi: 00000000   ebp: ffff=
ffff  esp: d7bd5e2c
Apr 12 12:07:48 localhost kernel: ds: 007b   es: 007b   ss: 0068
Apr 12 12:07:48 localhost kernel: Process rmmod (pid: 22209, threadinfo=3Dd=
7bd4000 task=3Dd6514cf0)
Apr 12 12:07:48 localhost kernel: Stack: c01e8670 c8cc6c19 c8cc6c00 c243f34=
0 c01a0779 c0379340 d0ffed38 000002a6=20
Apr 12 12:07:48 localhost kernel:        e09baec0 c015940d d7bd5e6c c8cc6c0=
0 00000000 c0341ae0 e09b5e17 00000000=20
Apr 12 12:07:48 localhost kernel:        c0309e3f d0ffed38 d0ffed30 e09bae6=
0 e09baec0 c01a0917 c0307b46 c0379340=20
Apr 12 12:07:48 localhost kernel: Call Trace:
Apr 12 12:07:48 localhost udev[22216]: removing device node '/dev/hci0'
Apr 12 12:07:48 localhost kernel:  [class_hotplug_name+0/16] class_hotplug_=
name+0x0/0x10
Apr 12 12:07:48 localhost kernel:  [kset_hotplug+313/624] kset_hotplug+0x13=
9/0x270
Apr 12 12:07:48 localhost kernel:  [lookup_hash+29/48] lookup_hash+0x1d/0x30
Apr 12 12:07:48 localhost kernel:  [kobject_hotplug+103/112] kobject_hotplu=
g+0x67/0x70
Apr 12 12:07:48 localhost kernel:  [kobject_del+27/64] kobject_del+0x1b/0x40
Apr 12 12:07:48 localhost kernel:  [class_device_del+144/192] class_device_=
del+0x90/0xc0
Apr 12 12:07:48 localhost kernel:  [__crc_crypto_hmac_final+1493997/5493628=
] hci_unregister_dev+0x13/0xa0 [bluetooth]
Apr 12 12:07:48 localhost kernel:  [__crc_crypto_hmac_final+2844063/5493628=
] hci_usb_disconnect+0x35/0x90 [hci_usb]
Apr 12 12:07:48 localhost kernel:  [usb_unbind_interface+118/128] usb_unbin=
d_interface+0x76/0x80
Apr 12 12:07:48 localhost kernel:  [device_release_driver+102/112] device_r=
elease_driver+0x66/0x70
Apr 12 12:07:48 localhost kernel:  [driver_detach+43/64] driver_detach+0x2b=
/0x40
Apr 12 12:07:48 localhost kernel:  [bus_remove_driver+61/128] bus_remove_dr=
iver+0x3d/0x80
Apr 12 12:07:48 localhost kernel:  [driver_unregister+19/40] driver_unregis=
ter+0x13/0x28
Apr 12 12:07:48 localhost kernel:  [usb_deregister+50/64] usb_deregister+0x=
32/0x40
Apr 12 12:07:48 localhost kernel:  [__crc_crypto_hmac_final+2844169/5493628=
] hci_usb_exit+0xf/0x11 [hci_usb]
Apr 12 12:07:48 localhost kernel:  [sys_delete_module+336/416] sys_delete_m=
odule+0x150/0x1a0
Apr 12 12:07:48 localhost kernel:  [do_munmap+286/352] do_munmap+0x11e/0x160
Apr 12 12:07:48 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 12 12:07:48 localhost kernel:=20
Apr 12 12:07:48 localhost kernel: Code: 90 8d 74 26 00 55 bd ff ff ff ff 57=
 56 be 01 00 00 00 53 8b 54 24 18 31 db 8d b6 00 00 00 00 8d bf 00 00 00 00=
 8b 3a 89 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 =
f0 5e 5f=20

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAem0fmGb6Npij0ewRAgASAKCZ0Eg9FB0MveutLOi3oE6yYHC/QgCePhNh
eNGuKToflISgMT1TOoUbM5I=
=yC8g
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
