Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVIMMnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVIMMnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVIMMnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:43:15 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:20352
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S932627AbVIMMnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:43:14 -0400
Date: Tue, 13 Sep 2005 14:43:12 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.13: Crash in Yenta initialization
Message-ID: <20050913124312.GB7308@erebor.esa.informatik.tu-darmstadt.de>
References: <200509030138.11905.koch@esa.informatik.tu-darmstadt.de> <200509030245.12610.koch@esa.informatik.tu-darmstadt.de> <20050903223401.A7470@jurassic.park.msu.ru> <20050913123604.GA7308@erebor.esa.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20050913123604.GA7308@erebor.esa.informatik.tu-darmstadt.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2005 at 02:36:04PM +0200, Andreas Koch wrote:
> Igor,

^^^^^^^ That should be Ivan, sorry for the mix-up (I just had a long
phone call with an Igor).

Andreas

>=20
> I just had a chance to do some more testing, and the crash even occurs
> in 2.6.13-rc2.  I haven't had a chance to get serial console logs yet,
> but I assume they will turn out similarly to the ones captured on
> 2.6.13 (glancing at the text as it scrolled by).  So, something must
> have changed between 2.6.12-rc6+patches and 2.6.13-rc2 (including the
> patches).
>=20
> Is there anything specific you want me to look for?
>=20
> Andreas
>=20
>=20
> On Sat, Sep 03, 2005 at 10:34:01PM +0400, Ivan Kokshaysky wrote:
> > On Sat, Sep 03, 2005 at 02:45:08AM +0200, Andreas Koch wrote:
> > > crucial part seem to be the different bridge initialization sections:
> >=20
> > Indeed.
> >=20
> > > 2.6.12-rc6 + Ivan's patches:
> > ...
> > >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
> > >             IO window: 00006000-00006fff
> > >             IO window: 00007000-00007fff
> > >             PREFETCH window: 82000000-83ffffff
> > >             MEM window: 8c000000-8dffffff
> > >           PCI: Bus 11, cardbus bridge: 0000:06:09.1
> > >             IO window: 00008000-00008fff
> > >             IO window: 00009000-00009fff
> > >             PREFETCH window: 84000000-85ffffff
> > >             MEM window: 8e000000-8fffffff
> > >           PCI: Bus 15, cardbus bridge: 0000:06:09.3
> > ...
> > > ... Versus the much shorter output from 2.6.13
> > ...
> > >           PCI: Bus 7, cardbus bridge: 0000:06:09.0
> > >             IO window: 00004000-000040ff
> > >             IO window: 00004400-000044ff
> > >             PREFETCH window: 82000000-83ffffff
> > >             MEM window: 88000000-89ffffff
> > >           PCI: Bridge: 0000:00:1e.0
> >=20
> > It's mysterious.
> > So 2.6.13 doesn't see cardbus bridge functions 06:09.1 and 06:09.3,
> > which means that these devices are not on the per-bus device list.
> > OTOH, they are still visible on the global device list, since yenta
> > driver found them. No surprise that it crashes with some uninitialized
> > pointer.
> >=20
> > I'd suspect some change in PCI probing code between 2.6.12-rc6 and
> > 2.6.13, but so far I'm unable to find what it was...
> >=20
> > Maybe you could try 2.6.12 release and 2.6.13-rc kernels to see where
> > it breaks?
> > (Note that the PCI setup patches that you're using went into 2.6.13-rc2=
=2E)
> >=20
> > Ivan.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDJslgk5ta2EV7DowRAoT6AJsHi3DlsN0i9i7d9+d259UYQOHdrQCdGsbI
CvQ0I8GxpUXsu5bP0ckqKLg=
=Xi8b
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
