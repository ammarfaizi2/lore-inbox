Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUH0U1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUH0U1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUH0UNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:13:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10702 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267505AbUH0UGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:06:07 -0400
Message-Id: <200408261812.i7QICW8r002679@localhost.localdomain>
To: Hans Reiser <reiser@namesys.com>
cc: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Thu, 26 Aug 2004 01:31:34 MST." <412D9FE6.9050307@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 26 Aug 2004 14:12:32 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> Andrew Morton wrote:

[...]

> > The fact that one filesystem will offer features which other
> > filesystems do not and cannot offer makes me queasy for some reason.

Not me. As long as it is clearly experimental stuff that can be removed at
the head hacker's whim, that is. 2.7 material.

> Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem 
> for Apple,

Says who?

>            and that means we need to put search engine and database 
> functionality into the filesystem.

Please don't. Unix works and is extremely popular because it _doesn't_ try
to be smart (policy vs mechanism distinction, simple abstractions that can
be combined endlessly). If you add this to the filesystems, you either redo
_all_ userland to understand _one_ particular way of doing "smart things"
(which will turn out to be almost exactly the dumbest possible for some
uses, and then you are stuck), or get lots of shards from broken apps (and
users, and sysadmins).

>                                     It takes 11 years of serious 
> research to build a clean storage layer able to handle doing that.  

Great! Build an experimental OS showing how to use it, and through that see
if the ideas hold any water _in real, day-to-day, down-to-earth, practice_.

> Reiser4 has done that, finally.  None of the other Linux filesystems 
> have.

How come nobody before you in the almost 30 years of Unix has ever seen the
need for this indispensable feature?

>        The next major release of ReiserFS is going to be bursting with 
> semantic enhancements, because the prerequisites for them are in place 
> now.  None of the other Linux filesystems have those prerequisites.  

To me that would mean that ReiserFS has no place in Linux.

> They won't be able to keep up with the semantic enhancements.  This 
> metafiles and file-directories stuff is actually fairly trivial stuff.

Maybe. But the question of it being of any use aren't trivially answered
"yes". My gut feeling is that the answer is a resounding "no", but that's
just me. Direcories are directories, if you want to ship directory-like
stuff around, use directories (or tarfiles, or whatever). Just look what
happened to the much, much easier stuff of splitting SUID/SGID into
capabilities: Nothing at all whatsoever, because they have no decent place
to stay in the hallowed Unix APIs. Sure, Linux is now large enough to be
able to _define_ APIs to follow, but even so it isn't at all easy to do so.

> Look guys, in 1993 I anticipated the battle would be here, and I build 
> the foundation for a defensive tower right at the spot MS and Apple are 
> now maneuvering towards.

Why place a protective tower around the pit into which they are trying
desperately to throw themselves? ;-)

>                           Help me get the next level on the tower before 
> they get here.  It is one hell of a foundation, they won't be able to 
> shake it, their trees are not as powerful.  Don't move reiser4 into vfs, 
> use reiser4 as the vfs.  Don't write filesystems, write file plugins and 
> disk format plugins and all the other kinds of plugins, and you won't be 
> missing any expressive power that you really want....

Better write libraries handling whatever weird format you have in mind for
each use. Even applications. I don't expect to be able to use emacs to edit
a JPEG or PostgreSQL database. Neither do I expect gimp to be able to edit
a poem. The current trend (which I heartily agree with) is to take stuff
_out_ of the kernel (for flexibility, access, development ease, even
performance).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
