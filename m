Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUH0Ujz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUH0Ujz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUH0Uje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:39:34 -0400
Received: from nysv.org ([213.157.66.145]:21667 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S267538AbUH0Udw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:33:52 -0400
Date: Fri, 27 Aug 2004 23:32:16 +0300
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827203216.GC1284@nysv.org>
References: <412D9FE6.9050307@namesys.com> <200408261812.i7QICW8r002679@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408261812.i7QICW8r002679@localhost.localdomain>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:12:32PM -0400, Horst von Brand wrote:

>> Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem 
>> for Apple,
>Says who?

People will say it when people stop using Linux on servers because
they can integrate metadata easier in other operating systems ;)

>Please don't. Unix works and is extremely popular because it _doesn't_ try
>to be smart (policy vs mechanism distinction, simple abstractions that can
>be combined endlessly). If you add this to the filesystems, you either redo

Just more moving little pieces to be combined endlessly.

I think it looks like Reiser4 semantics should go into VFS and not break
legacy posix compatibility.

If you don't want to use a filesystem like that, don't.
Maybe the reason Linux hasn't developed this yet is the fact that Linux
supports n+1 file systems and above and beyond that many userspace ones.
So there has been enough work in maintaining and competing the old
ones and not coming up with new ones.

>_all_ userland to understand _one_ particular way of doing "smart things"
>(which will turn out to be almost exactly the dumbest possible for some
>uses, and then you are stuck), or get lots of shards from broken apps (and
>users, and sysadmins).

This is a question if implementation.

What if the files-as-dirs have a ..metas/mainstream[1] file and are handled
by legacy applications as directories? Nothing breaks, but may look a bit
ugly. Nothing one line of shell scripting would not cure.

OTOH, the user space progs are quickly patched to support all this.

>Great! Build an experimental OS showing how to use it, and through that see
>if the ideas hold any water _in real, day-to-day, down-to-earth, practice_.

Why should he?

Parts of Linux are already here and susceptible to experiments in
evolution. (Break out 2.7 for this one, the people want code! :)

>How come nobody before you in the almost 30 years of Unix has ever seen the
>need for this indispensable feature?

Lack of imagination?
Lack of need?
Lack of drive space?

And maybe someone did think among these lines back in the days, it's
not like the current dogma of file systems is the only one that has
ever been used.

>To me that would mean that ReiserFS has no place in Linux.

This is the type of argumentation I can not understand.
Do you not have the freedom not to use it?

And this is not personal, but please say Reiser4, as ReiserFS is coupled
with versions 3.x. They are quite different.

>Maybe. But the question of it being of any use aren't trivially answered
>"yes". My gut feeling is that the answer is a resounding "no", but that's

I think it's a pretty big yes, even if the technical details do need to
be clear before anything is set in stone. That's the reason for the
on-going discussion.

>just me. Direcories are directories, if you want to ship directory-like
>stuff around, use directories (or tarfiles, or whatever). Just look what

Without a common user-space API to deal in them. Oh, joy.
Make the common user-space API? Will never happen.

>Better write libraries handling whatever weird format you have in mind for
>each use. Even applications. I don't expect to be able to use emacs to edit
>a JPEG or PostgreSQL database. Neither do I expect gimp to be able to edit
>a poem. The current trend (which I heartily agree with) is to take stuff
>_out_ of the kernel (for flexibility, access, development ease, even
>performance).

I don't think anyone's talking about using emacs to edit a picture, but
emacs could be used to edit the picture's description.[2]
Maybe with some userspace-hook that exports the exif data via ..metas/
so the kernel won't have to parse it.

Linus wrote about why TCP is not in userspace and I think this is a similar
situation. Technically. But not everything has to be in kernel space
in Reiser4. Or that's what they say and I'm not sure where I stand on
an exif parser in the kernel...

On the social side, I may be wrong in this, but not many userspace 
filesystems have the possibility of becoming a de-facto standard. One 
might say that's because they suck, or they suck because they're 
implemented in userspace or they are just met with prejudice
for the same reason.

In the kernel something like this would have to be done right and people
would put effort into doing it right.

I for one would welcome that.

[1] Sorry, guys, just had to use that name..
[2] You can edit a picture in emacs already, it's just prone to break ;)

-- 
mjt

