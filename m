Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274975AbTHAWkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 18:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274976AbTHAWkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 18:40:31 -0400
Received: from pcp04570266pcs.jersyc01.nj.comcast.net ([68.39.15.57]:50955
	"EHLO pig.peterjohanson.com") by vger.kernel.org with ESMTP
	id S274975AbTHAWk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 18:40:27 -0400
Date: Fri, 1 Aug 2003 18:50:40 -0400
From: Peter Johanson <latexer@gentoo.org>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: rmmodding e100 trace calls on 2.6.0-test2-mm2
Message-ID: <20030801224932.GA4241@gonzo.peterjohanson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I get the following errors when rmmodding e100 and similar errors with
other net modules . The errors seem to come from the latest addition to=20
drivers/base/class.c. Please reply directly as i'm on linux-net and not
on linux-kernel. thanks.

-pete

kobject 'statistics' does not have a release() function, it is broken
and must be fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [<c0226001>] kobject_cleanup+0x5f/0x85
 [<c02f90a5>] netdev_unregister_sysfs+0x39/0x3b
 [<c02f8549>] netdev_run_todo+0x108/0x170
 [<f98f3538>] e100_remove1+0x27/0x7e [e100]
 [<c0232cc3>] pci_device_remove+0x3b/0x3d
 [<c0276ac7>] device_release_driver+0x62/0x64
 [<c0276ae9>] driver_detach+0x20/0x2e
 [<c0276d2c>] bus_remove_driver+0x3d/0x75
 [<c02770e8>] driver_unregister+0x13/0x28
 [<c0232f61>] pci_unregister_driver+0x16/0x26
 [<f98fb91f>] e100_cleanup_module+0x1b/0x4f [e100]
 [<c012fa94>] sys_delete_module+0x137/0x191
 [<c014687e>] do_munmap+0x147/0x183
 [<c0109097>] syscall_call+0x7/0xb
=20
Device class 'eth0' does not have a release() function,
it is broken and must be fixed.
Badness in class_dev_release at drivers/base/class.c:201
Call Trace:
 [<c0226025>] kobject_cleanup+0x83/0x85
 [<c02776e6>] class_device_unregister+0x13/0x23
 [<c02f8549>] netdev_run_todo+0x108/0x170
 [<f98f3538>] e100_remove1+0x27/0x7e [e100]
 [<c0232cc3>] pci_device_remove+0x3b/0x3d
 [<c0276ac7>] device_release_driver+0x62/0x64
 [<c0276ae9>] driver_detach+0x20/0x2e
 [<c0276d2c>] bus_remove_driver+0x3d/0x75
 [<c02770e8>] driver_unregister+0x13/0x28
 [<c0232f61>] pci_unregister_driver+0x16/0x26
 [<f98fb91f>] e100_cleanup_module+0x1b/0x4f [e100]
 [<c012fa94>] sys_delete_module+0x137/0x191
 [<c014687e>] do_munmap+0x147/0x183
 [<c0109097>] syscall_call+0x7/0xb

kobject 'class_obj' does not have a release() function, it is broken and
must be fixed.
Badness in kobject_cleanup at lib/kobject.c:402
Call Trace:
 [<c0226001>] kobject_cleanup+0x5f/0x85
 [<c02f8549>] netdev_run_todo+0x108/0x170
 [<f98f3538>] e100_remove1+0x27/0x7e [e100]
 [<c0232cc3>] pci_device_remove+0x3b/0x3d
 [<c0276ac7>] device_release_driver+0x62/0x64
 [<c0276ae9>] driver_detach+0x20/0x2e
 [<c0276d2c>] bus_remove_driver+0x3d/0x75
 [<c02770e8>] driver_unregister+0x13/0x28
 [<c0232f61>] pci_unregister_driver+0x16/0x26
 [<f98fb91f>] e100_cleanup_module+0x1b/0x4f [e100]
 [<c012fa94>] sys_delete_module+0x137/0x191
 [<c014687e>] do_munmap+0x147/0x183
 [<c0109097>] syscall_call+0x7/0xb
=20
--=20
Peter Johanson
<latexer@gentoo.org>

Key ID =3D 0x6EFA3917
Key fingerprint =3D A90A 2518 57B1 9D20 9B71  A2FF 8649 439B 6EFA 3917

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Ku7AhklDm276ORcRAjwXAKDYJx3F9yeUzLzVEwSPwbMR1dZCGACcD90b
nqsEjI/fqbmnN1NUbejBX7w=
=eoI4
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
