Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWBEXqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWBEXqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWBEXqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 18:46:47 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:55446 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750787AbWBEXqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 18:46:47 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Mon, 6 Feb 2006 09:43:15 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602042141.23685.nigel@suspend2.net> <200602041818.57278.rjw@sisk.pl>
In-Reply-To: <200602041818.57278.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart54251719.T4Goy6fRTD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602060943.19774.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart54251719.T4Goy6fRTD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 05 February 2006 03:18, Rafael J. Wysocki wrote:
> Hi,
>
> On Saturday 04 February 2006 12:41, Nigel Cunningham wrote:
> > On Saturday 04 February 2006 21:38, Rafael J. Wysocki wrote:
> > > > > My personal view is that:
> > > > > 1) turning the freezing of kernel threads upside-down is not
> > > > > necessary and would cause problems in the long run,
> > > >
> > > > Upside down?
> > >
> > > I mean now they should freeze voluntarily and your patches change
> > > that so they would have to be created as non-freezeable if need be,
> > > AFAICT.
> >
> > Ah. Now I'm on the same page. Lost the context.
> >
> > > > > 2) the todo lists are not necessary and add a lot of complexity,
> > > >
> > > > Sorry. Forgot about this. I liked it for solving the SMP problem,
> > > > but IIRC, we're downing other cpus before this now, so that issue
> > > > has gone away. I should check whether I'm right there.
> > > >
> > > > > 3) trying to treat uninterruptible tasks as non-freezeable
> > > > > should better be avoided (I tried to implement this in swsusp
> > > > > last year but it caused vigorous opposition to appear, and it
> > > > > was not Pavel ;-))
> > > >
> > > > I'm not suggesting treating them as unfreezeable in the fullest
> > > > sense. I still signal them, but don't mind if they don't respond.
> > > > This way, if they do leave that state for some reason (timeout?)
> > > > at some point, they still get frozen.
> > >
> > > Yes, that's exactly what I wanted to do in swsusp. ;-)
> >
> > Oh. What's Pavel's solution? Fail freezing if uninterruptible threads
> > don't freeze?
>
> Yes.
>
> AFAICT it's to avoid situations in which we would freeze having a
> process in the D state that holds a semaphore or a mutex neded for
> suspending or resuming devices (or later on for saving the image etc.).
>
> [I didn't answer this question previously, sorry.]

S'okay. This thread is an ocotpus :)

Are there real life examples of this? I can't think of a single time that=20
I've heard of something like this happening. I do see rare problems with=20
storage drivers not having driver model support right, and thereby causing=
=20
hangs, but that's brokenness in a completely different way.

In short, I'm wondering if (apart from the forking issue), this is a straw=
=20
man.

Regards,

Nigel

> Greetings,
> Rafael
>
> _______________________________________________
> Suspend2-devel mailing list
> Suspend2-devel@lists.suspend2.net
> http://lists.suspend2.net/mailman/listinfo/suspend2-devel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart54251719.T4Goy6fRTD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5o2XN0y+n1M3mo0RApp/AKDImhxeajthiEAQ3Dyp/MIrkfhl9ACeJ7qq
pJEWkfyri4LDB9uO6WvqDbw=
=eIOy
-----END PGP SIGNATURE-----

--nextPart54251719.T4Goy6fRTD--
