Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314597AbSDTIoC>; Sat, 20 Apr 2002 04:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314598AbSDTIoB>; Sat, 20 Apr 2002 04:44:01 -0400
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:38765
	"EHLO darklands.localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314597AbSDTIoA>; Sat, 20 Apr 2002 04:44:00 -0400
Date: Sat, 20 Apr 2002 01:44:32 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
Message-ID: <20020420084432.GA5496@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020418110558.A16135@borg.org> <20020418082025.N2710@work.bitmover.com> <20020418172758.Q4498@marowsky-bree.de> <20020418125530.C16135@borg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux darklands 2.4.19-pre3-darklands 
X-Operating-Status: 19:51:52 up 3 days,  4:12,  1 user,  load average: 0.00, 0.08, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18-Apr 12:55, Kent Borg wrote:
[snip]
> I am envisioning a richer version of the file stage.  Just as users
> currently decide when to check in a version and when to checkpoint
> versions, I am imagining that sort of decision would still be made,
> but there would be a lower level of granularity that could be looked
> at if desired.  Big infrequent changes to a file would all be
> recorded, and frequent little changes would be subject to some
> heuristic.  It doesn't make sense to record a file's state so often
> that it isn't even self-consistent.  For example, recording all the
> changes over the course of the save of a big Star Office drawing would
> be silly, most would be intermediate and dependent on the changing
> epheneral internal state of Star Office.  I don't know the details of
> a reasonable heuristic other than obvious things such as when a file
> of flushed or closed or not touched for some significant time.

Why not commit versions on sync and close. That would seem to carry the lea=
st
surprise for the user. When I sync a filesystem/dir that would seem like a =
time
to make sure any changes make it to disk. And when a file is closed you don=
't
expect any more changes to that file.

>=20
> > That would actually be pretty interesting because it might also allow y=
ou to
> > back out editor screwup ;-)
>=20
> Writing an editor to take advantage of such underlying features would
> be pretty interesting too, it could be integrated into undo/redo
> features. =20
>=20
> Navigating such an historical fabric turns into a really interesting
> user interface problem.

Why teach current tools anything about it at all? Make this a tool you run =
on
the filesystem. If you _need_ to see earlier versions, it far past time to =
be
hoping emacs did the right thing.
=20
> > However, deducing change sets is more difficult.
>=20
> I think change sets for source code would still be based on versions
> declared by a human to be of some specific interest.  But changes sets
> for a computer's configuration might be implicit in the running of rpm
> or chkconfig, or reboots of the system, or saved edits to
> configuration files.  Etc.
>=20
> Certainly what I am envisioning would have immediate use in looking at
> changes to specific files, but would require more structure imposed to
> be useful a system configuration management tool or source code
> control system.
[snip MS vaperware envy]

Thomas

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8wSpwUHPW3p9PurIRAv/wAJ9R1RvhC1SSjR+LDRbCrOka73rS2ACfUA9a
fxoK+cZ1Vi37bJn+KJUxvpI=
=WNjP
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
