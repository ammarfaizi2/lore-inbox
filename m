Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314081AbSDQNwT>; Wed, 17 Apr 2002 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSDQNwT>; Wed, 17 Apr 2002 09:52:19 -0400
Received: from adsl-64-109-202-37.dsl.milwwi.ameritech.net ([64.109.202.37]:41715
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S314081AbSDQNwR>; Wed, 17 Apr 2002 09:52:17 -0400
Date: Wed, 17 Apr 2002 08:52:15 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Larry McVoy <lm@work.bitmover.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020417135215.GA7814@0xd6.org>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com> <20020417024149.GC5897@0xd6.org> <20020416203721.B27525@work.bitmover.com> <20020417050412.GD5897@0xd6.org> <20020416230355.I27525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Larry McVoy <lm@bitmover.com> on Tue, Apr 16, 2002:

> On Wed, Apr 17, 2002 at 12:04:12AM -0500, M. R. Brown wrote:
> > Not sure I follow here, you're a bit vague about "doing the same thing".
> > Do you mean syncing from the mainline kernel? =20
>=20
> Syncing from the main kernel, synching from someone else, syncing with=20
> a coworker, whatever.  It doesn't really matter.  With the limitation=20
> that BK wants you to eat everything that the other guy has that you don't,
> it all just works.  And you can sync from N different places all of which
> happened to have the same patch in the same changeset, and it gets applied
> once, BK knows it has it already.
>=20
> BK isn't perfect, but you are looking at it through CVS colored glasses.
> Take 'em off, it's got some stuff that will save you time and effort.
>=20

That's cool.  That's what should be in a SCM.  I guess we may have a
misunderstanding where I say "drop-in tree" and you assume I mean using CVS
to tag and branch a subset of the kernel source?  The drop-in tree is what I
described in my initial response to you so many posts ago.  It doesn't have
to be specifically tied to a CVS-centric mode of development, but before so=
me
of the other SCMs came into fruition, CVS was the easiest (or most popular
if you insist it wasn't easy) way to do it.  Now we have advanced SCMs
available, and I hope to use one that will still support drop-in trees
while allowing me access to all the whizbang features that will make my
life easier.

> > For the LinuxSH project, we moved from tracking the full kernel tree (v=
ia
> > CVS) to a drop-in tree structure mainly because of the difficulty in
> > tracking all upstream kernel changes at once.  It wasn't really related=
 to
> > what CVS did or did not offer.
>=20
> Disagree.  CVS sucks at tracking an external source of change while
> maintaining your own changes at the same time, in the same tree.
> It really sucks at that, you are forced into a broken branching model
> with awful merge characteristics.  Try the same thing with BK, it's
> a lot nicer, most stuff just automerges, and the stuff that doesn't
> only needs to be merged once.  Your claim that it isn't about CVS
> doesn't make much sense when CVS forces you to split your subtree
> out.  Having an _option_ to do that is one thing, being forced to
> do it is another.
>=20

I'd hate to sound like I'm trolling or being a broken record.  But I don't
currently have that option with BK.  This is the option I want, to be able
to not have to worry about pulling all changes or being able to cordon off
only the bit I want/need to work with.  See the above as to why CVS isn't
just the means, it's just the tool currently used for drop-in maintenance.
Give me proper drop-in support using BK (or any other modern SCM tool), and
I'm sold.

> > I never said anything about working in isolation in any of my posts.  A
> > drop-in tree is only usable when "dropped in" or symlinked on top of a =
full
> > kernel tree. =20
>=20
> And if that tree has changes in the files that you are "dropping in"?
> You just stomped on them.  Or you are left with an even more broken
> merge model than CVS.  And what about file renames.
>=20

When my drop-in tree file changes upstream, I'll find out in the next
upstream sync.  Obviously if my drop-in tree is current, that file hasn't
changed yet.  File renames are broken, but I never pretended they weren't. =
 I
guess what you're saying is it comes down to me weighing out feature-rich
set vs. feature-less set, where BK is the former, and I should expect to ha=
ve
to sacrifice my entire development model (drop-in trees, not CVS) for the
bloated model that BK currently *enforces* (see your above paragraph about
having the option).

> > Also, the size of a drop-in tree is a side effect of its composition, it
> > was used to illustrate the benefit of the simplicity of drop-in trees -=
 if
> > you recall the introductory paragraph of my original reply to yours, I =
said
> > that drop-in trees are most useful for kernel subsystems and backend
> > (architecture) ports. =20
>=20
> Agreed.  We're headed towards breaking up the kernel tree into
> subrepositories for that reason.
>=20

This was already being done with the satellite projects and drop-in
trees, but didn't have the benefit of being SCM-controlled *globally*.  I'd
very much like to see this happen.  Was there any timeframe on this or
should I just start searching lkml archives?

>=20
> > So, splitting trees in BK.  Do you mean by using native BK commands, or=
 by
> > planning ahead and using multiple repositories?  Perhaps when you've
> > finished flaming me and defaming CVS you can give me a valid response a=
s to
> > how one would maintain a drop-in tree using BK. =20
>=20
> Perhaps when you have finished flaming me, you can go use the tool, read
> the docs, and learn what it can do.  Part of the problem I have is that
> you are, in a public forum, saying that BK is this and that, based on your
> perceptions from 2 years ago when you said you used it on the ppc tree.
> I can't imagine that you used it very much, because there is not a
> single changeset in the tree with your login on it.  So maybe you are
> making your comments based on a 2 year old reading of the docs, rather
> than actually using it.  That is pretty annoying and a waste of time.
> Go learn the tool, if you want an education, then buy some training.
>=20

Nope, I said that based on what I read at www.bitkeeper.com, BK didn't
support drop-in trees *today*.  I said that the last time I actively used
the tool was 2 years ago, but I haven't had a reason to use it since then.
In a public forum, which you use to promote sales and use of your product, I
stated quite simply and plainly that BK won't allow me to do drop-in trees,
with the simplicity of CVS.  Even using a full kernel source tree as CVS
HEAD and branching subsets of HEAD into small drop-in like branches does
what I need to do in CVS.  This is even before you start worrying about
automerging and file renaming - I can't do the above using BK - for kernel
development.

Two years ago, or today, BK still doesn't do it, not without requiring
massive structural changes to the master repository by the project owner -
not the satellite maintainers.  This requires a significant amount of
planning ahead and effort from Linus (or whoever ends up doing it), where
using the drop-in tree model that burden is placed on the satellite
maintainer.  When I decide to start and maintain the "linux toaster
driver", I pull out the source I need from mainline, and setup my drop-in
tree from that and my new imports.  The BK way to do it is to simply "clone
the master" and work from that.  Not a drop-in.

I voiced a legitimate concern about why drop-in trees were useful, and why
I wouldn't be able to contiue their development using BK.  You proceeded (f=
or
a couple of posts at least) to dodge that concern with arguments of why CVS
pales in comparison to BK.  That I didn't really care about, and maybe you
should be asking yourself, "If I didn't have the correct answer and I can't
accurately address this guy's concern, why did I bother replying in the fir=
st
place?"

> As for splitting trees, "bk help csetprune".  It not only splits trees,
> it maintains the repository changeset history graph, no small feat.
> But it's a 1-way, 1-time operation, you can't unsplit.  So it's something
> that I suspect will happen when Linus wants it.
>=20
> And you could find this information by
>=20

Right.  We can't do it, only the repository owner can.  By your own
admission the drop-in tree as I described it isn't supported:

"Ahh, OK, we're already working on this.  We call 'em nested repositories
and one of the problems they solve is exactly the problem you described.
Think of them as CVS modules, with a little more formality, and you're
about there.  They also solve a bunch of performance problems."

The "csetprune" command you've pointed me to apparently doesn't do this.

> > You seem to be stuck on "why CVS sucks" while I'm trying to convey "why=
 CVS
> > does what I need it to do" as far as drop-in trees are concerned. =20
>=20
> Except it *doesn't* do what you need it to do.  You proceeded to hand
> wave over the many places where CVS won't work.  You haven't addressed
> either of the two big problems, renames and content changes in the
> upstream tree.  In the 2 months of usage, Linus' tree has seen 1289
> renames, of which 767 where real renames, not deletes.  How does your
> drop in model handle those?  What about content changes that you don't
> have yet, how does it handle that?  In both cases, the answer is "it
> doesn't".  So you are doing work that you don't need to do, by hand.
> That seems misguided when there is a tool that will do that work for
> you.
>=20

Yep, you're correct, except about the handwaving part.  Last I checked, 2.2
was still being maintained, and 2.4 is also being maintained.  Believe it or
not, I have to be bothered with tracking changes between all of these
versions *and* 2.5, and at least the 2.2 variant still needs to be done by
hand.  2.4 and 2.5 are now SCM-controlled by BK.  That's great, and I'm
being serious here.  But it can't cope with the drop-in style, and at this
point I can't be coerced into a new mode of development.  If BK could sanely
handle drop-in trees (the right way), trust me, I'd already be using it.  B=
ut
I'm still forced to do the merging work by hand, if I insist on maintaining
the drop-in tree (without CVS), even if using a BK clone as my source base.

My tool needs to do what I tell it to, not the other way around.

> > conditioned to attack (or belittle) anyone that doesn't accept BK as
> > gospel.  I understand taking pride in your work, but damn!  Take it eas=
y.
>=20
> It's got nothing to do with gospel, it's got everything to do with you
> making claims based on no work on your part, not even recent usage.
> BK isn't anywhere near Linus' definition of the best (i.e., it can't
> get better).  Nowhere near.  But it's quite useful if you figure out
> how to use it.  And we're making better as fast as we can.
>=20

If you were able to propose a sane way to continue using the drop-in model
using BK, then I'd have no problems taking you seriously.  My only claim
was that BK couldn't handle drop-in trees.  I didn't say it sucked overall
as a SCM or that I wanted to protest because it wasn't open.  The "work" was
me perusing the bitkeeper webpage, and going back and forth with you, the g=
uy
I thought would be the most intelligent on all of BK's features.  Are you
saying the only way for me to evaluate a tool (one that I haven't used in
ages) is to use it?  I can't rely on documentation or peer reviews and
comments?  Wouldn't my time be spared if you just told me what it would or
wouldn't support?

> Contrast your comments / homework with Jeff Garzik, just for fun.  BK
> has some limitations he didn't like, so he asked a few polite questions,
> figured out how to work around the limitations, and wrote it up in a
> doc (have you read it?).  His approach has been widely adopted, there
> are at last count around 130 slightly different BK trees sitting on
> bkbits.net. =20
>=20

This?

http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.2/1060.html

It was a good read, and easy to follow, but it still does the opposite of
what I need to do.  I want multiple small project-specific trees, not a
myriad of full kernel trees.  Everything else gave me a good starting point
for doing SCM-controlled kernel development using BK.  Thanks for the
pointer.

> In summary, because I've had enough of this thread, your drop in tree
> is a hack, it doesn't handle even the basics of SCM, and you haven't
> shown how to handle those.  BK has plenty of problems, but it least it
> handles the basics.  What you are doing is like working in a file system
> which makes you edit the raw disk to do renames and/or content merges.

Point taken about the drop-in tree being a hack, when used within the
limitations of CVS.  With a SCM that could do it intelligently, it would be
overly useful, but unfortunately BK can't do it at all (or, it does it in
the complete reverse).

I already have been looking at alternatives to CVS that would allow me to
maintain a master kernel source repository with many satellite "branches" t=
hat
would be equivalent to small drop-in trees for the various kernel ports and
subsystems.  I would also need a reasonable way to do merges between the
satellites and the trunk, and being able to do it locally with cloning would
be a major plus.

I've found that Arch comes the closest to what I need, so I've been "doing
my homework" with it.  When I do run into snags, or when Arch trips over
itself when I'm trying to maintain my satellites at least I do have the sou=
rce
instead of the requirement that I bitch to you about missing functionality.=
  I
suppose for the project I'm working on, once it gets to the point where I
need to grab up to the minute changes, I can be bothered with setting up
either an Arch<->BK gateway or find another means to migrate updates from
the latter.

If BK can gain (intelligent, where satellite maintainers can split, not
just root) drop-in support to where it doesn't make sense for me to use
Arch for Linux kernel projects, I'd start using it (and recommend it) for my
satellite projects immediately.  Again, for me it boils down to using the
best tool for the job.

M. R.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vX4PaK6pP/GNw0URAsjBAJ4jzjS7DgrEQb8ZjasDDGWEDPfSgwCgjC1K
gma90rxglKBQX3vWopvPfaU=
=SQyK
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
