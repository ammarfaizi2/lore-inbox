Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTKIAcP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTKIAcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:32:14 -0500
Received: from adsl-67-124-156-138.dsl.pltn13.pacbell.net ([67.124.156.138]:1504
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S261996AbTKIAcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:32:06 -0500
Date: Sat, 8 Nov 2003 16:32:05 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9 status report
Message-ID: <20031109003205.GC956@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031108191304.GB956@triplehelix.org> <20031109000326.GA1082@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20031109000326.GA1082@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 09, 2003 at 01:03:27AM +0100, Pavel Machek wrote:
> Try unloading agp/dri modules before you suspend. Then write
> suspend/resume support for them.

Sadly, both are built into the kernel for me :) And I am hardly a kernel
hacker much more than a tester.

However, a little OT, but I managed to pull this out of dmesg from when
my system was suspending:

bad: scheduling while atomic!
Call Trace:
 [<c011c9cf>] schedule+0x59c/0x5a1
 [<c02a8295>] pci_read+0x3d/0x41
 [<c0127dfb>] schedule_timeout+0x63/0xb7
 [<c0127d8f>] process_timeout+0x0/0x9
 [<c01bf062>] pci_set_power_state+0xd3/0x15e
 [<c0233377>] rtl8139_suspend+0x78/0xb1
 [<c01c12cb>] pci_device_suspend+0x2c/0x2e
 [<c021ebb3>] suspend_device+0x97/0xfd
 [<c021ec71>] device_suspend+0x58/0x7a
 [<c01370d1>] drivers_suspend+0xf/0x13
 [<c01375c7>] do_software_suspend+0x54/0x83
 [<c01d9ae6>] acpi_system_write_sleep+0xb3/0xcd
 [<c01d9a33>] acpi_system_write_sleep+0x0/0xcd
 [<c01547c4>] vfs_write+0xb0/0x119
 [<c01548d2>] sys_write+0x42/0x63
 [<c02fcf27>] syscall_call+0x7/0xb

Hope this helps.

--=20
Joshua Kwan

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP62LBKOILr94RG8mAQJMwxAA4Hu/NuL9us+J0oce+/ahDUAdEdxmN8/Y
uk4893XZXtxaCSgeqYgqS+I+QeMw6lVW7/0rcXTGA9ZEayNJrMp7bfaUycFmpAhu
vOAyKERjJULy54zdqqjRiGU71VPhT8YInbi7Jl+1k5zszgXG0xCgjLIGUd8RbEid
nx4jB5Jf9UkGl+m3okbOE3mGlrb15huiHg669jgeIZ5L0x4hrVe3LBoF9etAkGBb
uDBSm0u2kPRZUUGpNwaBJpM07mFRf6ILsmICgCFekpVUGgB/PHOtSiqYOKAtlXlh
KlDALox6I8s1XiKmNYSFRWYi9rD9WViSK6PULkqYDbCxJ+FbWLmLM+aBs2E2AUFm
d3mxRjsH2qrpEHeRJvUwoqeKYsMr6/XVfs4lZVmBNPb2wtk4h8nGN1EKs81mc4m2
Ng2qtoHqB3BIvYmy9kfcJdmTw3NYxQ5a5T0EhiQ17BZUTvKV7D7Hno3ErrTpZQHF
dwoHrYha+3oewPlW5CkF2UO+iJjKk6UByLKA9klYV1s8oDnWPKc7TT4D1f94SvUP
lsWY9PVyDBME6SKftwH2lOAHGbGEwzdk7n8HWiCkND7o8IC8sfwY5x6Xo9hj4CLl
ZwMY4lZZqFtQ8AOMU/8DdslmtBx2/92R9DV6I87A2ePeaEKkGlYynOw+OINna/uY
RbqGdROzUqo=
=61/C
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
