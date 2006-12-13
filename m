Return-Path: <linux-kernel-owner+w=401wt.eu-S932646AbWLMJzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWLMJzf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWLMJzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:55:35 -0500
Received: from sirius.lasnet.de ([62.75.240.18]:33897 "EHLO sirius.lasnet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932645AbWLMJze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:55:34 -0500
Date: Wed, 13 Dec 2006 10:56:56 +0100
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>, Holger Macht <hmacht@suse.de>,
       len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Message-ID: <20061213095656.GC4104@datenfreihafen.org>
References: <20061204224037.713257809@localhost.localdomain> <20061211120508.2f2704ac.kristen.c.accardi@intel.com> <20061212221504.GA4104@datenfreihafen.org> <200612121431.11919.jbarnes@virtuousgeek.org> <20061212150033.e3c7612f.kristen.c.accardi@intel.com> <20061212232638.GB4104@datenfreihafen.org> <1166001255.5631.33.camel@pim.off.vrfy.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <1166001255.5631.33.camel@pim.off.vrfy.org>
X-Mailer: Mutt http://www.mutt.org/
X-KeyID: 0xDDF51665
X-Website: http://www.datenfreihafen.org/
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, 2006-12-13 at 10:14, Kay Sievers wrote:
> On Wed, 2006-12-13 at 00:26 +0100, Stefan Schmidt wrote:
> > On Tue, 2006-12-12 at 15:00, Kristen Carlson Accardi wrote:
> > >=20
> > > I did have different dock/undock events a few months ago - but
> > > after some discussion we scrapped them because Kay wants to avoid dri=
ver
> > > specific events.  The "change" event is the only thing that makes sen=
se,
> > > given the set of uevents available right now, and userspace should be=
=20
> > > able to handle checking a file to get driver specific details (i.e. d=
ock=20
> > > and undock status).  If you have a specific reason why this won't wor=
k,
> > > let me know.
> >=20
> > It's fine with me. I just find two different events more handy.
> > Checking the file after the event in userspace should not be aproblem.
>=20
> The thing is that we try to avoid driver-core "features" that are
> specific to a single subsystem or driver.
>=20
> You can easily add additional environment variables today, while sending
> a "change"-event with kobject_uevent_env(), like
> ACPI_DOCK=3D{lock,unlock,insert,remove,...}. Just pass any driver-specific
> string you like along with the event, and it will be available just like
> the "action" string.

Thanks for the explanation. I can live with both solutions. It's up to
Kristen.

> This should fit all requirements, without the need to introduce all
> sorts of new generic action-strings, that can almost never be changed
> later for compatibility reasons. That way, if "drivers" later find out,
> that they need to send different actions/flags, they can just add as
> many new strings as they like on top of the event. :)

Fair enough.

regards
Stefan Schmidt

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: http://www.datenfreihafen.org/contact.html

iD8DBQFFf85obNSsvd31FmURAty3AJ4y+2YD/69MncNKmcoMp6suQTVnvACg1YtD
wz9WnrpeX/zuUtfF5WfJ8GM=
=787S
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
