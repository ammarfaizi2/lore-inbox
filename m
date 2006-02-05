Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWBEXsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWBEXsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 18:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWBEXsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 18:48:17 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56982 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750789AbWBEXsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 18:48:17 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Mon, 6 Feb 2006 09:44:56 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041238.06395.rjw@sisk.pl> <20060204191042.GA3909@elf.ucw.cz>
In-Reply-To: <20060204191042.GA3909@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2393134.ncadD1EGkF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602060945.01141.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2393134.ncadD1EGkF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 05 February 2006 05:10, Pavel Machek wrote:
> Hi!
>
> > > > 3) trying to treat uninterruptible tasks as non-freezeable should
> > > > better be avoided (I tried to implement this in swsusp last year
> > > > but it caused vigorous opposition to appear, and it was not Pavel
> > > > ;-))
> > >
> > > I'm not suggesting treating them as unfreezeable in the fullest
> > > sense. I still signal them, but don't mind if they don't respond.
> > > This way, if they do leave that state for some reason (timeout?) at
> > > some point, they still get frozen.
> >
> > Yes, that's exactly what I wanted to do in swsusp. ;-)
>
> It seems dangerous to me. Imagine you treated interruptible tasks like
> that...
>
> What prevent task from doing
>
> 	set_state(UNINTERRUPTIBLE);
> 	schedule(one hour);
> 	write_to_filesystem();
> 	handle_signal()?
>
> I.e. it may do something dangerous just before being catched by
> refrigerator.

The write_to_filesystem would be caught be bdev freezing if you had it.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2393134.ncadD1EGkF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5o39N0y+n1M3mo0RAtjUAJ0Zg8bsQp6s6QdjqeE+OqpEZCiU0wCdFSFk
HyacB3Hb2VM0AXXtLt/OrPM=
=udsx
-----END PGP SIGNATURE-----

--nextPart2393134.ncadD1EGkF--
