Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTFYOLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFYOLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:11:43 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:45552 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264346AbTFYOLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:11:41 -0400
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: grendel@debian.org
Cc: Steve Lord <lord@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030625134129.GG1745@thanes.org>
References: <20030625095126.GD1745@thanes.org>
	 <1056545505.1170.19.camel@laptop.americas.sgi.com>
	 <20030625134129.GG1745@thanes.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Qt++VcpmHx9oLrcw1C+N"
Organization: Red Hat, Inc.
Message-Id: <1056551143.5779.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 25 Jun 2003 16:25:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Qt++VcpmHx9oLrcw1C+N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-06-25 at 15:41, Marek Habersack wrote:
> On Wed, Jun 25, 2003 at 07:51:43AM -0500, Steve Lord scribbled:
> [snip]
> > >   For me both of the described situations seem to be a bug, but I mig=
ht be
> > > unaware of the rationale behind the functionality. If this is suppose=
d to be
> > > that way, maybe at least it would be better to default restrict_chown=
 to
> > > enabled initially? The behavior with restrict_chown is totally differ=
ent to
> > > what users/administrators are used to and, as shown in the debian pac=
kage
> > > build case, it might cause problems in usual situations. Also the quo=
ta
> > > issue is likely to be an excellent tool for local DoS.
> > >   So, am I wrong in thinking that it's a bug (or at least the quota p=
art of
> > > it) or not?
> >=20
> > Sorry about this, the defaults for the systunes have been messed up
> > recently. This is supposed to be on by default, irix_sgid_inherit
> > is on, but should be off by default.=20
> >=20
> > You can switch the behavior with /proc/sys/fs/xfs/restrict_chown
> > and irix_sgid_inherit.
> Yep, that's what I did. I was just caught by surprise discovering the new
> behavior :) and it if it was to be the default, it would have created a b=
ig
> problem for distributions compatibility-wise.
> =20
> > You can also edit xfs_globals.c to switch the default at boot time.
> > We will switch it back in the next update to Linus.
> Great, that's good enough.
> =20
> > As for the quota operation, the normal chown situation is going
> > from root to another id, and in that case, you want the quota to
> > go to the end user.=20

another question is why is this a filesystem specific option and not a
generic option ?

--=-Qt++VcpmHx9oLrcw1C+N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA++bDnxULwo51rQBIRAmrrAJ40s/+kZBLziZW7Q3Io7Oe+LenjtQCeIsBb
YKBz3mbyLkU6hjdu3jGTe58=
=2tfq
-----END PGP SIGNATURE-----

--=-Qt++VcpmHx9oLrcw1C+N--
