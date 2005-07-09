Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVGIUeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVGIUeH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 16:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGIUeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 16:34:07 -0400
Received: from [84.77.101.245] ([84.77.101.245]:11153 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S261722AbVGIUeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 16:34:06 -0400
Date: Sat, 9 Jul 2005 22:34:03 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [2.6.12-git8] ACPI shutdown fails to power off machine
Message-ID: <20050709203402.GA4621@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi:

I realized 2.6.13-rc2 would not power off my box anymore, although it
worked fine back in 2.6.12. A binary search of intermediate -git patches
showed that between -git7 and -git8 something broke power down. Every
kernel used has been compiled from sources downloaded from kernel.org, no
additional patches, and .config has been exactly the same.

Searching "gitweb" located at www.kernel.org (excelent tool, by the way;
you rock guys!) starting from "patch-2.6.12-git8.id" tag back in time, I
located a recent commited patch that, when reversed (against 2.6.12-git8)
makes power off work again in my box. Patch at:
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3Dcee5dab4856f51c5cad3aecc630ad0a4d2217a85

The commit text points to a bugme entry, that seems not to be applicable
to my situation: stock kernel sources from kernel.org. If you need some
more info (motherboard make and model, BIOS and version, output from
"lshw" or "dmidecode", etc.), please ask.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc2)


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC0DS6ao1/w/yPYI0RAsvVAKCMv0RUxFDG6T7kSzrZnFQJZkeT2wCaA3DL
CQtWhj3O2BhBo09PG0RMnOE=
=f2ea
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
