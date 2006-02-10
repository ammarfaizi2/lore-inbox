Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWBJIIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWBJIIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWBJIIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:08:09 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:23769 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751188AbWBJIIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:08:07 -0500
Date: Fri, 10 Feb 2006 09:07:45 +0100
From: Harald Welte <laforge@netfilter.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, kaber@trash.net
Subject: Re: [stable] Re: [patch 6/6] [NETFILTER]: Fix another crash in ip_nat_pptp (CVE-2006-0037)
Message-ID: <20060210080745.GQ20362@sunbeam.de.gnumonks.org>
References: <20060128015840.722214000@press.kroah.org> <20060128021835.GG10362@kroah.com> <20060208123541.GA6004@kruemel.my-eitzenberger.de> <20060210044754.GC27457@kroah.com> <20060209205729.211cf713.akpm@osdl.org> <20060210050819.GA29085@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Content-Disposition: inline
In-Reply-To: <20060210050819.GA29085@kroah.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2006 at 09:08:19PM -0800, Greg KH wrote:
> On Thu, Feb 09, 2006 at 08:57:29PM -0800, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > On Wed, Feb 08, 2006 at 01:35:41PM +0100, Holger Eitzenberger wrote:
> > > > On Fri, Jan 27, 2006 at 06:18:35PM -0800, Greg KH wrote:
> > > >=20
> > > > >  	DEBUGP("altering call id from 0x%04x to 0x%04x\n",
> > > > > -		ntohs(*cid), ntohs(new_callid));
> > > > > +		ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_callid));
> > > >=20
> > > > Note that this fix introduces another bug in the above use DEBUGP
> > > > statement, as there is (u_int16_t *) ptr arithmetic used, whereas
> > > > cid_off is a byte offset.
> > > >=20
> > > > A fix for that was send a few weeks ago on netfilter-devel.
> > >=20
> > > Great, care to forward it to stable@kernel.org so we can get it in the
> > > next release?
> > >=20
> >=20
> > I have a copy of the patch and I'll cc stable@ on it.  Although afaik t=
his
> > bug just causes wrong debug info to come out, so I don't think it's
> > terribly important (?)
>=20
> If that's the only problem with it, no it's not worth adding to -stable.

Yes, this patch only fixes code in DEBUG statements.  Debug can only be
enabled at compile time, so I agree it's not a candidate for -stable.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7EnRXaXGVTD0i/8RAutkAJ97lXttmddlI5Ndw1CAUxQ+afDzYACgphHw
RS8a1rpFf7TdftemIokIk3A=
=wxLO
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--
