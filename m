Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUBDEY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbUBDEY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:24:56 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:50568 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266295AbUBDEYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:24:51 -0500
Subject: Re: [ANNOUNCE] udev 016 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203231341.GA22058@kroah.com>
References: <20040203201359.GB19476@kroah.com>
	 <1075843712.7473.60.camel@nosferatu.lan>
	 <1075849413.11322.6.camel@nosferatu.lan> <20040203231341.GA22058@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ylo1u8P61ovCRKgA9XZE"
Message-Id: <1075868708.11322.23.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 06:25:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ylo1u8P61ovCRKgA9XZE
Content-Type: multipart/mixed; boundary="=-8Y/K8lPxQwEN92vou4KR"


--=-8Y/K8lPxQwEN92vou4KR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-04 at 01:13, Greg KH wrote:
> On Wed, Feb 04, 2004 at 01:03:33AM +0200, Martin Schlemmer wrote:
> > On Tue, 2004-02-03 at 23:28, Martin Schlemmer wrote:
> > > On Tue, 2004-02-03 at 22:13, Greg KH wrote:
> > >=20
> > > Except if I miss something major, udevsend and udevd still do not
> > > work:
> > >=20
> >=20
> > Skip that, it does work if SEQNUM is set :P
> >=20
> > Anyhow, is it _really_ needed for SEQNUM to be set?  What about
> > the attached patch?
>=20
> Yes it is necessary, as that is what the kernel spits out.  It's also
> the whole reason we need udevd :)
>=20
> If you don't want to give a SEQNUM, just call udev directly.
>=20

Ok, was just thinking it could lead to confusion with debug usually not
compiled in.  Maybe a more visible error (as we then know it was outside
the kernel)?

> > Then, order I have not really checked yet, but there are two things
> > that bother me:
> >=20
> > 1) latency is even higher than before (btw Greg, is there going to be
> > more sysfs/whatever fixes to get udev even faster, or is this the
> > limit?)
>=20
> Care to measure the latency somehow?  The first event is a bit slow, but
> everything after that is as fast as I ever remember it being.
>=20

Hmm, Ok, it seems it is much better on batch jobs (or if udevd is
running) then from clean start, sorry.

> > 2) events gets missing.  If you for example use udevsend in the
> > initscript that populate /dev (/udev), the amount of nodes/links
> > created is off with about 10-50 (once about 250) entries.
>=20
> Hm, that's not good.  I'll go test that and see what's happening.
>=20

Script is attached.  If I was being silly here, let me know.  Some
quick testing again, it seems like the missing events is more with
the echo not commented, but could be just some fluke (there was
still however more than 5 usually missing).


Thanks,

--=20
Martin Schlemmer

--=-8Y/K8lPxQwEN92vou4KR
Content-Disposition: attachment; filename=foo.sh
Content-Type: text/x-sh; name=foo.sh; charset=UTF-8
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gNCg0KU0VRTlVNPTANCg0KY2FsbF91ZGV2KCkgew0KCWV4cG9ydCBTRVFOVU09
JCgoU0VRTlVNICsgMSkpDQoJI2VjaG8gIkRFVlBBVEg9JERFVlBBVEgsIENMQVNTPSQxLCBTRVFO
VU09JFNFUU5VTSINCgkvc2Jpbi91ZGV2c2VuZCAkMQ0KfQ0KDQpwb3B1bGF0ZV91ZGV2KCkgew0K
ICAgIGxvY2FsIHg9DQogICAgbG9jYWwgeT0NCiAgICBsb2NhbCBDTEFTUz0NCg0KICAgICMgUHJv
cG9nYXRlIC9kZXYgZnJvbSAvc3lzIC0gd2Ugb25seSBuZWVkIHRoaXMgd2hpbGUgd2UgZG8gbm90
DQogICAgIyBoYXZlIGluaXRyYW1mcyBhbmQgYW4gZWFybHkgdXNlci1zcGFjZSB3aXRoIHdoaWNo
IHRvIGRvIGVhcmx5DQogICAgIyBkZXZpY2UgYnJpbmcgdXANCiAgICBleHBvcnQgQUNUSU9OPWFk
ZA0KDQogICAgIyBBZGQgYmxvY2sgZGV2aWNlcyBhbmQgdGhlaXIgcGFydGl0aW9ucw0KICAgIGZv
ciB4IGluIC9zeXMvYmxvY2svKg0KICAgIGRvDQogICAgICAgICMgQWRkIGVhY2ggZHJpdmUNCiAg
ICAgICAgZXhwb3J0IERFVlBBVEg9IiR7eCMvc3lzfSINCiAgICAgICAgY2FsbF91ZGV2IGJsb2Nr
DQoNCiAgICAgICAgIyBBZGQgZWFjaCBwYXJ0aXRpb24sIG9uIGVhY2ggZGV2aWNlDQogICAgICAg
IGZvciB5IGluICR7eH0vKg0KICAgICAgICBkbw0KICAgICAgICAgICAgaWYgWyAtZiAiJHt5fS9k
ZXYiIF0NCiAgICAgICAgICAgIHRoZW4NCiAgICAgICAgICAgICAgICBleHBvcnQgREVWUEFUSD0i
JHt5Iy9zeXN9Ig0KICAgICAgICAgICAgICAgIGNhbGxfdWRldiBibG9jaw0KICAgICAgICAgICAg
ZmkNCiAgICAgICAgZG9uZQ0KICAgIGRvbmUNCg0KICAgICMgQWxsIG90aGVyIGRldmljZSBjbGFz
c2VzDQogICAgZm9yIHggaW4gL3N5cy9jbGFzcy8qDQogICAgZG8NCiAgICAgICAgZm9yIHkgaW4g
JHt4fS8qDQogICAgICAgIGRvDQogICAgICAgICAgICBpZiBbIC1mICIke3l9L2RldiIgXQ0KICAg
ICAgICAgICAgdGhlbg0KICAgICAgICAgICAgICAgIENMQVNTPSIkKGVjaG8gIiR7eCMvc3lzfSIg
fCBjdXQgLS1kZWxpbWl0ZXI9Jy8nIC0tZmllbGRzPTMtKSINCiAgICAgICAgICAgICAgICBleHBv
cnQgREVWUEFUSD0iJHt5Iy9zeXN9Ig0KICAgICAgICAgICAgICAgIGNhbGxfdWRldiAke0NMQVNT
fQ0KICAgICAgICAgICAgZmkNCiAgICAgICAgZG9uZQ0KICAgIGRvbmUNCg0KICAgIHVuc2V0IEFD
VElPTiBERVZQQVRIDQoNCiAgICByZXR1cm4gMA0KfQ0KDQpwb3B1bGF0ZV91ZGV2DQoNCg==

--=-8Y/K8lPxQwEN92vou4KR--

--=-ylo1u8P61ovCRKgA9XZE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAIHQkqburzKaJYLYRAo8YAKCIoEWs7le6SXLOO7ma48yaxjPbOgCghwHe
Vw4TdTBdEl3e3Q14LgJTFuE=
=5Ndo
-----END PGP SIGNATURE-----

--=-ylo1u8P61ovCRKgA9XZE--

