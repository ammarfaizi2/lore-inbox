Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWBBMlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWBBMlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWBBMks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:40:48 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:39867 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751000AbWBBMko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:40:44 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Thu, 2 Feb 2006 22:14:48 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz>
In-Reply-To: <20060202115907.GH1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1151847.dRXbmx6jt0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022214.52752.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1151847.dRXbmx6jt0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 21:59, Pavel Machek wrote:
> On =C4=8Ct 02-02-06 21:31:55, Nigel Cunningham wrote:
> > Hi.
> >
> > On Thursday 02 February 2006 20:47, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > swsusp already has a very strong API to separate image writing fr=
om
> > > > > image creation (in -mm patch, anyway). It is also very nice, just
> > > > > read() from /dev/snapshot. Please use it.
> > > >
> > > > You know that's not an option.
> > >
> > > No, I don't... please explain. Switching to this interface is going to
> > > be easier than pushing suspend2 into kernel. Granted, end result may
> > > not be suspend2, it may be something like suspend3, but it will be
> > > better result than u-swsusp or suspend2 is today...
> >
> > It's not an option because I'm not trying not to step all over your
> > codebase, because I'm not moving suspend2 to userspace and because it
> > doesn't make sense to add another layer of abstraction by sticking
> > /dev/snapshot in the middle of kernel space code. There may be more
> > reasons, but I haven't looked at the /dev/snapshot code at all.
>
> Please take a look at /dev/snapshot.
>
> Parse error at the first sentence (too many nots), anyway:
>
> 1) we do not want two implementations of same code in kernel. [swsusp
> vs. pmdisk was a mess]
>
> 2) we are not going to merge code into kernel, when it is possible to
> do same thing in userspace. (*)
>
> 3) backwards compatibility is important in stable series.
>
> 4) merging code into kernel is a lot of work.
>
> I do not think I want to remove swsusp from kernel. Even if I wanted
> to, there's 3). That means suspend2 should not go in (see 1). Even if I
> removed swsusp from kernel, suspend2 is not going to be merged,
> because of 2). Even if world somehow forgot that it is possible to do
> suspend2 in userspace, merging 10K lines of code is (4) still lot of
> work.
>
> Oops, that looks bad for suspend2 merge. I really think you should
> take a look at /dev/snapshot. Unless it is terminally broken, I can't
> see how suspend2 could be merged.

I don't want to argue Pavel. I want to give users the best suspend to disk=
=20
implementation they can get. If you want to argue, you can do so with=20
yourself. Meanwhile, I'll work on getting Suspend2 ready for merging, and l=
et=20
Andrew and Linus decide what they think should happen. If they want to step=
=20
in now and tell me not to bother, I'll happily listen and just maintain the=
=20
patches out of kernel until you and Rafael get swsusp up to scratch. I'll=20
even cc them now so they can have the opportunity to tell me not to bother.=
=20
But that's not what I've heard so far. In previous correspondence between u=
s,=20
Andrew has seemed keen to get a better implementation in, and Linus said=20
something to the effect of "I'm sold" when I gave him an impromptu demo las=
t=20
week at LCA (Linus, if you read this, feel free to tell me if my memory is=
=20
faulty and I'm putting words in your mouth).

As to backwards compatability, that shouldn't be hard to do.

Regards,

Nigel

> 									Pavel
> (*) or very close to same thing. We still can't save memory full of cache=
s.

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1151847.dRXbmx6jt0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4fe8N0y+n1M3mo0RAr2pAKDnHyZQhWxyYXDtmntbR3EYFWLFHACgwCbh
kMQ7Af+w65P3bPiC1ypw288=
=QgIt
-----END PGP SIGNATURE-----

--nextPart1151847.dRXbmx6jt0--
