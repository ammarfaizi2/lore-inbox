Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSJ1Qxw>; Mon, 28 Oct 2002 11:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJ1Qxw>; Mon, 28 Oct 2002 11:53:52 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:38664 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S261367AbSJ1Qxr>;
	Mon, 28 Oct 2002 11:53:47 -0500
Date: Mon, 28 Oct 2002 12:00:04 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021028170004.GB20446@babylon.d2dc.net>
Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>, vojtech@suse.cz,
	linux-kernel@vger.kernel.org
References: <20021027010538.GA1690@babylon.d2dc.net> <20021028132752.GB1253@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20021028132752.GB1253@ppc.vc.cvut.cz>
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2002 at 02:27:52PM +0100, Petr Vandrovec wrote:
> On Sat, Oct 26, 2002 at 09:05:38PM -0400, Zephaniah E. Hull wrote:
> > To make a long story short, mousedev.c does not properly implement the
> > EXPS/2 protocol, specificly dealing with the wheel.
> >=20
> > The lower 8 bits of the 4th byte are supposed to be 0x1 or 0xf to
> > indicate movement of the first wheel, and 0x2 or 0xe for the second
> > wheel.
>=20
> Hi,
>   I was talking about this problem with Vojtech some months ago,
> and unfortunately we were not able to find correct way to implement it:
> there are mouses (probably majority) which have only one wheel, and
> which reports fast wheel movement as 2,3,4... or 0xe,0xd,.... Protocol
> is documented this way on Microsoft web pages.

Crap, I have interestingly enough never had reports of a mouse which
generates fast wheel movement in that manner, this makes things a bit
more, er, interesting.

Is this for exps2 or imps2?
(Trying to find the page from microsoft now.)
>=20
>   Then there is another group of mices (mine A4Tech with two wheels
> being one of them) which reports vertical wheel always as 1/0xF, and
> horizontal as 2/0xE (and if you move both, they reports once horizontal
> and once vertical wheel).
>=20
>   Unfortunately we were not able to find how to detect these mouses in
> advance, and when I asked A4Tech, I got back answer that I should use
> their mouse driver, and not one delivered by Microsoft (although Linux
> was every third word in question). From this answer I conclude that
> there is no way to autodetect it, and it has to be specified by some
> options passed to mouse driver.

We can deal with one half of this, by acting like the a4tech mice when
emulating the exps2 protocol, as far as when reading from them in PS/2
mode....

On the bright side, USB mice are fucked up in new and interesting ways!

(Have a patch for dealing with this A4Tech mouse's second wheel when it
is attached as a USB device, but until mousedev.c knows what to do with
information about the second wheel...)

Zephaniah E. Hull.
(Debian gpm maintainer.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

[1] Yes, we ARE rather dull people.  We appreciate being dull people.
Exciting is only good when it happens to someone else ... as in "an
exciting wreck", "an exciting plane crash", "an exciting install of
Windows XP", et al.
  -- Ralph Wade Phillips in the Scary Devil Monastery.

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9vW0URFMAi+ZaeAERAuUHAJ44Og+s5gDSXVYGrXK1YLnHL3oxeACgpLOw
f0Vv8Ae6Bk1Q4SFI3/8bnyc=
=7id2
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
