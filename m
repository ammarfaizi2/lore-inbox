Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWHVDTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWHVDTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 23:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWHVDTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 23:19:14 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:32177 "EHLO
	haldeman.int.wirex.com") by vger.kernel.org with ESMTP
	id S932080AbWHVDTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 23:19:13 -0400
Date: Mon, 21 Aug 2006 20:19:12 -0700
From: Seth Arnold <seth.arnold@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Crispin Cowan <crispin@novell.com>, Stephen Smalley <sds@tycho.nsa.gov>,
       "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060822031911.GZ2584@suse.de>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	Crispin Cowan <crispin@novell.com>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nicholas Miell <nmiell@comcast.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-security-module@vger.kernel.org, chrisw@sous-sol.org
References: <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil> <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil> <44E6714C.3090707@novell.com> <20060822025036.GA31422@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MgsldsnE3DYXgZCe"
Content-Disposition: inline
In-Reply-To: <20060822025036.GA31422@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MgsldsnE3DYXgZCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2006 at 09:50:36PM -0500, Serge E. Hallyn wrote:
> > To quickly summarize the AppArmor model, you have an external policy
>=20
> Does this stack with the capability module, or do you use purely your
> own logic?

We link against the commoncap facility introduced by Bert Hubert, to
provide 'standard' capabilities support; we simply add another check at
capable() time to _also_ check the capability against the list allowed
in the current profile.

> But, the fs caps aren't intended to be an alternative to a policy-basd
> system.  What I like about them is simply that instead of making a
> binary setuid 0, and expecting it to give up the caps it doesn't need,
> it can be given just the caps it needs right off the bat.
>=20
> The apparmor and selinux policies would be complementary and useful as
> ever on top of those, just as they currently are on top of setuid.

Seems like a great idea for e.g. binding to low ports, chroot, and
changing users for e.g. password changing. The other 24-26 capabilities
may be less useful. :) Still, I agree, complementary, and hopefully a
mechanism such as this proposed mechanism would help drag capabilities
out of the dark ages.

Thanks Serge

--MgsldsnE3DYXgZCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFE6nev+9nuM9mwoJkRAlCOAJ9HbPDhN8c6uZimgPJq7xx8JTcjvwCgkSwu
yhGeHttFflf0pOuHyMt0vAE=
=JWU5
-----END PGP SIGNATURE-----

--MgsldsnE3DYXgZCe--
