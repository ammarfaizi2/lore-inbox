Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWBBXVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBBXVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBBXVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:21:32 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56770 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932446AbWBBXVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:21:31 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Andrew Morton <akpm@osdl.org>, suspend2-devel@lists.suspend2.net
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 09:18:02 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
In-Reply-To: <20060202132708.62881af6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1669816.kGr0fDvutv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602030918.07006.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1669816.kGr0fDvutv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew et al.

On Friday 03 February 2006 07:27, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > > I don't want to argue Pavel. I want to give users the best suspend to
> > > disk implementation they can get. If you want to argue, you can do so
> > > with
> >
> > I want to create best suspen that can be still merged into kernel; I
> > guess thats the difference. Anyway I believe that most of suspend
> > should be done in userspace -- most of it can. But I guess you need to
> > hear it from Linus/Andrew, so...
>
> You're unlikely to hear anything dispositive from either of us on this.
> You three guys know far more than us about suspend, so it would be silly
> for us to be making the technical decisions.  When cornered, we're more
> likely to come out with general kernel platitudes such as "doing it in
> userspace:good" and "crashing the kernel:bad" and "incremental development
> with early merges:good" and "mucking up the kernel source:bad".
>
> What we hope and expect is that you'll come up with an agreed path in
> accordance with general kernel coding and development principles.  Linus
> and I don't want to have to make tiebreak decisions - if we have to do
> that, the system has failed.
>
> Random thoughts:
>
> - swsusp has been a multi-year ongoing source of churn and bug reports.
>   It hasn't been a big success and we have a way to go yet.
>
> - People seem to be doing too much development on the swsusp core and not
>   enough development out where the actual problems are: drivers which don=
't
>   suspend and resume correctly.
>
> - suspend2 is at a disadvantage because swsusp was merged first.  If
>   neither of the solutions had been merged and if we were evaluating them
>   side-by-side, suspend2 would have a much better chance.  This is a
>   problem.
>
> - If you want my cheerfully uninformed opinion, we should toss both of
>   them out and implement suspend3, which is based on the kexec/kdump
>   infrastructure.  There's so much duplication of intent here that it's n=
ot
>   funny.  And having them separate like this weakens both in the area whe=
re
>   the real problems are: drivers.
>
> - Justifying the inclusion of a feature by the appearance and usefulness
>   of the end result doesn't really work in this world.  There are numerous
>   unmerged kernel features out there which work well and look great.  But
>   we will look under the hood, and that's when problems start.
>
>
> So, as promised, there's nothing useful here.  What we'd most like to see
> is for Nigel to start working on in-kernel swsusp, merging up the good bi=
ts
> from suspend2 in some evolutionary incremental manner under which the
> kernel continually improves.  If, at the end of the day, that ends up with
> us having a complete implementation of suspend2, well, Mission
> Accomplished?

Thanks for the reply. You're right. It doesn't help at all :)

Well, actually it does.

It reminds me why I started working on this in the first place. It wasn't=20
because I wanted to be a big shot kernel developer or the like, or have my=
=20
name in the kernel credits. It was because I wanted to use the code.

So, given that I'm perfectly willing to send Pavel patches, but he's not=20
willing to take them, I guess I the best thing I can do is to just let Pave=
l=20
have his way, give up on the concept of merging Suspend2 and maintain it ou=
t=20
of tree. When Pavel and Rafael get swsusp up to scratch, I can stop doing=20
that and just use their version.

Well, that's what I think at the moment. Let's see how things progress.

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1669816.kGr0fDvutv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4pMuN0y+n1M3mo0RAnkAAKDRN2yBzA1cCpYSr4fr1XHfipAi2wCfZDQX
589/pkWPp9Pd//FpzZWwkvM=
=FxEr
-----END PGP SIGNATURE-----

--nextPart1669816.kGr0fDvutv--
