Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVGKV4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVGKV4G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVGKVzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:55:50 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:57030 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262801AbVGKVzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:55:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
Date: Tue, 12 Jul 2005 07:55:00 +1000
User-Agent: KMail/1.8.1
Cc: Ken Moffat <ken@kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net> <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net>
In-Reply-To: <Pine.LNX.4.58.0507112044001.3450@ppg_penguin.kenmoffat.uklinux.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2739073.8hSicVdXCD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507120755.03110.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2739073.8hSicVdXCD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 12 Jul 2005 05:45, Ken Moffat wrote:
> On Mon, 11 Jul 2005, Ken Moffat wrote:
> > Hi,
> >
> >  I've been using the ondemand governor on athlon64 winchesters for a few
> > weeks.  I've just noticed that in 2.6.12 the frequency is not
> > increasing under load, it remains at the lowest frequency.  This seems
> > to be down to something in 2.6.12-rc6, but I've seen at least one report
> > since then that ondemand works fine.  Anybody else seeing this problem ?
>
>  And just for the record, it's still not working in 2.6.13-rc2.  Oh
> well, back to 2.6.11 for this box.

I noticed a change in ondemand on pentiumM, where it would not ramp up if t=
he=20
task using cpu was +niced. It does ramp up if the task is not niced. This=20
seems to have been considered all round better but at my end it is not - if=
=20
it takes the same number of cycles to complete a task it does not save any=
=20
battery running it at 600Mhz vs 1700Mhz, it just takes longer. Yes I know=20
during the initial ramp up the 1700Mhz one will waste more battery, but tha=
t=20
is miniscule compared to something that burns cpu constantly for 10 mins. N=
ow=20
I'm forced to run my background tasks at nice 0 and not get the benefit of=
=20
nicing the tasks, _or_ I have to go diddling with settings in /sys to disab=
le=20
this feature or temporarily move to the performance governor. Although I=20
complained lightly initially when this change was suggested, I didn't reali=
se=20
it was actually going to become standard.=20

To me the ondemand governor was supposed to not delay you at all, but cause=
 as=20
much battery saving as possible without noticeable slowdown...

Oh well you can't please everyone all the time.=20

Con

--nextPart2739073.8hSicVdXCD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0uq3ZUg7+tp6mRURAlldAJ9QS4MwND4hydGjLVDB0d5dJNphowCfUvyo
YhU1E+WNpFvJTZ9f68WpLuI=
=V5DZ
-----END PGP SIGNATURE-----

--nextPart2739073.8hSicVdXCD--
