Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312144AbSCRAGZ>; Sun, 17 Mar 2002 19:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312149AbSCRAGH>; Sun, 17 Mar 2002 19:06:07 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:62506 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S312144AbSCRAFp>; Sun, 17 Mar 2002 19:05:45 -0500
Date: Mon, 18 Mar 2002 01:05:38 +0100
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
        Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Subject: Re: SCSI-Problem with AM53C974
Message-ID: <20020318010538.B14900@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
In-Reply-To: <200203171439.g2HEdwX00738@orion.steiner.local> <20020317225838.GA11721@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20020317225838.GA11721@merlin.emma.line.org>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2002 at 11:58:38PM +0100, Matthias Andree wrote:
> On Sun, 17 Mar 2002, Marion Steiner wrote:
>=20
> > There is a problem with the AM53C974 Scsi-driver (Revision 0.5,=20
> > kernel 2.4.x) and the DawiControl DC-2974.
> >=20
> > Mar 17 14:13:01 orion kernel: scsi : aborting command due to timeout : =
pid
> > 123, scsi1, channel 0, id 0, lun 0 Inquiry 00 0
> > Mar 17 14:13:03 orion kernel: SCSI host 1 abort (pid 123) timed out -
> > resetting
> > Mar 17 14:13:03 orion kernel: SCSI bus is being reset for host 1 channe=
l 0.
>=20
> Command timeouts rather look like bus termination problem, plug loose or
> something like that. Does the problem still occur with all cables
> unplugged from the DC-2974? Does the problem occur with the DC-2974 in
> a different computer?

As far as I could see there were TWO driver loaded trying to drive the same
piece of hardware at the same time. You can really expect trouble if this
happens and you can't take any conclusions about hardware problems.

The problem is of course with the drivers: They should not allow to be
loaded both for the same device.
IMHO, The AM53C974 driver should register the ioports and fail
initialization if it can't grab them, so the conflict would be solved. I'll
investigate what the most proper solution to avoid such things is and come
up with a patch.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8lS9QxmLh6hyYd04RAueZAJ9JuQVpvPhyrAJOnYD25JwMY5KEQQCeK1hy
2D2K7lqFFxpMgH+Sduv99D0=
=8gKD
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
