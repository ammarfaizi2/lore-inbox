Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVGDUgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVGDUgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGDUgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 16:36:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39608 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261637AbVGDUfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 16:35:50 -0400
Message-Id: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, David Weinehall <tao@acc.umu.se>,
       =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Douglas McNaught <doug@mcnaught.org>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Mon, 04 Jul 2005 13:47:32 EST." <42C98444.5090909@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 04 Jul 2005 16:32:43 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 04 Jul 2005 16:32:15 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Horst von Brand wrote:
> > David Masover <ninja@slaphack.com> wrote:
> >>David Weinehall wrote:
> >>>On Fri, Jul 01, 2005 at 03:08:58AM -0500, David Masover wrote:
> >>>>David Weinehall wrote:

[...]

> >>Even if they don't, it would be more beneficial to me

> > How, exactly?

> Go back and read.

I have. And have seen /no/ benefit to you. Except, of course, the benefit
accrued from some magic in Linus' kernel, by which all format differences
go in a puff of smoke if they are implemented inside it, and furthermore
all userland gets rebuilt to use the kernel's way overnight.

Sorry, I'm quite sceptical on this count. Sure, for complete outsiders it
may look that way: Something gets implemented in the kernel, soon many
applications are using it, everything is peachy. Except that before there
have been /long/ (even bitter) discussions on if/how to do it, what the
kernel should do (if anything) and what the application's responsibility
should be. Many times it has ended with Linus slamming on the table and
saying "no way", or "we do it /this/ way". Then, /when/ this is clear, it
gets into the kernel and applications. And you only have ever seen the last
phase... which is smooth and fast.

Here, the "how should it be done, if at all" discussion has barely started.
And AFAICS there are plenty of ways of getting 95% of the advantages
/without/ touching the kernel, so that should be the path to follow. Nobody
has shown any real evidence at all for this not being so.

> > Besides, /your/ convenience isn't the only thing that matters...

> Nor yours.

Sure enough.

>            Just because you can't get your mind around a concept
> doesn't mean that it's a bad concept, and that no one else can use it.

I /do/ get my mind around the concept, it /is/ sometimes useful. It /can/
be done without the kernel, and so /should/ be done that way. That is all.

> >>                                                      and probably
> >>most Linux users

> > "Most Linux users" don't use experimental filesystems at all...

> Actually, they do -- ext3 was experimental once.

Right. And ext2, and ext, and xiafs, and ... So? When they were
experimental, only a handful of utter fools commited their data to them.

>                                                   ReiserFS was very
> experimental once.

See above.

> Please stop bashing it just because it's new/experimental.

Sorry?

> >>                 to have metafs supported in both GNOME and KDE, even
> >>if they still need an emulation layer to support other systems.
> > So Gnome and KDE get larger (and thus slower) for everybody.

> Smaller (and thus faster) on supported systems,

Sorry, but just because some $DISTRO gives ReiserFS4 as an /option/ doesn't
mean they will have everything duplicated as "For ReiserFS4" and "For other
filesystems". My assertion stands, until there are ReiserFS4-only
distributions.

>                                                 otherwise exactly the
> same, but maybe a little more modular, which is good.

Right, having to cope with different ways of representing metadata could
induce better code organization. But to get there isn't painless either...

> > Besides, Gnome
> > and KDE will have to agree on the formats involved first, which is /exactly/
> > what is supposed to be impossible unless this stuff is implemented in the
> > kernel...

> I never said that,

You (and others) have told us time and again that each of them have their
own incompatible ways of handling metadata, and that only if this was
handled in the kernel they would make use of a common way of managing it...

>                    but for one thing, whether they do or not, it's
> nice if my shell and my editor and all the other things that I use
> don't have to agree on anything to manipulate the formats involved.

Please, read what you just said. Everybody (kernel somewhat included) will
have to agree on the format of the metadata.

> This is not just about GNOME/KDE.  It is about GNOME/KDE not developing
> an additional layer, that you wouldn't like anyway,

How do you know what I would or would not like?

>                                                     that cannot be
> accessed from anything except GNOME/KDE.

So Gnome and KDE agree on some secret formats that only they can handle?
Behind their user's backs? As open source? And happily shoot their feet by
not giving users much wanted access to said data in decent ways?

I see it more on the lines of libmetadata.so (or such), which is used by
Gnome, KDE, and whatever else wishes to do so. Even your custom-tailored
shell or cat(1). Or just some convention that metadata on ~/my/funky/file
resides in ~/.metadata/.my/.funky/.file/metadata. Hey, you could (almost)
do that today, by wrappers (perhaps even aliases, or shell functions)
around the relevant commands! No kernel at all involved! Not even a
miserable library!!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

