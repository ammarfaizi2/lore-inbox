Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTJXMCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 08:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTJXMC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 08:02:29 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:62412 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262158AbTJXMC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 08:02:28 -0400
Date: Fri, 24 Oct 2003 13:56:32 +0200
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net,
       dm-devel@sistina.com
Subject: device-mapper & bd_claim
Message-ID: <20031024115632.GX9850@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	evms-devel@lists.sourceforge.net, dm-devel@sistina.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NhNFzfCfperyfXiA"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NhNFzfCfperyfXiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

i use evms to mount some filesystems.
the root filesystem is located on /dev/hda1, all other partitions
are managed by evms.

this works without problems in 2.4.
however, evms refuses to create the logical volumes in 2.6.

the problem seems to be the addition of bd_claim in 2.6:
upon mounting the root filesystem, hda1 is claimed by the filesystem.
thus, hda is claimed by the bd_claim code, too.
evms tries to setup dm-tables using hda and fails to claim the device

so, how should this be solved?
i think it should be allowed to mix evms and 'normal' partitions on
the same device.

do we need to introduce claimed_region of the toplevel device instead
of claiming individual devices?

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--NhNFzfCfperyfXiA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/mRNvj/Eaxd/oD7IRAs/XAJ0akHjA7fGrAORt0SyzehS30WzChQCghKNc
LPyi0TwxMUOFGluY+/rFEsg=
=2+7b
-----END PGP SIGNATURE-----

--NhNFzfCfperyfXiA--
