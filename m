Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266388AbUFQGco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266388AbUFQGco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 02:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUFQGco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 02:32:44 -0400
Received: from adsl-67-124-145-219.dsl.pltn13.pacbell.net ([67.124.145.219]:36771
	"EHLO mail.cryptobackpack.org") by vger.kernel.org with ESMTP
	id S266388AbUFQGcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 02:32:41 -0400
Date: Wed, 16 Jun 2004 23:06:05 -0700
From: David Bryson <david@tsumego.com>
To: linux-kernel@vger.kernel.org
Subject: sbp2/ieee1394 causes badness
Message-ID: <20040617060605.GA10937@heliosphan.in.cryptobackpack.org>
Reply-To: David Bryson <david@tsumego.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

ieee1394 + sbp2 has been irking me for a while, and I finally am
getting around to posting about it.

Using a fresh 2.6.7 on my powerbook G4 I plugged in my external
firewire drive(in a conversion kit) and insmod'd the sbp2 module(this
produced an error message like 'Trap set' or something I didn't write
it down).  The kernel spits out:

Jun 16 22:54:12 [kernel] ieee1394: got invalid ack 252 from node 65473
(tcode 4)
Jun 16 22:54:13 [kernel] ieee1394: Error parsing configrom for node
0-01:1023
Jun 16 22:54:14 [kernel] ieee1394: Error parsing configrom for node
0-00:1023
Jun 16 22:54:15 [kernel] ieee1394: Error parsing configrom for node
0-01:1023
Jun 16 22:54:15 [kernel] ieee1394: Node added: ID:BUS[0-00:1023]
GUID[0001a3080
000ee0b]
Jun 16 22:54:15 [kernel] ieee1394: Node changed: 0-00:1023 ->
0-01:1023
Jun 16 22:54:24 [kernel] sbp2: $Rev: 1219 $ Ben Collins
<bcollins@debian.org>

It doesn't init the scsi device /dev/sda nor does it let me remove the
module.  When I attempt to remove the module it says the module is in
use.  Finally I attempt to unplug the drive I had a hard system
hang(this is not suprising).

Any idea what's going on ? I could actually use it under 2.4, but 2.6
I haven't had any luck.
Dave

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0TTNLfsM4nS2FiARAhNCAJ4rRYsBSvx6G0nBQ2XCmuyrYga2LACeOxtm
7CtZF+A65vOS4XUalXzTb/s=
=e303
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
