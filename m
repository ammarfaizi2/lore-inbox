Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWGYSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWGYSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWGYSA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:00:27 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:23245 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1751459AbWGYSA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:00:26 -0400
Date: Tue, 25 Jul 2006 14:00:12 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] input: Wacom tablet driver for simple X hotplugging
Message-ID: <20060725180012.GA6399@aehallh.com>
Mail-Followup-To: Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
	Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060721211341.5366.93270.sendpatchset@pipe> <200607221200.51700.wigge@bigfoot.com> <200607230124.56094.dtor@insightbb.com> <200607241828.32356.wigge@bigfoot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <200607241828.32356.wigge@bigfoot.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2006 at 06:28:32PM +0200, Magnus Vigerl=F6f wrote:
> On Sunday 23 July 2006 07:24, Dmitry Torokhov wrote:
> [...]
> > No, I was not talking about FUSD, just uinput driver that is in kernel
> > proper. Take a look at this:
> >
> > 	http://svn.navi.cx/misc/trunk/inputpipe/
> >
> > It allows making input devices "network-transparent" and for example
> > use joystick physically connected to one box to play game on another.
> > Hmm, actually it is almost what you need, you just need modify server
> > to multiplex events into single device instead of creating separate
> > input devices.
>=20
> Interesting.. This might be handy for other projects. However, implementi=
ng=20
> the same module again, but in userspace, for something that really should=
 be=20
> handled in the X-server (and will in time), nah.. I think I'll see what t=
he=20
> X-guys are up to and see how long they've come instead. Maybe I can contr=
ibute=20
> there in some way.

You get basic hotplug of input devices using xf86-input-evdev with
current versions, though you'd need current git for reasonable quality
tablet support.  That may still lack some of the wacom specific bits.
(I'd have to look to see what the wacom driver does that
xf86-input-evdev doesn't do.)

Hotplug with arbitrary drivers is a harder job, and I'm still not sure
if we're talking having that done in 7.2 or 7.3.  But it is coming.

All of that said, I'm going to have to agree with others, don't do it in
the kernel, because the need to do it in the kernel is going away.

Zephaniah E. Hull.

--=20
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

A little knowledge is a dangerous thing.
So is a lot.
  -- Albert Einstein.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFExlwsRFMAi+ZaeAERAuDsAJ90Y8RCsJs3Ul6/BdfwoYHDvD+lKwCgzWM+
IVDtQ0frCDiGoYMn1T2YyXs=
=GDBY
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
