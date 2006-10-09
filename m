Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWJIUZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWJIUZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWJIUZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:25:00 -0400
Received: from gw.ptr-62-65-141-133.customer.ch.netstream.com ([62.65.141.133]:43532
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id S964812AbWJIUY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:24:59 -0400
Date: Mon, 9 Oct 2006 22:18:06 +0200
From: Nico Schottelius <nico-kernel20061009@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Net] Kernel renams eth0 -> eth7
Message-ID: <20061009201806.GA5723@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel20061009@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.18-1-486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am runnig 2.6.17.13 on a Geode, with 3 natsemi ports onboard
and 4 ports in a pci card (soekris net4801).

The strange thing is, that it currently renames eth0 to eth7
and eth1 to eth8 (or somehow different).

Have a look at [0] for dmesg output. You'll see this:

---------------------------------------------------------------------------=
-----
[   64.643627] natsemi eth0: NatSemi DP8381[56] at 0xa0000000
(0000:00:06.0), 00:00:24:c5:69:5c, IRQ 10, port TP.
[   64.676833] natsemi eth1: NatSemi DP8381[56] at 0xa0001000
(0000:00:07.0), 00:00:24:c5:69:5d, IRQ 10, port TP.
[   64.710006] natsemi eth2: NatSemi DP8381[56] at 0xa0002000
(0000:00:08.0), 00:00:24:c5:69:5e, IRQ 10, port TP.
[   64.743402] natsemi eth3: NatSemi DP8381[56] at 0xa4000000
(0000:01:00.0), 00:00:24:c4:fd:14, IRQ 5, port TP.
[   64.776463] natsemi eth4: NatSemi DP8381[56] at 0xa4001000
(0000:01:01.0), 00:00:24:c4:fd:15, IRQ 11, port TP.
[   64.809891] natsemi eth5: NatSemi DP8381[56] at 0xa4002000
(0000:01:02.0), 00:00:24:c4:fd:16, IRQ 5, port TP.
[   64.842982] natsemi eth6: NatSemi DP8381[56] at 0xa4003000
(0000:01:03.0), 00:00:24:c4:fd:17, IRQ 11, port TP.
---------------------------------------------------------------------------=
-----

which is correct. Later you see this:
---------------------------------------------------------------------------=
-----
[  122.142761] eth8: DSPCFG accepted after 0 usec.
[  122.156411] eth8: link up.
[  122.164584] eth8: Setting full-duplex based on negotiated link
capability.
[  122.719529] eth8: remaining active for wake-on-lan
[  122.927613] eth8: DSPCFG accepted after 0 usec.
[  122.941269] eth8: link up.
---------------------------------------------------------------------------=
-----
which feels really strange, because eth0 and eth1 simply
'disappeared'.

More information about the device can be found at [1]

My questions are:

   - why is it getting renamed and why did it not happen some boots
     (before I moved) before (like in [2])?
  =20
   - how can I tell the kernel NOT to rename it anymore / what
     must I fix?

Any hints appreciated.

Sincerly

Nico

[0]: http://unix.schottelius.org/zwerg/dmesg.renamed.eth0%2c1
[1]: http://unix.schottelius.org/zwerg/
[2]: http://unix.schottelius.org/zwerg/dmesg

--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFKq5+uL75KpiFGIwRAtg4AJ0aDnlbgFmVFCPLktMVKGO1O21PogCgz7yR
jAqOEH8TbrOjrA85zaLYL6Q=
=+LAi
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
