Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317884AbSGVVIG>; Mon, 22 Jul 2002 17:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317882AbSGVVIG>; Mon, 22 Jul 2002 17:08:06 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:12594 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317879AbSGVVIE>; Mon, 22 Jul 2002 17:08:04 -0400
Date: Mon, 22 Jul 2002 23:11:10 +0200
From: Kurt Garloff <garloff@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Patch for 256 disks in 2.4
Message-ID: <20020722211110.GL19587@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020720195729.C20953@devserv.devel.redhat.com> <20020722170840.GB19587@nbkurt.etpnet.phys.tue.nl> <20020722164856.D19904@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline
In-Reply-To: <20020722164856.D19904@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pete,

On Mon, Jul 22, 2002 at 04:48:56PM -0400, Pete Zaitcev wrote:
> > From: Kurt Garloff <garloff@suse.de>
>=20
> > > For those who do not follow, John Cagle allocated 8 more SCSI
> > > disk majors.
> >=20
> > Have those officially been assigned to SCSI disks?
> > So disks 128 -- 255 have majors 128 thr. 135?
>=20
> I do not understand what your problem is. Do you refuse to recognise
> John as the LANANA chair or something?

Strange. I was just asking. Why would you think I would be silly and
refuse to recognize somebody?

> My patch is done in accordance with this:
> http://www.lanana.org/docs/device-list/devices.txt

OK, I should have checked there before asking here, probably.

> > SCSI disks connected. The patch does support up to 160 SD majors,=20
> > though currently, it won't succeed getting more than 132 majors.
>=20
> That's wonderful, but we cannot ship that. There is no userland
> support to create device nodes in dynamic fashion and to ensure
> that they do not conflict.

There will be.

> This is why Arjan filed for and received
> additional majors. Dynamic solutions need some time to float about
> the community, I think.

I don't object to having some more static ones. Fewer users will need
userspace tools for handling the dev nodes then ;-)
And of course, I'll adapt my patch to grab the assigned ones before
the unknown ones ...

> BTW, DASD does the same thing already. I never saw any memo or document
> explaining how to use this capability properly. Perhaps SuSE people
> support it. Kurt, can you tell anything about it?

I don't know much about DASD. They allocate block majors dynamically
starting from 255 backwards as far as I know. So, dev nodes need to
be created dynamically, I guess.

> > Do you have any idea why we can't just sync all mounted filesystems
> > in do_emergency_sync()?
> >  DASD? LVM? EVMS? MD? Loop? NBD? DRBD? What's the rationale=20
> > of restricting the sync to only IDE and SCSI? Deadlock avoidance?
>=20
> I suspect it is a deadlock prevention thing, too. I cannot say if
> it ever worked satisfactory... :)

Well, Alt-SysRq-S does work; but it obviously misses to sync a number
of filesystems.

> > I'm gonna post my patches tomorrow ...
>=20
> Thanks, that's interesting. Like I said, they are not likely to
> get to the distro soon, but I'd love to look at them.

Well, I would be astonished if you adopted before we do ;-)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PHTuxmLh6hyYd04RAoV1AJoD6Pi/2hMaKhYD0krC/x5uFWP+aQCdGMy8
76WZB8f1ylj0krKVEsZwt7Q=
=uC1f
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--
