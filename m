Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318377AbSHBKYc>; Fri, 2 Aug 2002 06:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318383AbSHBKYc>; Fri, 2 Aug 2002 06:24:32 -0400
Received: from [213.69.232.58] ([213.69.232.58]:778 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318377AbSHBKYb>;
	Fri, 2 Aug 2002 06:24:31 -0400
Date: Fri, 2 Aug 2002 05:57:01 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: george anzinger <george@mvista.com>
Cc: Nico Schottelius <nicos-mutt@pcsystems.de>, Joshua Uziel <uzi@uzix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpu speed is 165mhz instead of real 650mhz
Message-ID: <20020802035701.GA311@schottelius.org>
References: <20020724110121.GA1925@schottelius.org> <20020724102709.GA17905@uzix.org> <20020724131642.GA479@schottelius.org> <3D3F0A5E.E548C8DA@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <3D3F0A5E.E548C8DA@mvista.com>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Once again I am on a 147Mhz system....

george anzinger [Wed, Jul 24, 2002 at 01:13:18PM -0700]:
> Nico Schottelius wrote:
> > Joshua Uziel [Wed, Jul 24, 2002 at 03:27:09AM -0700]:
> > > * Nico Schottelius <nicos-mutt@pcsystems.de> [020724 02:03]:
> > > > This periodicly appears in my system. The Kernel seems to misdetect=
 the
> > > > right cpu speed and then it's running only at 165mhz.
> > > > I don't really understand why this happens, there's no acpi enabled=
, which
> > > > caused this failure the last time.
> > >
> > > Is this a notebook computer?  Is it that you're sometimes booting it =
up
> > > while the system is unplugged (ie. on battery)?
> >=20
> > yes,it is, but slowing down to 500 mhz is the only  available speedstep
> > option.
> >=20
> > 165 or similar is not supported (afaik) by the bios/processor.
> >=20
> The cpu speed is detected by comparing the TSC against the
> PIT.

I don't even now any of these both.

> The PIT is used to drive the clock.  If it is wrong by
> this much you should see time drifting like mad.

Hey, you are right! Instead of 13 o'clock it's 5 o'clock.
What todo now ? I am staying on this downclocked system, if you
need some more informations.

> If the TSC
> is wrong, you should see errors in the sub 1/HZ correction
> applied to get_time_of_day().
> You could detect this by
> looping on a get_time_of_day() call and noticing that time
> slides ahead 3/HZ seconds and then back each tick.  What
> would be happening is that the interpolation code would be
> taking the fast TSC (i.e. 500MHZ when it thought it was 165)
> and be pushing time out beyond the next tick value.  Each
> tick this would reset and be replayed.  If neither of these
> is happening, the reported value is most likely what is
> really going on.

Nice explanation. I think I understood 85 % of it :)

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SgMNtnlUggLJsX0RAmZsAJ44J9b117wuQzQg8djavKWTG5szrgCfUkcq
frMlkZ/RzOh9Ge9d7pTXiVw=
=yRPM
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
