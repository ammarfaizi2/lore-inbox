Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVBGWNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVBGWNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVBGWNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:13:41 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45577 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261202AbVBGWNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:13:39 -0500
Message-Id: <200502072213.j17MDT3j026555@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Filesystem linking protections 
In-Reply-To: Your message of "Mon, 07 Feb 2005 23:00:33 +0100."
             <1107813633.3754.245.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <1107802626.3754.224.camel@localhost.localdomain> <200502071914.j17JEbjQ018534@turing-police.cc.vt.edu> <1107804873.3754.232.camel@localhost.localdomain> <200502072145.j17LjFDr025558@turing-police.cc.vt.edu>
            <1107813633.3754.245.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107814409_22594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 17:13:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107814409_22594P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 23:00:33 +0100, Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= said:

> A sysctl can be a good option, creating a CTL_SECURITY and then
> registering stuff under it, but this requires to have the kernel hackers
> agree with implementing a new security suite and such.
> In short, re-inventing the wheel.

No, you can do this from within an LSM and the kernel hackers don't have to deal
with it....

(tech note - don't call register_sysctl_table() from within a security_initcall().
Use a separate __initcall() that gets called later - security_initcall() happens
before the kernel has the sysctl infrastructure in place.  Guess how I know that? ;)

--==_Exmh_1107814409_22594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCB+gJcC3lWbTT17ARAhqpAJ9mJG7u3qpWkVPcZXYgGguCJM8SDACcC+uy
Q4pVIxeeF1vrsH+F3wjioUI=
=5F6E
-----END PGP SIGNATURE-----

--==_Exmh_1107814409_22594P--
