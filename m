Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFZE2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFZE2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFZE2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 00:28:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8596 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261514AbVFZE1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 00:27:54 -0400
Message-Id: <200506260401.j5Q41iR4024249@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Fri, 24 Jun 2005 23:10:35 EST." <42BCD93B.7030608@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 26 Jun 2005 00:01:39 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Horst von Brand wrote:
> > David Masover <ninja@slaphack.com> wrote:
> >>Horst von Brand wrote:
> >>>David Masover <ninja@slaphack.com> wrote:
> >>>>Hans Reiser wrote:
> >>>>>Jeff Garzik wrote:

[...]

> >>"Ain't broke" is the battle cry of stagnation.

> > I see it as the battle cry of those that are looking for /real/
> > problems to solve.

> I'll refer you to my other rant about stagnation and oil.

Read it. Makes no sense, wind and solar power have their /own/ problems,
environmentally speaking. Besides, as things stand today, they are *extremely*
expnsive and hard to use, so next to useless (for now).

> And, listen to yourself.  "Good riddance, no, I don't use DOS" but
> "Ain't broke is the battle cry of those looking for real problems to solve."

> You can solve real problems in DOS,

Sure. But not all (or even most) problems I'd like to solve with a computer
as of today. So...

>                                     it's usable, it ain't broke, there
> are even some decent games (doom) and windowing systems (win3.1 and
> others) for it.

Sure. But that's not enough.

> But Linux is better.  DOS ain't broke,

For me, it is.

>                                        but Linux is better.  So maybe
> VFS ain't broke,

I think it is doing fine.

>                  but plugins would be better.

Maybe. It's up to /you/ to convince the head kernel hackers (and me on the
way).

>                                                I guess we'll only know
> if we let Reiser4 merge...

No. Just like devfs was "the obvious right way", it /had/ to be merged
ASAP, "wrinkles will be ironed out later". Turned out it wasn't wrinkles,
but fundamental brokenness, and it was soon abandoned by the people who
promised to maintain it forever. And now we have the flamewar about its
removal...

> >>But, there are some things Reiser does better and faster than ext3,

> > Yes, I've heard it is supposed to be faster on huge directories, and
> > doesn't run out of inodes. And it is more efficient spacewise on small
> > files. But then again, space is extremely cheap today...

> Speed isn't.  CPU is, but not disk speed.  And packing stuff more
> efficiently, without actually compressing it, will give you some of that
> speed.

For my current uses, ext3 is plenty fast enough. No pressing need to change.

> Also, space is not so cheap that I won't take 25% more.

It is cheap enough that I can't realistically fill the disks I have with
/usefull/ stuff. So...

> > And again, on a list around here I've seen several cries for help with
> > completely hosed filesystems, all ReiserFS. No solution has ever come
> > forth.

> I haven't been counting, but I've seen a number of solutions fly around
> reiserfs-list for people with reiser4 problems.

It was ReiserFS 3. Maybe the problems are fixed now, but as they say about
burned children...
[...]

> A lot of what people like about ext3 is its stability and fairly
> universally accepted format.  A lot of what people like about XFS is its
> stability and speed, mainly with large files.  A lot of what people like
> about Reiser4 (as it is today) is its speed, with large and especially
> with small files.

Right. And mushing it all together is way more likely to combine all /bad/
features than to retain some of the /good/ ones.

> Those are broad and somewhat uneducated statements, but I doubt most
> people care what FS they are using if the stability and performance is
> what they want.  In that case, why have so much duplicated effort
> between different filesystems -- even between ISO and UDF and Reiser and
> XFS -- when most of what's really different is the on-disk format and
> the optimization?

Because they are different on-disk and are optimized for different uses,
perhaps? I can't use ext3 for reading my CDs, I need NTFS to access the
Windows partition here, ...

> So, in this hypothetical situation where ext3 is a reiser4 plugin,
> suddenly all the ext3 developers are trying to improve the speed and
> reliability of reiser4, which benefits both ext3 and reiser4, instead of
> just ext3.

I guess that it won't ever turn out to be that simple. ext3 developers will
have to consider not screwing up XFS, etc. And I don't see any real
difference there from where we stand today... just a bigger mess: VFS with
ReiserFS with plugins for ext3, instead of VFS with ext3. No gain, much
pain.

[...]

> > And that would surely break Windows compatibility (because you have to keep
> > the data on what to encrypt one the filesystem itself). Besides, having

> Aside from what someone else already said about this, why not just have
> support for accessing, say, a .gpg file as transparently decrypted?

That should, if anything, be a /user/ decision, not a /kernel/ one. Even
sometimes decrypt, sometimes don't.

>                                                                      You
> don't even need file-as-directory, just create a file called foo which
> is really the decrypted version of foo.gpg.  No need to change the
> format, just the filesystem.

No need to change the filesystem, learn to use the tools at hand.

> > pgp, or gpg, or crypt, or my own whacky encryption proggie do the job in
> > /userland/, and not shoving into the kernel and so down the next user's
> > throat, is in the end a largeish part of what Unix is all about for me.

> Do you use ipv6?

Sometimes.

>                   I don't.  And it's not shoved down my throat, either,
> although it's in the kernel.  I simply disable it, and you would (I'm
> sure) disable the crypto stuff.

An Internet standard is a quite different kettle of fish than the pet
experimental filesystem for a minority operating system...

> Plus, as someone else said, it's much easier to do
> $ vim /some/encrypted/file
> than
> $ gpg --decrypt /some/encrypted/file > /some/decrypted/file
> $ vim /some/decrypted/file
> $ gpg --encrypt /some/decrypted/file > /some/encrypted/file
> $ shred /some/decrypted/file

So what? Write your script to do it. Or use emacs, I'm sure it either has
now or will soon have a plugin for it... much easier to develop, much more
flexible to use, ...

> Not to mention, shred doesn't work on modern filesystems, so you need to
> either patch vim (and any other program you might want to use), create
> an actual ramdisk, or deactivate swap and mount a tmpfs.

Right. And all this complex futzing around (and making sure the unencrypted
data doesn't remain if the power is cut in the right moment, and...)

> On doing stuff in userland:  I am all for moving tons of stuff to
> userland, but not until someone does a microkernel right, if it's even
> possible.  And even then, I'd probably still use Linux and argue for
> some stuff in the kernel, because Linux has developers.  Developers.
> Developers.  Developers.

Sorry, I don't buy this. Linux (the kernel) has tons of developers. But
that doesn't mean everybody is interested in everything. Just like there
are probably much more userland developers (for one, it is /much/ easier to
work with...), and there not everybody is interested in everything. Putting
stuff in the kernel that doesn't belong there (== can't be done elsewhere)
is useless bloat.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

