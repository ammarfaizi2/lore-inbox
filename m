Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVBGVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVBGVpa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVBGVpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:45:30 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34820 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261338AbVBGVpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:45:21 -0500
Message-Id: <200502072145.j17LjFDr025558@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Filesystem linking protections 
In-Reply-To: Your message of "Mon, 07 Feb 2005 20:34:33 +0100."
             <1107804873.3754.232.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <1107802626.3754.224.camel@localhost.localdomain> <200502071914.j17JEbjQ018534@turing-police.cc.vt.edu>
            <1107804873.3754.232.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107812715_22594P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Feb 2005 16:45:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107812715_22594P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 20:34:33 +0100, Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= said:

> But It's better to give users a "secure-by-default" status, at least on
> those parts that don't affect negatively the stability or the
> performance itself.

It's still policy, and should be put someplace where users can manage it.
You're changing the behavior from what POSIX specifies, and that's in general
a no-no for mainline kernel code.

Like an LSM, which happens to be there so users can impose policy without
making any code changes to the kernel.  Implementing a policy that results in
non-POSIXy behavior in an LSM is perfectly OK.. ;)

> The LSM hook call is before the check, so, LSM framework still has the
> control over it, until it releases the operation giving control back to
> the standard function.

Right.. Which means LSM can stop that particular attack even faster than
your patch.. ;)

> If users must rely on LSM or other external solutions for applying basic
> security checks (as the framework itself only provides the way to apply
> them, the checks need to be implemented in a module), then we are making
> them unable to be protected using the "default" configuration.

You're making the very rash assumption that a hard-coded one-size-fits all
"default" that behaves differently than POSIX is suitable for all sites,
including sites that run software that gets broken by this change, and
things like embedded systems where it's not a concern at all, and sites that
already implement some *other* system to ensure that it's not an issue (for
instance, by using an SELinux policy...)

--==_Exmh_1107812715_22594P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCB+FrcC3lWbTT17ARAlb7AKDmaExL9/TbdkdE01qdM4p67vRG/ACg3xmB
q0GIpx0Ixc1pti2immLJTX4=
=DInf
-----END PGP SIGNATURE-----

--==_Exmh_1107812715_22594P--
