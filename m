Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRIRPux>; Tue, 18 Sep 2001 11:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272417AbRIRPue>; Tue, 18 Sep 2001 11:50:34 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:47299 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S272415AbRIRPu2>; Tue, 18 Sep 2001 11:50:28 -0400
Date: Tue, 18 Sep 2001 10:50:49 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Hubert Mantel <mantel@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010918105049.E31361@draal.physics.wisc.edu>
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com> <20010917223203.DACE3783EE@mail.clouddancer.com> <20010918174312.H6102@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010918174312.H6102@suse.de>; from mantel@suse.de on Tue, Sep 18, 2001 at 05:43:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hubert Mantel [mantel@suse.de] wrote:
> Hi,
>=20
> On Mon, Sep 17, Colonel wrote:
>=20
> > >$ cat /proc/partitions
>=20
> [...]
>=20
> > Works fine here:
>=20
> [...]
>=20
> > SCSI subsystem driver Revision: 1.00
> > sym53c8xx: at PCI bus 0, device 9, function 0
> > sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> > sym53c8xx: 53c875 detected with Symbios NVRAM
> > sym53c8xx: at PCI bus 0, device 9, function 1
> >=20
> >=20
> > Perhaps it is a driver effect?
>=20
> You only have one single SCSI adapter?
>=20
> I tried several things so far, and it seems you need the following to=20
> trigger the problem: You need at least two SCSI adapters that require=20
> different drivers (so two AHA2940s are not sufficient) and the drivers=20
> need to be loaded as modules.

I have a BusLogic BT-958 (compiled in), pas16 (module), and usb-storage
(module).

The problem shows up with only the BusLogic scsi device, and the other
modules not loaded.  (And it also shows up with 2 or more scsi drivers
loaded)  Note that on this machine the pas16 and usb-storage modules
*were* installed, I removed them, and /proc/partitions still looped.  (I
can't readily reboot ATM)

Hope this helps,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjunbVgACgkQjwioWRGe9K1rogCdGDnmCWG4gBABWCKlMU+fgEqG
iM4AoLGl2o5Wwk9nG2eIbwdXP5SbMju2
=Bfad
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
