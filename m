Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTDYVlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTDYVla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:41:30 -0400
Received: from iucha.net ([209.98.146.184]:39504 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264521AbTDYVlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:41:25 -0400
Date: Fri, 25 Apr 2003 16:53:35 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: it87 driver converted to sysfs
Message-ID: <20030425215335.GN1069@iucha.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
References: <20030424150113.GJ1069@iucha.net> <20030424160431.GC18690@kroah.com> <20030424165132.GK1069@iucha.net> <20030424172758.GA27365@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline
In-Reply-To: <20030424172758.GA27365@kroah.com>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2003 at 10:27:58AM -0700, Greg KH wrote:
> Thanks, I've applied this and will send it on in a bit.
>=20
> Oops, I've fixed the call to check_region, which should not have been
> made.  Sorry I missed that last time.

I have booted 2.5.68-bk6 and upon modprobe it87 I get this:

i2c /dev entries driver module version 2.7.0 (20021208)
registering 0-0290
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
 printing eip:
c022ea13
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c022ea13>]    Not tainted
EFLAGS: 00010206
EIP is at kobject_get+0x13/0x50
eax: ef27e000   ebx: 0000005c   ecx: c03b1db0   edx: 00000296
esi: f0858388   edi: ef55ec00   ebp: ef55ec00   esp: ef27fea8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 69, threadinfo=3Def27e000 task=3Def6e2700)
Stack: ef55ec44 c022e71d 0000005c ef55ec18 c027f5a6 ef55ec44 ef55ec18 c027f=
703=20
       ef55ec18 ef55eca2 f08736df ef55ec18 ef55eca2 f0875127 00000000 00000=
290=20
       ef55ece0 f08821a3 ef55eca2 f0881573 ef55ec00 00000058 00000008 f0882=
1a3=20
Call Trace:
 [<c022e71d>] kobject_init+0x2d/0x50
 [<c027f5a6>] device_initialize+0x16/0x50
 [<c027f703>] device_register+0x13/0x30
 [<f08736df>] i2c_attach_client+0xff/0x150 [i2c_core]
 [<f0875127>] +0xb/0x24 [i2c_core]
 [<f08821a3>] +0x130/0x14d [it87]
 [<f0881573>] it87_detect+0x163/0x540 [it87]
 [<f08821a3>] +0x130/0x14d [it87]
 [<f0883a08>] forces+0x28/0x40 [it87]
 [<c0122046>] __check_region+0x46/0x50
 [<f0883a08>] forces+0x28/0x40 [it87]
 [<f085a34f>] +0x34f/0x4b0 [i2c_sensor]
 [<f0858360>] isa_adapter+0x0/0x1a0 [i2c_isa]
 [<f08776a4>] i2c_bus_type+0x44/0xe0 [i2c_core]
 [<f0877660>] i2c_bus_type+0x0/0xe0 [i2c_core]
 [<c02806a0>] bus_add_driver+0xd0/0xe0
 [<f0883be0>] it87_driver+0x0/0xa4 [it87]
 [<f08813ff>] it87_attach_adapter+0x1f/0x30 [it87]
 [<f0858360>] isa_adapter+0x0/0x1a0 [i2c_isa]
 [<f0883ba0>] addr_data+0x0/0x24 [it87]
 [<f0881410>] it87_detect+0x0/0x540 [it87]
 [<f0873374>] i2c_add_driver+0xc4/0xf0 [i2c_core]
 [<f0858360>] isa_adapter+0x0/0x1a0 [i2c_isa]
 [<f0883e80>] +0x0/0x140 [it87]
 [<f085200f>] +0xf/0x13 [it87]
 [<f0883be0>] it87_driver+0x0/0xa4 [it87]
 [<c01329ff>] sys_init_module+0x12f/0x1e0
 [<f0883e80>] +0x0/0x140 [it87]
 [<c010ab77>] syscall_call+0x7/0xb

Code: 8b 43 10 85 c0 7e 26 ff 43 10 b8 00 e0 ff ff 21 e0 ff 48 14=20
 <6>note: modprobe[69] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011a5b9>] schedule+0x399/0x3a0
 [<c01410f3>] unmap_page_range+0x43/0x70
 [<c01412e0>] unmap_vmas+0x1c0/0x220
 [<c01450cb>] exit_mmap+0x7b/0x190
 [<c011be84>] mmput+0x54/0xb0
 [<c011fb9d>] do_exit+0x10d/0x400
 [<c010bbb1>] die+0xe1/0xf0
 [<c0118caa>] do_page_fault+0x14a/0x457
 [<c010b4e4>] common_interrupt+0x18/0x20
 [<c0272860>] serial_in+0x20/0x40
 [<c022f8f2>] __delay+0x12/0x20
 [<c02751d5>] serial8250_console_write+0x155/0x240
 [<c011dfc4>] __call_console_drivers+0x54/0x60
 [<c0118b60>] do_page_fault+0x0/0x457
 [<c010b581>] error_code+0x2d/0x38
 [<f0858388>] isa_adapter+0x28/0x1a0 [i2c_isa]
 [<c022ea13>] kobject_get+0x13/0x50
 [<c022e71d>] kobject_init+0x2d/0x50
 [<c027f5a6>] device_initialize+0x16/0x50
 [<c027f703>] device_register+0x13/0x30
 [<f08736df>] i2c_attach_client+0xff/0x150 [i2c_core]
 [<f0875127>] +0xb/0x24 [i2c_core]
 [<f08821a3>] +0x130/0x14d [it87]
 [<f0881573>] it87_detect+0x163/0x540 [it87]
 [<f08821a3>] +0x130/0x14d [it87]
 [<f0883a08>] forces+0x28/0x40 [it87]
 [<c0122046>] __check_region+0x46/0x50
 [<f0883a08>] forces+0x28/0x40 [it87]
 [<f085a34f>] +0x34f/0x4b0 [i2c_sensor]
 [<f0858360>] isa_adapter+0x0/0x1a0 [i2c_isa]
 [<f08776a4>] i2c_bus_type+0x44/0xe0 [i2c_core]
 [<f0877660>] i2c_bus_type+0x0/0xe0 [i2c_core]
 [<c02806a0>] bus_add_driver+0xd0/0xe0
 [<f0883be0>] it87_driver+0x0/0xa4 [it87]
 [<f08813ff>] it87_attach_adapter+0x1f/0x30 [it87]
 [<f0858360>] isa_adapter+0x0/0x1a0 [i2c_isa]
 [<f0883ba0>] addr_data+0x0/0x24 [it87]
 [<f0881410>] it87_detect+0x0/0x540 [it87]
 [<f0873374>] i2c_add_driver+0xc4/0xf0 [i2c_core]
 [<f0858360>] isa_adapter+0x0/0x1a0 [i2c_isa]
 [<f0883e80>] +0x0/0x140 [it87]
 [<f085200f>] +0xf/0x13 [it87]
 [<f0883be0>] it87_driver+0x0/0xa4 [it87]
 [<c01329ff>] sys_init_module+0x12f/0x1e0
 [<f0883e80>] +0x0/0x140 [it87]
 [<c010ab77>] syscall_call+0x7/0xb

-bk3 with my version of it87 works fine.

Cheers,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--GPOl6LAGMgeiWDic
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qa5fNLPgdTuQ3+QRAvLYAJ96ZcM0fr27TmrJI8/c0Z0aZELwVwCfUaHq
sRTRKItt3fIqtqQT6Y3VlFE=
=x/OR
-----END PGP SIGNATURE-----

--GPOl6LAGMgeiWDic--
