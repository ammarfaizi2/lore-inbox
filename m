Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUDXShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUDXShW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUDXShV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:37:21 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:22664 "EHLO
	extern.mail.waldi.eu.org") by vger.kernel.org with ESMTP
	id S262503AbUDXShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:37:13 -0400
Date: Sat, 24 Apr 2004 20:37:11 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: page allocation failures with 2.6.5 on s390
Message-ID: <20040424183711.GC28032@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Today I see the following error message in the logs of two machines
with 2.6.5 on s390, both 31 and 64 bit.

| swapper: page allocation failure. order:2, mode:0x20
| 0072d8f0 00028b18 00405490 80028bbc 80028dac 0072d868 00392f00 0039068a
|        00000002 00000001 0039a400 0000001a
| Call Trace:
|  [<0000000000049d30>] __alloc_pages+0x318/0x35c
|  [<0000000000049dbe>] __get_free_pages+0x4a/0x78
|  [<000000000004d838>] cache_grow+0xe0/0x39c
|  [<000000000004dcc0>] cache_alloc_refill+0x1cc/0x2d8
|  [<000000000004e1f2>] __kmalloc+0xaa/0xb8
|  [<000000000023e810>] alloc_skb+0x5c/0xe4
|  [<00000000002080ca>] qeth_read_in_buffer+0xd16/0xda0
|  [<0000000000212e22>] qeth_qdio_input_handler+0x42a/0x57c
|  [<00000000001de17c>] qdio_handler+0xad4/0x10f4
|  [<00000000001d46da>] ccw_device_call_handler+0x8a/0x94
|  [<00000000001d3922>] ccw_device_irq+0x7a/0xb4
|  [<00000000001d42de>] io_subchannel_irq+0x7e/0xc4
|  [<00000000001cfcd2>] do_IRQ+0x18a/0x1b0
|  [<0000000000020072>] io_return+0x0/0x10

It causes a lot of state-D processes on one machine.

Is that problem known?

Bastian

--=20
There's another way to survive.  Mutual trust -- and help.
		-- Kirk, "Day of the Dove", stardate unknown

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iEYEARECAAYFAkCKs9cACgkQnw66O/MvCNFZlgCfYO/ndoop9or6u9Ths59K5w55
FAYAnirhoop2DsiqAeb9DAoI0lt9oyxd
=WdFh
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
