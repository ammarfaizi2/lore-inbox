Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314030AbSDQCmA>; Tue, 16 Apr 2002 22:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314032AbSDQCl7>; Tue, 16 Apr 2002 22:41:59 -0400
Received: from adsl-64-109-202-37.dsl.milwwi.ameritech.net ([64.109.202.37]:34031
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S314030AbSDQClw>; Tue, 16 Apr 2002 22:41:52 -0400
Date: Tue, 16 Apr 2002 21:41:49 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Larry McVoy <lm@work.bitmover.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020417024149.GC5897@0xd6.org>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Larry McVoy <lm@bitmover.com> on Tue, Apr 16, 2002:

> >=20
> > A drop-in tree (also called "shadow trees" by Keith Owens of kbuild), i=
s a
> > small set of files intended to be applied against a larger parent body =
of
> > code.  For example, a kernel subsystem or backend project (linuxconsole,
> > LinuxSH, Linux-MIPS) will only maintain the minimal number of files that
> > are specific to that backend, e.g. include/asm-mips/, arch/mips,
> > /arch/mips64, etc. for any files local to the project. =20
>=20
> Ahh, OK, we're already working on this.  We call 'em nested repositories
> and one of the problems they solve is exactly the problem you described.
> Think of them as CVS modules, with a little more formality, and you're
> about there.  They also solve a bunch of performance problems.
>=20

That's good to hear, and interesting as well.  Any particular reason why
this wasn't implemented until now?  Did you not see a high demand for
satellite projects, or was it just assumed that you'd only ever need the
clone method of development?

> I tend to agree with your comments about not wanting the whole tree, to
> some extent.  You are aware, of course, that your drop in may not work
> if the rest of the tree has moved on.  So the drop in has a limited
> life span in isolation.  With that caveat, drop ins are nice and we'll
> have them before too long.  Unlike CVS, we like to be able to reproduce
> the tree accurately so there is more work to do.
>=20

This requires consistency on the part of the drop-in tree maintainer, to
sync to and from the mainline kernel.  Usually, only the maintainer sends
patches upstream, but experienced project developers can easily merge
changes coming from the mainline kernel.  I'm not aware of how BK may
automate this or make it easier, but this is one of those "use rigid
guidelines where CVS falls short" situations.  *Shrug*, a bit of extra
work, but still easier than tracking an entire tree's worth of changes.

> On your comments about CVS being less complex, I don't agree at all.
> Almost all of the BK complexity is to handle problems CVS doesn't
> handle at all.  Another way to say that is when you hit those problems
> BK is much much less complex that CVS.  For example, a simple file
> rename is a nightmare in CVS and a non-issue in BK, it just propogates.
>=20

I meant as far as styles of development.  Yes, CVS can cause some headaches
if used improperly, and some shortcomings are either excused or hacked
over.  However for small projects or projects with a group of close-knit
developers BK is considerably more complex to setup and use.  A lot of the
"problems" that BK solves are either not required for smaller projects or
are second nature to those experienced in using CVS.

Yes, I see the immediate benefits of being able to clone a repository and
do local development, pulling in updates or pushing changes mainstream
where appropiate.  Fortunately, I have Arch to study for this, which I have
to say I'm much more comfortable working with.  Yes, I've used BK in the
past (for the PPC tree), but it's been about 2 years so maybe it's improved
since then?

> If you want to eliminate learning "bk mv foo.c bar.c", just don't do
> that and all of that complexity is never used.
>=20
> I'll be the first to admit that BK is a big system, but it's no more
> complex than CVS if you limit yourself to CVS-like operations.  And=20
> when you go beyond those limits, then BK becomes less complex to the
> user just as CVS is starting to fall over.  Or am I missing something?
> Have you read http://www.bitkeeper.com/cvs2bk.html ?  That covers the
> translation.

Right, but CVS-like operations in BK currently won't allow me to do drop-in
trees.  It's not so much a complexity of use issue as it's an issue of how
things are implemented or done in CVS vs. BK.  Because of its simplistic
view of repositories and how to work with them, CVS wins with small, finely
cultivated (excuse the lack of a better term) trees, whereas BK's complex
view of repositories does not.

I'm not trying to argue as to which is better, I'm just trying to make the
point that I think it's better to use whatever tool is best suited for the
task.  Preaching the benefits of BK over CVS makes no sense when the
desired features aren't there or usuable, so unfortunately your blanket
statements of "BK is a superset of CVS" don't do me any good.  Hopefully th=
is
will filter up to the kernel backend/subsystem maintainers before we see mo=
re
drop-in trees needlessly turning into BK repositories.

One of the listed BK features is being able to collaborate with other folks
who've cloned a repository - are the backend/subsystem maintainers even
doing this?  Is there any collaboration going on between say, the Linux/ARM
and USB BK repositories?  Or is the plan to let things get sorted out when
changes are pushed straight to Linus?  Any maintainers want to comment on t=
he
usefulness (or lack thereof) of BK for maintaining a kernel port (anybody
except Larry)?  Is the fact that syncing with Linus has become
significantly easier the sole reason that BK has become so widespread?

M. R.

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vODtaK6pP/GNw0URAvEmAJ932kwsx+40bFu6Se+NFLFcDhwPFACfZKFj
vPqAysYNmaG53GoWOZ2BiXQ=
=hOzO
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
