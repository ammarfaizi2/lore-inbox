Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWBWAml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWBWAml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWBWAml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:42:41 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63623 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030319AbWBWAmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:42:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 10:39:39 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602231011.44889.ncunningham@cyclades.com> <20060223003300.GL13621@elf.ucw.cz>
In-Reply-To: <20060223003300.GL13621@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1335736.imWXiEuIWH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602231039.45507.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1335736.imWXiEuIWH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Thursday 23 February 2006 10:33, Pavel Machek wrote:
> Hi!
>
> > > > > > The fact that we use page flags to store some
> > > > > > suspend/resume-related information is a big disadvantage in my
> > > > > > view, and I'd like to get rid of that in the future.  In
> > > > > > principle we could use a bitmap, or rather two of them, to store
> > > > > > the same information independently of the page flags, and if we
> > > > > > use bitmaps for this purpose, we can use them also instead of
> > > > > > PBEs.
> > > > >
> > > > > Well, we "only" use 2 bits... :-).
> > > >
> > > > In my view the problem is this adds constraints that other people
> > > > have to take into account.  Not a good thing if avoidable IMHO.
> > >
> > > Well, I hope that swsusp development will move to userland in future
> > >
> > > :-).
> >
> > I don't get your point. I mean, we're talking about flags that record
> > what pages are going to be in the image, be atomically copied and so on.
> > Are you planning on trying to export the free page information and the
> > like to userspace too, along with atomic copy code?
>
> No, certainly not.
>
> Rafael said something like "being limited is bad, because it makes it
> hard to change in-kernel snapshoting code". My reply was something
> like "I hope people will stop changing in-kernel swsusp code, and hack
> userland instead".
>
> Atomic copy code has to stay with kernel: it needs disabled
> interrupts, access to all the RAM, etc. It screams "kernel code".

Good to know. I was afraid you were losing the plot for a minute there :)

Nigel

--nextPart1335736.imWXiEuIWH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/QRRN0y+n1M3mo0RAqWNAJwKEfDT8JgKZ6ivBjBWCI/uej/RyACfdI/4
odOZ2rH15cjVZb3WhduBI9U=
=OmJG
-----END PGP SIGNATURE-----

--nextPart1335736.imWXiEuIWH--
