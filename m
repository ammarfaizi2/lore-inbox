Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268170AbUJVWti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268170AbUJVWti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJVWsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:48:20 -0400
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:46307 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S268265AbUJVWqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:46:37 -0400
From: Alastair Stevens <alastair@altruxsolutions.co.uk>
Organization: Haverhill UK
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-ck1: swap mayhem under UT2004
Date: Fri, 22 Oct 2004 23:46:28 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1733742.qEE2jiTl4Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410222346.32823.alastair@altruxsolutions.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1733742.qEE2jiTl4Z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Con and others: I've been running 2.6.9-ck1 for a couple of days, and seem=
=20
to have hit on a major swapping issue....

My machine is a UP Athlon 2500+ with 512MB, and everything hums along=20
nicely under normal desktop usage.  But when launching UT2004, it just=20
crawls and jerks like hell.  At one point, it appeared to have frozen=20
completely, but I managed to switch to a text console to see what was=20
happening, and basically I'd hit a swap frenzy: kswapd was sucking 50% of=20
the CPU, fighting with the UT2004 process.

My RAM appeared to be almost "full", with no cache/buffers, but only a few=
=20
hundred K of swap was actually being used, and this wasn't changing.  =20
The kswapd frenzy carried on for at least a couple of minutes; then=20
suddenly everything went smooth again and the game played perfectly from=20
then on.

This is definitely new behaviour; I've run every recent 2.6 kernel, with=20
and without the staircase scheduler patch (but not the full -ck), and=20
never had any problems before.  Yes, I'm running the dratted Nvidia=20
driver, but that's not the issue as it's been loaded with every other=20
kernel.  Switching back to 2.6.9-rc3 makes everything behave perfectly=20
again....

Any ideas?  Any more info required?
Cheers
Alastair

=2D-=20
                                        o
Alastair Stevens : child of 1976       /-'_              LPI (Level 1)
  www.altruxsolutions.co.uk           |\/(*)   /\__     Linux Certified
_________________________________ . .(*) _____/    \___________________
        Ditch IE and ignite a new web - www.getfirefox.com

--nextPart1733742.qEE2jiTl4Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBeY3IZaIQ8KuIK+0RAqK2AJoC33morX0DNehqZUpuBz8+OVIMggCfWE+K
bfPvBZ4z/h3lGk3y9JPOczI=
=zSlH
-----END PGP SIGNATURE-----

--nextPart1733742.qEE2jiTl4Z--
