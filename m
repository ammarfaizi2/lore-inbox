Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWC0WoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWC0WoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWC0WoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:44:14 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:7863 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751159AbWC0WoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:44:14 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Date: Mon, 27 Mar 2006 20:43:59 +1000
User-Agent: KMail/1.9.1
Cc: Mark Lord <lkml@rtr.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <442325DA.80300@rtr.ca> <20060327102636.GH14344@elf.ucw.cz>
In-Reply-To: <20060327102636.GH14344@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25992401.5UrFnRzfjs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603272044.05431.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart25992401.5UrFnRzfjs
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Pavel.

On Monday 27 March 2006 20:26, Pavel Machek wrote:
> On =C4=8Ct 23-03-06 17:48:58, Mark Lord wrote:
> > Rafael J. Wysocki wrote:
> > >I agree it probably may be improved.  Still it seems to be good enough.
> > >Further,
> > >it's more efficient than the previous solution, so I consider it as an
> > >improvement.
> > >Also this code has been tested for quite some time in -mm and appears =
to
> > >behave properly, at least we haven't got any bug reports related to it
> > > so far.
> >
> > I find the in-kernel swsusp to be quite slow, and it seems to use
> > an awful lot of memory for book-keeping.  So count that as encouragement
> > to improve the performance when you can.
>
> Extents will provide 0.01% speedup at most, and with increase of code
> complexity. Not a nice tradeoff if you ask me.

My point wasn't speed, but efficient use of memory. A bitmap is certainly=20
better than storing n*sizeof(swap_entry_t) byes. Extents would be better=20
again, but perhaps not as big after the bitmap switch.

> If you want faster suspend, that should be easy. You'll need *current*
> 2.6.16-git , and userland tools from suspend.sf.net . There's HOWTO
> that explains how to set it up. We can even do LZF these days...
>
> > >Currently I'm not working on any better solution.  If you can provide
> > > any patches to implement one, please submit them, but I think they'll
> > > have to be
> > >tested for as long as this code, in -mm.
> >
> > It would be *really nice* if you guys could stop being so underhandedly
> > nasty in every single reply to anything from Nigel.
> >
> > He really is trying to help, you know.
>
> Actually Rafael was *very* nice at him, I'd say. Pointing for tiny
> inefficiencies, without patch attached is not really helpful.

Yes, I didn't think Rafael was harsh in that email, but that's just my=20
opinion. Regarding "without patch attached", could you please remember that=
=20
comment next time you comment on my patches?

> I have repeatedly pointed him on ways how he can *really* help. There
> are ways to do suspend2 in userspace these days, but Nigel refuses to
> use them.

You know that I disagree that doing suspend in userspace is the right=20
approach, and you know that current uswsusp can't do everything Suspend2 do=
es=20
without further substantial modification. Please stop painting me as the ba=
d=20
guy because I won't roll over and play dead for you. Please also stop=20
encouraging people to use uswsusp when you have also warned that it might e=
at=20
their partitions.

Regards,

Nigel

--nextPart25992401.5UrFnRzfjs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEJ8H1N0y+n1M3mo0RAvMRAKCfw/Hw46qm4UCckR05U+I8EDdyKACfXs94
wtKsZDfnVesxiHE5rUCCvJ8=
=UT0v
-----END PGP SIGNATURE-----

--nextPart25992401.5UrFnRzfjs--
