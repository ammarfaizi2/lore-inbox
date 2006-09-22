Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbWIVWxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbWIVWxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWIVWxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:53:03 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:5012 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S965253AbWIVWxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:53:01 -0400
X-Sasl-enc: 961jzqMg89ghRQrv5G/TzD1wYZ4IRgD4LafpmNWzhV+q 1158965581
Message-ID: <451469A8.1040504@imap.cc>
Date: Sat, 23 Sep 2006 00:54:32 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc7-mm1] ethernet configuration scripts of SuSE 10.0 broken
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5772E8E3D3901CDA6D7F5755"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5772E8E3D3901CDA6D7F5755
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

When booting kernel 2.6.18-rc7-mm1 on my SuSE Linux 10.0 system,
setup of the Ethernet interface fails. The startup screen displays:

Waiting for mandatory devices:  eth-id-00:b0:d0:ed:50:2a __NSC__
14 13 11 10 9 8 6 5 4 2 1 0
    eth-id-00:b0:d0:ed:50:2a            No interface found
failed

and there is no network connectivity. Running the command:

# rcnetwork start

displays:

    eth0      No configuration found for eth0

and doesn't bring up the interface either. Explicitly specifying
the configuration with:

# ifup eth-id-00:b0:d0:ed:50:2a eth0

however brings up the interface successfully. So it seems that
it's just SuSE's convoluted tangle of network startup scripts
which is somehow confused by some subtle change in how Ethernet
interfaces present themselves to userspace in this mm release.

Neither kernel 2.6.18 (release) nor 2.6.18-rc6-mm2 exhibit that
problem.

Hardware: Dell OptiPlex GX110, Intel Pentium III, 933 MHz, 512 MB RAM,
i810 chipset, Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Torna=
do] (rev 78)
Software: SuSE Linux 10.0 Professional with current patches plus
self-compiled kernel 2.6.18-rc7-mm1

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig5772E8E3D3901CDA6D7F5755
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFFGmwMdB4Whm86/kRAu2vAJ9RcSTFNy2BO9QxI2NYV6TIAmhOvQCdHczm
cLn9GZJ3sUPK0qhRPYfxNJY=
=oxBG
-----END PGP SIGNATURE-----

--------------enig5772E8E3D3901CDA6D7F5755--
