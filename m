Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWBTCxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWBTCxu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 21:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWBTCxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 21:53:50 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63423 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932594AbWBTCxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 21:53:50 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 12:50:40 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602201025.01823.nigel@suspend2.net> <20060220005333.GL15608@elf.ucw.cz>
In-Reply-To: <20060220005333.GL15608@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1390178.ZF9T7EAcx8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602201250.44443.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1390178.ZF9T7EAcx8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 10:53, Pavel Machek wrote:
> Hi!
>
> > > > It is a lot slower because it does all it's I/O synchronously,
> > > > doesn't compress the image and throws away memory until at least ha=
lf
> > > > is free.
> > >
> > > uswsusp does compress image (20% speedup, in recent CVS) and do
> > > asynchronous I/O.
> >
> > Only 20? You must be doing something horribly wrong. Asynchronous
>
> 20% is speedup for compression alone, over whole suspend
> process. Device suspend/resume takes lot of time in recent kernels.

Ok. I'm not counting device suspend/resume time, but if you do, the percent=
age=20
will vary according to the image size (since the device suspend/resume time=
=20
should be independant of image size).

> > > > > > The only con I see is the complexity of the code, but then agai=
n,
> > > > > > Nigel
> > > > >
> > > > > ..but thats a big con.
> > > >
> > > > It's fud. Hopefully as I post more suspend2 patches to LKML, people
> > > > will see that Suspend2 is simpler than what you are planning.
> > >
> > > For what I'm planning, all the neccessary patches are already in -mm
> > > tree. And they are *really* simple. If you can get suspend2 to 1000
> > > lines of code (like Rafael did with uswsusp), we can have something to
> > > talk about.
> >
> > Turn it round the right way. If you can get the functionality of Suspen=
d2
> > using userspace only, then we have something to talk about.
>
> Only feature I can't do is "save whole pagecache"... and 14000 lines
> of code for _that_ is a bit too much. I could probably patch my kernel
> to dump pagecache to userspace, but I do not think it is worth the
> effort.

Yes, 14,000 lines for that alone would be a bit too much :)

> > > > Let's be clear. uswsusp is not really moving suspend-to-disk to
> > > > userspace. What it is doing is leaving everything but some code for
> > > > writing the image in kernel space, and implementing ioctls to give a
> > > > userspace program the ability to request that other processes be
> > > > frozen, the snapshot prepared and so on. Pages in the snapshot are
> > > > copied to userspace, possibly compressed or encrypted there in
> > > > future, then fed back to kernel space so it can use the swap routin=
es
> > > > to do the writing. Very little of substance is being done in
> > > > userspace. In short, all it's doing is adding the complexity of
> > >
> > > Maybe very little of substance is being done in userspace, but all the
> > > uglyness can stay there. I no longer need LZF in kernel, special
> > > netlink API for progress bar (progress bar naturally lives in
> > > userland), no plugin infrastructure needed, etc.
> >
> > And you do need?...
>
> I do not need anything more than what is already in -mm tree.

You misunderstand me. Let me reprhase. What additional dependencies do you=
=20
have in userspace to support this? libabc, v >=3D x.y.z etc.

> > > If you can do suspend2 without putting stuff listed above into kernel,
> > > and in acceptable ammount of code... we can see. But you should really
> > > put suspend2 code into userspace, and be done with that. Feel free to
> > > spam l-k a bit more, but using existing infrastructure in -mm is right
> > > way to go, and it is easier, too.
> >
> > It is only easier because you're not comparing apples with apples. I ha=
ve
> > no desire to spam LKML with this pointless discussion, so I'm just going
> > to get on with submitting patches for review.
>
> So please take my comments from "suspend2 review" mail into account.

Am going, as I do with all responses. Please just remember that taking them=
=20
into account doesn't equate to slavishly doing everything suggested.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1390178.ZF9T7EAcx8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+S6EN0y+n1M3mo0RArElAJ9bQXrZfPEARf36Rv9qrH5+XrvGOACeMvGv
Oiock9KRnvdDDmiIUaHQSuU=
=bti5
-----END PGP SIGNATURE-----

--nextPart1390178.ZF9T7EAcx8--
