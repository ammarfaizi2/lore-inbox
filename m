Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTH1OFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 10:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264031AbTH1OFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 10:05:54 -0400
Received: from [24.241.190.29] ([24.241.190.29]:21120 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S264027AbTH1OFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 10:05:51 -0400
Date: Thu, 28 Aug 2003 10:05:49 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.22-bk2 and 2.4.23-pre1 broke routing
Message-ID: <20030828140549.GA698@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I'm running 2.4.22 now and have a NAT behind my firewall as well as IPv6
happily run through unixcore.com.  I upgraded to 2.4.22-bk2 last night
to fix an odd problem where I can't ssh-6 to one host.  All of a sudden
it all works within the nat but nothing behind the firewall can get out
=66rom behind to the real work though the firewall still can.  Recompiled
trying 2.4.23-pre1 and I get the exact same behavior.  All 3 use the
same .config file.

The only noticable change I can see is a bunch of messages:

Aug 27 22:09:10 wally kernel: MASQUERADE: No route: Rusty's brain broke!
Aug 27 22:09:16 wally kernel: MASQUERADE: No route: Rusty's brain broke!
Aug 27 22:09:16 wally kernel: MASQUERADE: No route: Rusty's brain broke!


As soon as I reverted to 2.4.22 everything works great again.  Attaching
my .config.  Please contact me directly if you need any additional
testing done.

Dual AMD Athalon
512Megs of ram
00:0a.1 I2O: Distributed Processing Technology SmartRAID V Controller (rev =
02)
  (Adaptec I20 SCSI controller, no hardware or software raid in use though)
00:0c.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev =
02)
00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Tgw98+1vMONE2jsRAqUHAKDVh9yCugcqwpisvat55idP8UGtCQCg4QaF
dZFQWjNIe1hkmHor1gUwGAo=
=mphD
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
