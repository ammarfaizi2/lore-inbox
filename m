Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWGNWiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWGNWiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161319AbWGNWiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:38:50 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21934 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161318AbWGNWit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 18:38:49 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Rt-tester makes freezing processes fail.
Date: Sat, 15 Jul 2006 08:38:49 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tglx@timesys.com, linux-pm@lists.osdl.org,
       Pavel Machek <pavel@ucw.cz>
References: <200607140918.49040.nigel@suspend2.net> <20060713163743.e71975b0.akpm@osdl.org> <200607141017.27832.rjw@sisk.pl>
In-Reply-To: <200607141017.27832.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1615659.YCDIlZWo73";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607150838.53591.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1615659.YCDIlZWo73
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 14 July 2006 18:17, Rafael J. Wysocki wrote:
> On Friday 14 July 2006 01:37, Andrew Morton wrote:
> > On Fri, 14 Jul 2006 09:18:43 +1000
> >
> > Nigel Cunningham <nigel@suspend2.net> wrote:
> > > Compiling in the rt-tester currently makes freezing processes fail.
> > > I don't think there's anything wrong with it running during
> > > suspending, so adding PF_NOFREEZE to the flags set seems to be the
> > > right solution.
> > >
> > > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > >
> > >  rtmutex-tester.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c
> > > 9971-rt-tester.patch-new/kernel/rtmutex-tester.c ---
> > > 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07
> > > 10:27:46.000000000 +1000 +++
> > > 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14
> > > 07:48:01.000000000 +1000 @@ -259,7 +259,7 @@ static int test_func(void
> > > *data)
> > >  	struct test_thread_data *td =3D data;
> > >  	int ret;
> > >
> > > -	current->flags |=3D PF_MUTEX_TESTER;
> > > +	current->flags |=3D PF_MUTEX_TESTER | PF_NOFREEZE;
> > >  	allow_signal(SIGHUP);
> > >
> > >  	for(;;) {
> >
> > I yesterday queued up the below patch.  Which approach is most
> > appropriate?
>
> I prefer the one that makes these threads freeze (ie. the Luca's patch).

Ok.

Nigel
=2D-=20
See http://www.suspend2.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1615659.YCDIlZWo73
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEuBz9N0y+n1M3mo0RAhltAJ9UxALBiWAhZhkj5Q+R89nXIUZ0/QCfR3XS
XAnsRxtK9OBhs/M+7pQB8V4=
=kcGL
-----END PGP SIGNATURE-----

--nextPart1615659.YCDIlZWo73--
