Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSFPVWn>; Sun, 16 Jun 2002 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSFPVWm>; Sun, 16 Jun 2002 17:22:42 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:21099 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316579AbSFPVWl>; Sun, 16 Jun 2002 17:22:41 -0400
Date: Sun, 16 Jun 2002 23:22:42 +0200
From: Kurt Garloff <garloff@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020616212241.GD21461@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <200206161924.g5GJOYN515160@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <200206161924.g5GJOYN515160@saturn.cs.uml.edu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Albert,

On Sun, Jun 16, 2002 at 03:24:33PM -0400, Albert D. Cahalan wrote:
> Kurt Garloff writes:
> > If we attach a third high-level device driver, two more columns
> > would show up. (Is this variable column number format a problem?)
>=20
> The variable column format is of course annoying, but use
> it if you must. The also-annoying alternative is to pick
> a fill character that would be easy for a beginner to
> handle in a script. Maybe one of:  @ - . / ?

Yes, as you correctly mention in your other mail, this would make it easier
to add more columns later.
But the problem then would be that we would need to fix (and limit) the
number of high-level devices that may be reported this way, which is not so
nice either. At this moment it's not a problem, of course, AFAIK.

> The header line is far worse. It's too terse to be very helpful.
> It gets in the way of every person writing a parser. Even in
> your example script, you had to hack your way around it:

I would not call it a hack. Ignoring comment lines is one of the basic
things each parser needs to do. Defining a format that does not allow
for comments actually would not be a very clever move.

But for a file exported from kernel, you may have a valid point.

Actually, the exact format of /proc/scsi/map is certainly something=20
that can be discussed separately from the basic idea of adding a file
that does expose the mapping of a SCSI address (CBTU) and the attached
high level drivers.=20
The way I designed it just should make it easy for a shell script to use
it. And keeping it simple certainly is a good thing.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DQGhxmLh6hyYd04RAlY1AJ49KZTTiwhLwD8az10MZl7XcQLleQCgv6gz
yFuuDmzQ39ZIs6HQU6LuSCE=
=zv2b
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
