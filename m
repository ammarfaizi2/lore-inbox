Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUGFKt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUGFKt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 06:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGFKt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 06:49:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45751 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263770AbUGFKty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 06:49:54 -0400
Subject: Re: question about /proc/<PID>/mem in 2.4
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: FabF <fabian.frederick@skynet.be>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0407061210190.20027-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0407061210190.20027-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d6o8Irz68MLBJQ7C82ti"
Organization: Red Hat UK
Message-Id: <1089110989.2703.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 06 Jul 2004 12:49:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d6o8Irz68MLBJQ7C82ti
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 at 13:14, Tigran Aivazian wrote:
> On Mon, 5 Jul 2004, FabF wrote:
> > > Surely, the super user (i.e. CAP_SYS_PTRACE in this context) should b=
e=20
> > > allowed to read any process' memory without having to do the=20
> > > PTRACE_ATTACH/PTRACE_PEEKUSER kind of thing which strace(8) is doing?
> >=20
> > FYI may_ptrace_attach plugged somewhere between 2.4.21 & 22.This one ge=
t
> > used as is (ie without MAY_PTRACE) in proc_pid_environ but dunno about
> > reason why CAP_SYS_PTRACE isn't authoritative elsewhere.
>=20
> Ok, but still nobody seems to know why the super user is not allowed to
> access /proc/<PID>/mem of any task. Any code which nobody in the world
> knows the reason for, is broken and should be removed.
>=20
> I will wait a few weeks to see if someone does come up with the reason fo=
r
> that "extra secure" check in mem_read() and if nobody has objections I'll
> send Linus a patch to relax the check to a more reasonable one, namely to
> allow CAP_SYS_PTRACE process to bypass any other conditions imposed.

may I ask what the point is ?

--=-d6o8Irz68MLBJQ7C82ti
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6oPMxULwo51rQBIRAhAlAKChTB+vI/T8Jpp89OMPcjlut+RWYgCgh4DD
VktVoWrtHzkADLkZsnsuiR0=
=xg8X
-----END PGP SIGNATURE-----

--=-d6o8Irz68MLBJQ7C82ti--

