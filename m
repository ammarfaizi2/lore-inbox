Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbULCBrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbULCBrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULCBrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:47:43 -0500
Received: from 212.199.9.99.forward.012.net.il ([212.199.9.99]:41634 "EHLO
	stoneshaft.ath.cx") by vger.kernel.org with ESMTP id S261838AbULCBre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:47:34 -0500
From: Eldad Zack <eldad@stoneshaft.ath.cx>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: kernel boot hang, SATA_VIA compiled without APIC_IO
Date: Fri, 3 Dec 2004 03:45:42 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200412030345.45282.eldad@stoneshaft.ath.cx>
Content-Type: multipart/signed;
  boundary="nextPart1232455.TYaQ19hRxX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1232455.TYaQ19hRxX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I've recently got a SATA capable machine (Via chipset) and I've exprienced =
a=20
nasty hang at boottime, using kernel 2.6.9.
After some recompiling different parameters it boiled down to APIC_IO being=
=20
not selected (this is a UP machine).

Without APIC_IO selected the system would hang while loading SATA.

I've only tried 2.6.5 to notice it would not hang but would emit messeges a=
s=20
"hde: lost interrupt", and eventually go on with the boot, the sata being=20
unusable.

Out of curiousity, I'd like to know if APIC_IO is absolutly needed when=20
dealing with SATA, and also, I'd like to help debug this problem so that a=
=20
kernel compiled without APIC_IO would at the very least not hang...


=2D-=20
Eldad Zack <eldad@stoneshaft.ath.cx>
Key/Fingerprint at pgp.mit.edu, ID 0x96EA0A93

--nextPart1232455.TYaQ19hRxX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBr8VJT+MN7JbqCpMRAsOJAJwPoglNolmGXWavlVgLKUFMtYNk3ACeI8j/
rMR4m0XN7D47ySbsjzK0QoA=
=Y35M
-----END PGP SIGNATURE-----

--nextPart1232455.TYaQ19hRxX--
