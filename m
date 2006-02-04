Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWBDLou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWBDLou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWBDLou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:44:50 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:38380 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932355AbWBDLot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:44:49 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 21:41:19 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602042108.52112.nigel@suspend2.net> <200602041238.06395.rjw@sisk.pl>
In-Reply-To: <200602041238.06395.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1248051.NdkRLbgVTz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602042141.23685.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1248051.NdkRLbgVTz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 04 February 2006 21:38, Rafael J. Wysocki wrote:
> > > My personal view is that:
> > > 1) turning the freezing of kernel threads upside-down is not
> > > necessary and would cause problems in the long run,
> >
> > Upside down?
>
> I mean now they should freeze voluntarily and your patches change that
> so they would have to be created as non-freezeable if need be, AFAICT.

Ah. Now I'm on the same page. Lost the context.

> > > 2) the todo lists are not necessary and add a lot of complexity,
> >
> > Sorry. Forgot about this. I liked it for solving the SMP problem, but
> > IIRC, we're downing other cpus before this now, so that issue has gone
> > away. I should check whether I'm right there.
> >
> > > 3) trying to treat uninterruptible tasks as non-freezeable should
> > > better be avoided (I tried to implement this in swsusp last year but
> > > it caused vigorous opposition to appear, and it was not Pavel ;-))
> >
> > I'm not suggesting treating them as unfreezeable in the fullest sense.
> > I still signal them, but don't mind if they don't respond. This way,
> > if they do leave that state for some reason (timeout?) at some point,
> > they still get frozen.
>
> Yes, that's exactly what I wanted to do in swsusp. ;-)

Oh. What's Pavel's solution? Fail freezing if uninterruptible threads don't=
=20
freeze?

> > > > A couple of possible  exceptions might be (1) freezing bdevs,
> > > > because you don't care so much about making xfs really sync and
> > > > really stop it's activity
> > >
> > > As I have already stated, in my view this one is at least worth
> > > considering in the long run.
> > >
> > > > and (2) the  ability to thaw kernel space without thawing
> > > > userspace. I want this for eating memory, to avoid deadlocking
> > > > against kjournald etc. I haven't checked carefully as to why you
> > > > don't need it in vanilla.
> > >
> > > Because it does not deadlock?  I will say we need this if I see a
> > > testcase showing such a deadlock clearly.
> >
> > I've been surprised that you haven't already seen them while eating
> > memory such that filesystems come into play. Perhaps you guys only use
> > swap partitions, and something like a swapfile with some memory
> > pressure might trigger this? Or it could be a side effect of one of
> > the other changes.
>
> In fact, we only use swap partitions, so this will be needed if we are
> going to use files, I guess.  Nice to know in advance, thanks. ;-)

k. Just so you don't confuse me, can I ask you not to refer to swapfiles as=
=20
'files'? I support swap partitions, swapfiles and ordinary files, so the=20
latter will come to mind first for me.

Regards,

Nigel

> Greetings,
> Rafael

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1248051.NdkRLbgVTz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5JLjN0y+n1M3mo0RAh/ZAJ9AP+9QB5zK6OFDr4KHlxofV5YJjgCghTe9
eBw2WRK6aapy9su8WN5IMFI=
=IHCw
-----END PGP SIGNATURE-----

--nextPart1248051.NdkRLbgVTz--
