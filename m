Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWBGATn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWBGATn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWBGATn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:19:43 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:65483 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932389AbWBGATm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:19:42 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Tue, 7 Feb 2006 10:16:18 +1000
User-Agent: KMail/1.9.1
Cc: "Jim Crilly" <jim@why.dont.jablowme.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602060056.43672.rjw@sisk.pl> <20060206210736.GB12270@voodoo>
In-Reply-To: <20060206210736.GB12270@voodoo>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3965343.F1Z9V1HE0c";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071016.22240.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3965343.F1Z9V1HE0c
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jim.

On Tuesday 07 February 2006 07:07, Jim Crilly wrote:
> On 02/06/06 12:56:43AM +0100, Rafael J. Wysocki wrote:
> > > > > Oh. What's Pavel's solution? Fail freezing if uninterruptible
> > > > > threads don't freeze?
> > > >
> > > > Yes.
> > > >
> > > > AFAICT it's to avoid situations in which we would freeze having a
> > > > process in the D state that holds a semaphore or a mutex neded for
> > > > suspending or resuming devices (or later on for saving the image
> > > > etc.).
> > > >
> > > > [I didn't answer this question previously, sorry.]
> > >
> > > S'okay. This thread is an ocotpus :)
> > >
> > > Are there real life examples of this? I can't think of a single time
> > > that I've heard of something like this happening. I do see rare
> > > problems with storage drivers not having driver model support right,
> > > and thereby causing hangs, but that's brokenness in a completely
> > > different way.
> > >
> > > In short, I'm wondering if (apart from the forking issue), this is a
> > > straw man.
> >
> > It doesn't seem to be very probable to me too, but I take this
> > argument as valid.
> >
> > Greetings,
> > Rafael
>
> CIFS was good for that, if you have a CIFS filesystem mounted and
> take the network interface down (which I have my hibernate script do)
> before the filesystem is umounted it'll become impossible to umount
> the filesystem until the next reboot and I believe the cifsd kernel
> thread will be unfreezable. It's been a while since I've done that
> so it might be fixed now, but someone should verify it if it still
> exists and potentially work with the CIFS people to get it fixed.

Thanks for the pointer. I'll take a look at this.

Regards,

Nigel

> Jim.
>
> _______________________________________________
> Suspend2-devel mailing list
> Suspend2-devel@lists.suspend2.net
> http://lists.suspend2.net/mailman/listinfo/suspend2-devel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3965343.F1Z9V1HE0c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5+bWN0y+n1M3mo0RAronAJ9BBDmsCFS9gajFFH90r7a3dnmnkACfZE09
Rr0LEjEhtWb2X5+uFSmVpKQ=
=hhQO
-----END PGP SIGNATURE-----

--nextPart3965343.F1Z9V1HE0c--
