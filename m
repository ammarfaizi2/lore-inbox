Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTKFUuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTKFUuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:50:39 -0500
Received: from relay.pair.com ([209.68.1.20]:21508 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263839AbTKFUug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:50:36 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: Over used cache memory?
From: Daniel Gryniewicz <dang@fprintf.net>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0311062051270.21501-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0311062051270.21501-100000@gaia.cela.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2+sTXKWS1rfK+16X8aw1"
Message-Id: <1068151833.3901.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 15:50:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2+sTXKWS1rfK+16X8aw1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 14:57, Maciej Zenczykowski wrote:
> > On Thursday, 06 November 2003, at 17:15:33 +0800,
> > Wee Teck Neo wrote:
> >=20
> > >   procs                      memory      swap          io     system =
    =20
> > > cpu
> > > r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs =
us sy id
> > > 1  0  0  92744   9640  20240 801644    0    0     3    10   17     0 =
25  2 10
> > >=20
> > > The system is having 1GB ram and currently using 92MB as swap. Why do=
es the=20
> > > system use the slower swap when there are still memory available (as=20
> > > cache). Anyway to "force" the system to use more ram instead of putti=
ng=20
> > > into swap memory?
>=20
> Why would you want to?  The kernel has determined that 92MB of the stuff=20
> in memory is less important than the disk cache.  For example a program=20
> requires 100 MB data for boot and then spends the next week using the las=
t=20
> 5 MB.  Do you expect all 100 MB to stay resident in memory for ever=20
> (while the program is running)?  Of course not, it'll get swapped out onc=
e=20
> it is determined to be less used than the disk cache and only that last 5=
=20
> MB which is actually doing something will remain in RAM, with the rest=20
> quietly sitting in swap.  Swap is slower than RAM, sure, but using RAM fo=
r=20
> storing your dirty laundry from two weeks ago is pointless - and that's=20
> why it's swapped out - the disk cache will likely accelerate stuff more=20
> than keeping the odds and ends in memory.

Because your mozilla and evolution got swapped out overnight in favor of
cache touched by updatedb?  Then, when you get in in the morning, your
mozilla and evolution take forever to swap in, which is very annoying.=20
Frankly, I don't care at all if the updatedb takes slightly longer due
to less cache space, as long as my evolution and mozilla are not swapped
out.  This is why I don't have any swap on my desktop.  Responsiveness
of the desktop is much more important to me than any speed-up of
cron-based cache-limited processes.

A possibly better solution to this, in my opinion, would be a way to
mark a working set, which get's swapped in as soon as there's space (ie
as soon as cache get's older than some amount of time).  This would
allow mozilla to be swapped out in favor of cache during the night, and
then swapped back in automatically when that cache ages out.  Obviously
this would need to be disabled on multiuser systems, but would help, I
believe, on desktops.  Then again, I have no time or skill to code it,
so feel free to ignore me completely. :)  The "no swap" solution works
great for me.
--=20
Daniel Gryniewicz <dang@fprintf.net>

--=-2+sTXKWS1rfK+16X8aw1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qrQZomPajV0RnrERAgZ+AJwJfbPtMuUgfKqQO440f+dBipOtXgCfaUUB
Lio2RfjyOOL+I+pW0ndHB4g=
=mKrH
-----END PGP SIGNATURE-----

--=-2+sTXKWS1rfK+16X8aw1--
