Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbSJFUX3>; Sun, 6 Oct 2002 16:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262177AbSJFUX3>; Sun, 6 Oct 2002 16:23:29 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:49497 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S262172AbSJFUX2>;
	Sun, 6 Oct 2002 16:23:28 -0400
Date: Sun, 6 Oct 2002 22:28:59 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: scheduling while atomic! (bk-curr)
Message-ID: <20021006202858.GC2455@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Alopogies if this has been reported before but I get the
following booting a dual P100 on a preemp SMP BK-curr (2 hours
ago) kernel:

bad: scheduling while atomic!
Call Trace:
 [<c0118cee>] E schedule+0x3e/0x4a0
 [<c011b6a7>] E __might_sleep+0x57/0x1d8838
 [<c011958c>] E wait_for_completion+0x11c/0xffffff50
 [<c01191a0>] E default_wake_function+0x0/0x90
 [<c0117f28>] E global_flush_tlb+0x698/0x6190
 [<c01191a0>] E default_wake_function+0x0/0x90
 [<c011b031>] E GPLONLY_set_cpus_allowed+0x251/0x23e6a0
 [<c012f6b7>] E GPLONLY_queue_delayed_work+0x177/0x570
 [<c01191a0>] E default_wake_function+0x0/0x90
 [<c011820d>] E wake_up_process+0x2cd/0x1980
 [<c01191a0>] E default_wake_function+0x0/0x90
 [<c012f5e0>] E GPLONLY_queue_delayed_work+0xa0/0x570
 [<c0107169>] E enable_hlt+0x1f9/0x1e280

Regards,
  Rasmus

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9oJ0KlZJASZ6eJs4RAlw0AJ0YFRfnL1cm215hObJqf7nNQsw38QCfTvZV
0RoSSG2Rz2K8v9or5vcB34E=
=58PO
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
