Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271363AbTHDCvv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 22:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271364AbTHDCvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 22:51:51 -0400
Received: from adsl-67-121-153-186.dsl.pltn13.pacbell.net ([67.121.153.186]:18640
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S271363AbTHDCvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 22:51:49 -0400
Date: Sun, 3 Aug 2003 19:51:48 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Buffer I/O error using CD-ROM
Message-ID: <20030804025148.GA5952@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm getting some weird CD-ROM behavior in 2.6.0-test2-mm2. See below.
The call trace seems pretty much random though...

-Josh

hdc: cdrom_decode_status: error=3D0x30LastFailedSense 0x03=20
hdc: command error: status=3D0x51 { DriveReady SeekComplete Error }
hdc: command error: error=3D0x51
end_request: I/O error, dev hdc, sector 744144
Buffer I/O error on device hdc, logical block 186036
Call Trace:
 [<c01518a8>] buffer_io_error+0x42/0x4a
 [<c0151f67>] end_buffer_async_read+0xfe/0x10d
 [<c0154b1c>] end_bio_bh_io_sync+0x32/0x3e
 [<c0155b04>] bio_endio+0x53/0x78
 [<c021f14f>] __end_that_request_first+0x200/0x220
 [<c0230b27>] ide_end_request+0x73/0x14c
 [<c023edc2>] cdrom_end_request+0x99/0xad
 [<c023efd5>] cdrom_decode_status+0x1ff/0x348
 [<c010a99b>] handle_IRQ_event+0x3a/0x64
 [<c023f528>] cdrom_read_intr+0x4b/0x371
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01197ce>] recalc_task_prio+0x6c/0xf6
 [<c0119905>] try_to_wake_up+0xad/0x139
 [<c011a624>] default_wake_function+0x2a/0x2e
 [<c011a659>] __wake_up_common+0x31/0x50
 [<c027c4c4>] mousedev_event+0xd0/0x284
 [<c027ac9c>] input_event+0xf0/0x3bf
 [<c027dae4>] psmouse_process_packet+0x158/0x287
 [<c027dcec>] psmouse_interrupt+0xd9/0x1c4
 [<c0280923>] i8042_interrupt+0x210/0x215
 [<c027fff6>] serio_interrupt+0x5f/0x61
 [<c02807fe>] i8042_interrupt+0xeb/0x215
 [<c02c9344>] ip_local_deliver_finish+0x0/0x1d4
 [<c0125138>] update_process_times+0x46/0x52
 [<c01197ce>] recalc_task_prio+0x6c/0xf6
 [<c01197ce>] recalc_task_prio+0x6c/0xf6
 [<c0119905>] try_to_wake_up+0xad/0x139
 [<c02322e6>] ide_intr+0xee/0x194
 [<c023f4dd>] cdrom_read_intr+0x0/0x371
 [<c010a99b>] handle_IRQ_event+0x3a/0x64
 [<c010acd2>] do_IRQ+0x94/0x135
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c01212f4>] do_softirq+0x40/0x94
 [<c010ad40>] do_IRQ+0x102/0x135
 [<c010701e>] default_idle+0x0/0x26
 [<c01092d4>] common_interrupt+0x18/0x20
 [<c010701e>] default_idle+0x0/0x26
 [<c0107041>] default_idle+0x23/0x26
 [<c01070a2>] cpu_idle+0x2f/0x38
 [<c0105000>] rest_init+0x0/0x5d
 [<c03de69a>] start_kernel+0x14b/0x150
 [<c03de426>] unknown_bootoption+0x0/0xfd

hdc: cdrom_decode_status: status=3D0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=3D0x30LastFailedSense 0x03=20
hdc: cdrom_decode_status: status=3D0x51 { DriveReady SeekComplete Error }
hdc: cdrom_decode_status: error=3D0x30LastFailedSense 0x03=20

--=20
Joshua Kwan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LcpDT2bz5yevw+4RAugFAKC1NogsIT8fyIoqbbb+inM/nFEsFQCfYig+
GnMWvG4jnoPaAyAstXvbx4A=
=uOUC
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
