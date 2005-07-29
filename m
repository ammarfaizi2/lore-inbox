Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVG2DcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVG2DcB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 23:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVG2DcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 23:32:01 -0400
Received: from mx2.mail.ru ([194.67.23.122]:18468 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S262125AbVG2Dbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 23:31:55 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Syncing single filesystem (slow USB writing)
Date: Fri, 29 Jul 2005 07:31:20 +0400
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13697186.CQvKZ53aWo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507290731.32694.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13697186.CQvKZ53aWo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Mandrake always mounted USB sticks with sync option; it was effectively noo=
p=20
except for a patch that implemented limited dsync semantic.

Now, when full sync support for FATis in kernel, moutning with sync became=
=20
real pain. Writing speed dropped from 3MB/s to 30KB/s in my case (and I am=
=20
not alone).

One idea how to improve situation - continue to mount with dsync (having=20
basically old case) and do frequent sync of filesystem (this culd be starte=
d=20
as HAL callout or whatever). Unfortunately, I could not find a way to reque=
st=20
a sync (flush) of single mount point or block device. Have I missed=20
something?

TIA

=2Dandrey

--nextPart13697186.CQvKZ53aWo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC6aMTR6LMutpd94wRAkXJAJ9+C/iWQKwFLJpniSgUNQuPCdNIdQCcDS+t
7bfKCJVAO4J3JZOhMA00n4c=
=nkPh
-----END PGP SIGNATURE-----

--nextPart13697186.CQvKZ53aWo--
