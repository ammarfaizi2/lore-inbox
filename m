Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVFXNLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVFXNLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVFXNLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:11:01 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:61628 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262466AbVFXNJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:09:42 -0400
Message-Id: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Thu, 23 Jun 2005 17:04:25 EST." <42BB31E9.50805@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 23 Jun 2005 22:41:01 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 24 Jun 2005 09:08:53 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Horst von Brand wrote:
> > David Masover <ninja@slaphack.com> wrote:
> >>Hans Reiser wrote:
> >>>Jeff Garzik wrote:

> > [...]

> >>>You missed his point.  He is saying ext3 code should migrate towards
> >>>becoming reiser4 plugins, and reiser4 should be merged now so that the
> >>>migration can get started.

> >>Sort of.
> >>
> >>I think ext3 would be nice as a reiser4 plugin.

> > What for? It works just fine as it stands, AFAICS.

> So does DOS.

I'm sorry?

>              Do you use DOS?

Good riddance, no! Not for something like 15 years.

>                               I don't even use DOS to run DOS programs.

Haven't seen one in quite some time, to be honest. Oops, sorry, I just
lied. Booted it from floppy to run a program to whack the BIOS password on
a PC some two weeks ago. Only use in a long time.

> "Ain't broke" is the battle cry of stagnation.

I see it as the battle cry of those that are looking for /real/ problems to
solve.

> But, there are some things Reiser does better and faster than ext3,

Yes, I've heard it is supposed to be faster on huge directories, and
doesn't run out of inodes. And it is more efficient spacewise on small
files. But then again, space is extremely cheap today...

And again, on a list around here I've seen several cries for help with
completely hosed filesystems, all ReiserFS. No solution has ever come
forth.

>                                                                     even
> if you don't count file-as-directory and other toys.  There's nothing
> ext3 does better than Reiser, unless you count the compatibility with
> random bootloaders and low-level tools.

For me, those are quite critical...

> >>                                                Not everyone will want
> >>to reformat at once, but as the reiser4 code matures and proves itself
> >>(even more than it already has),

> > I for one have seen mainly people with wild claims that it will make their
> > machines much faster, and coming back later asking how they can recover
> > their thrashed partitions...

> You know how many I've had thrashed on Reiser4?  Two.  The first one was
> with a VERY early alpha/beta, and the second one was when I dropped a
> laptop and the disk failed.

OK. Know how many I thrashed with ext2/3? I remember 3, could have been as
many as 5. One was due to a failed disk, another one because of DMA to a
disk causing slow corruption. Another one I believe was due to a odd kernel
compiled with a snapshot gcc a long time back, plus power loss at the wrong
time. And that is from using ext2/3 since they were in early beta. On
several machines at the same time, over years. I'd have to say that there
isn't much of a difference.

> And it does make certain things faster.  For one thing, "emerge sync" on
> Gentoo is twice to four times as fast, and /usr/portage is 75% as big,
> as on ReiserFS (3).

That can't all be due to on-disk format.

> >>                                 the ext3 people may find themselves
> >>wanting some of the more generic optimizations.

> > They'll filch them in due time, don't worry.

> Duplication of effort.  With plugins, we can optimize the upper layers
> of ALL filesystems, regardless of the lower layers, in such a way that
> it is optional.

Generic optimizations how, if they need VFS support?!

>                  I'm sure it's far easier to write a Reiser storage
> plugin than a brand new FS.

Comparing apples and oranges tells you what?

> Eventually, once competition is only based on storage format, we could
> end up with just one format.  Just one filesystem!  (except for
> fat/ntfs/iso/udf/network...)  And in the open source world, sometimes a
> single product is a good thing.

Sorry, I don't think this will come to pass in our lifetime, if ever. There
are different requirements, and the way to cater to them is different
solutions. That has always been what Linux (as opposed to the propietary
and even some open source systems) is all about...

> >>But, I don't think that will realistically happen at all.

> >>Instead, what will probably happen is that once Reiser4 is in the
> >>mainstream kernel, it will become more popular and noticable.  Other
> >>FSes will take note.  ext3 people may decide they want
> >>file-as-directory,

> > That idea is even much older than Linux itself, and no other (Unix)
> > filesystem has implemented it. Ever. Wonder why...

> >>                   and vfat people may decide they want cryptocompress,

> > I'm sure they don't, because it is mostly for Windows and assorted devices
> > (pendrives, digital cameras, ...) compatibility.

> I, for one, would like to use a pendrive and have certain files be
> encrypted transparently, only for use on Linux, but others be ready to
> transfer to a Windows box.

And that would surely break Windows compatibility (because you have to keep
the data on what to encrypt one the filesystem itself). Besides, having
pgp, or gpg, or crypt, or my own whacky encryption proggie do the job in
/userland/, and not shoving into the kernel and so down the next user's
throat, is in the end a largeish part of what Unix is all about for me.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
