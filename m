Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVBPEWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVBPEWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 23:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVBPEWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 23:22:10 -0500
Received: from h80ad26e2.async.vt.edu ([128.173.38.226]:16142 "EHLO
	h80ad26e2.async.vt.edu") by vger.kernel.org with ESMTP
	id S261983AbVBPEWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 23:22:06 -0500
Message-Id: <200502160421.j1G4Ls7l004329@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: rsbac@rsbac.org,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts on the "No Linux Security Modules framework" old claims 
In-Reply-To: Your message of "Tue, 15 Feb 2005 23:38:09 +0100."
             <1108507089.3826.83.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <1108507089.3826.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108527714_3565P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Feb 2005 23:21:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108527714_3565P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Feb 2005 23:38:09 +0100, Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= said:

> Yes, and that's noticed from the "official" documentation.
> But, who says that we can't place auditing facilities inside the
> existing hooks? or even file system linking related tweaks?

Many auditing policies require an audit event to be generated if the operation
is rejected by *either* the DAC (as implemented by the file permissions
and possibly ACLs) *or* the MAC (as implemented by the LSM exit).  However,
in most (all?) cases, the DAC check is made *first*, and the LSM exit isn't
even called if the DAC check fails.  As a result, if you try to open() a file
and get -EPERM due to the file permissions, the LSM exit isn't called and
you can't cut an audit record there.


--==_Exmh_1108527714_3565P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCEspicC3lWbTT17ARAueFAKCHP++mBaDFgbvUBbCQ/iAiTC0ekACgg5gf
ZqWgsrIj2GokGJeiKGeNmDU=
=OV+R
-----END PGP SIGNATURE-----

--==_Exmh_1108527714_3565P--
