Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVGEWdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVGEWdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGEWdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:33:07 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:28432 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261908AbVGEWcA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:32:00 -0400
Message-ID: <42CB0A40.3070903@slaphack.com>
Date: Tue, 05 Jul 2005 17:31:28 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: David Weinehall <tao@acc.umu.se>,
       =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>,
       Douglas McNaught <doug@mcnaught.org>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl>
In-Reply-To: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
>>Horst von Brand wrote:
>>
>>>David Masover <ninja@slaphack.com> wrote:
>>>
>>>>David Weinehall wrote:
>>>>
>>>>>On Fri, Jul 01, 2005 at 03:08:58AM -0500, David Masover wrote:
>>>>>
>>>>>>David Weinehall wrote:
> 
> 
> [...]
> 
> 
>>>>Even if they don't, it would be more beneficial to me
> 
> 
>>>How, exactly?
> 
> 
>>Go back and read.
> 
> 
> I have. And have seen /no/ benefit to you. Except, of course, the benefit
> accrued from some magic in Linus' kernel, by which all format differences
> go in a puff of smoke if they are implemented inside it, and furthermore
> all userland gets rebuilt to use the kernel's way overnight.

Let's say cryptocompress gets implemented.  Not all of userland
rewritten, not even any of userland rewritten, just a cryptocompress
plugin for the kernel.  And instead of having to learn a new tool, I can
just browse around in /meta.

Yes, all of userland gets rebuilt, and the world is better for it.  But
*incrementally*.  Not overnight.

> Here, the "how should it be done, if at all" discussion has barely started.
> And AFAICS there are plenty of ways of getting 95% of the advantages
> /without/ touching the kernel,

Which advantages can we get without touching the kernel?

And why does it make sense to do them outside the kernel?  "Because we
can" is a little HURD-ish...

> so that should be the path to follow. Nobody
> has shown any real evidence at all for this not being so.

Go back and read again.

>>           Just because you can't get your mind around a concept
>>doesn't mean that it's a bad concept, and that no one else can use it.
> 
> 
> I /do/ get my mind around the concept, it /is/ sometimes useful. It /can/
> be done without the kernel,

No, it can't.  Unless you patch *all* of userland.

> and so /should/ be done that way. That is all.

I'll refer you to my HURD comment:

Just about anything done currently in the kernel can be done in
userland.  Witness HURD.

Doesn't mean it should.  Witness HURD.

>>>>                                                     and probably
>>>>most Linux users
> 
> 
>>>"Most Linux users" don't use experimental filesystems at all...
> 
> 
>>Actually, they do -- ext3 was experimental once.
> 
> 
> Right. And ext2, and ext, and xiafs, and ... So? When they were
> experimental, only a handful of utter fools commited their data to them.

But, they had to start somewhere.  You seem hell-bent on keeping
anything "unproven" out of the kernel and away from users.  How do you
suggest it "prove" itself, then?

>>>>                to have metafs supported in both GNOME and KDE, even
>>>>if they still need an emulation layer to support other systems.
>>>
>>>So Gnome and KDE get larger (and thus slower) for everybody.
> 
> 
>>Smaller (and thus faster) on supported systems,
> 
> 
> Sorry, but just because some $DISTRO gives ReiserFS4 as an /option/ doesn't
> mean they will have everything duplicated as "For ReiserFS4" and "For other
> filesystems". My assertion stands, until there are ReiserFS4-only
> distributions.

Why not?  The "For Reiser4" version is just a thin layer on top of metafs.

And after all, metafs can be implemented for other filesystems.

And, as someone else pointed out, dealing with different systems doing
things in different ways is what portability is all about.

>>>Besides, Gnome
>>>and KDE will have to agree on the formats involved first, which is /exactly/
>>>what is supposed to be impossible unless this stuff is implemented in the
>>>kernel...
> 
> 
>>I never said that,
> 
> 
> You (and others)

Others, then.

> have told us time and again that each of them have their
> own incompatible ways of handling metadata, and that only if this was
> handled in the kernel they would make use of a common way of managing it...

All I ever said was that it would be easier for them to get along, and
certainly *much* easier to use existing tools (the commandline) to poke
inside the metadata, whether it's compatible or not.

Ultimately, maybe it leads to cooperation, maybe not.  But there are
immediate benefits even if it doesn't lead to cooperation.

>>                   but for one thing, whether they do or not, it's
>>nice if my shell and my editor and all the other things that I use
>>don't have to agree on anything to manipulate the formats involved.
> 
> 
> Please, read what you just said. Everybody (kernel somewhat included) will
> have to agree on the format of the metadata.
> 
> 
>>This is not just about GNOME/KDE.  It is about GNOME/KDE not developing
>>an additional layer, that you wouldn't like anyway,
> 
> 
> How do you know what I would or would not like?

Maybe I was generalizing "you".  Others don't like Reiser4 as it is
because it's got "layering violations".  GNOME/KDE developing their own
VFS on top of the kernel's for no good reason is a layering violation.

Am I misunderstanding?

>>                                                    that cannot be
>>accessed from anything except GNOME/KDE.
> 
> 
> So Gnome and KDE agree on some secret formats that only they can handle?
> Behind their user's backs? As open source? And happily shoot their feet by
> not giving users much wanted access to said data in decent ways?

Not "secret", but not easy to get at, unless everything links against
libmetadata.so or reimplements it.

> I see it more on the lines of libmetadata.so (or such), which is used by
> Gnome, KDE, and whatever else wishes to do so. Even your custom-tailored
> shell or cat(1). Or just some convention that metadata on ~/my/funky/file
> resides in ~/.metadata/.my/.funky/.file/metadata. Hey, you could (almost)
> do that today, by wrappers (perhaps even aliases, or shell functions)
> around the relevant commands! No kernel at all involved! Not even a
> miserable library!!

Maybe.  Then again, maybe not.

GNOME, at least, likes XML-based systems.  XML is much, much harder for
me to deal with from the shell, and certainly doesn't lend itself to as
easy scripting.

Now, we could tell the GNOME people to make sure to use plain old text
files / images everywhere, and make sure everything works for the shell
-- and then, on filesystems where small files don't pack so well, you
end up taking 10x more space for your metadata, and it's slower for
GNOME to manage.

Or, we implement /meta.  Now I can get to individual bits of metadata
from the shell, but GNOME can still use its XML format, or a db
database, or some database-like system call like the proposed
sys_reiser4 even.  It doesn't matter so much anymore how they store
metadata, but it becomes easier to access it without having to link
against some magic library.

