Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUCPT14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUCPT1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:27:21 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50405 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261421AbUCPTT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:19:26 -0500
Message-Id: <200403161919.i2GJJIED007767@eeyore.valparaiso.cl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs 
In-Reply-To: Your message of "Tue, 16 Mar 2004 18:31:47 +0100."
             <20040316173146.GB27046@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 16 Mar 2004 15:19:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> On Tue, 16 March 2004 12:04:30 -0400, Horst von Brand wrote:
> > Chris Friesen <cfriesen@nortelnetworks.com> said:
> > 
> > > I don't see how you win nothing.  I create an overlay filesystem. 
> >  
> > Completely empty is what you get then... and you have to explicitly link in
> > each file. Or everything shows up here.
> 
> Correct.  Is that a problem?

Yes. Use it for a kernel tree (some 18.000 files by now), and do it each
time you mount it.

> > > delete a bunch of files in the overlay and it doesn't show through. 
> > 
> > Next time you mount it, what happens? How do you know the "top files" where
> > deleted, and should not show up? 
> > 
> > What happens if I mount the live 2.6.4 kernel source over a CD containing
> > 2.5.30? What happens to identical files, files that moved, changed files,
> > deleted files? Pray tell, how does the kernel find out which is which?

> What happens if I write to /dev/hda while having my rootfs /dev/hda1?
> Bad things, damn right.  But why would anyone do that?

> Can you tell me what the point behind your examples is?  It escapes
> me.

OK, let's see... I've got a laptop, on CD is the "original" kernel tree, on
HD is my modified stuff. I delete a file (or move it). Then I pack up, go
home. There I start up again. How is the fact that the file is gone recorded?

> > How do you back up a beast like this?
> 
> - Use a really large tape (stupid).

All layers? Urgh...

> - cp /dev/... backup_medium
> - Backup software with a clue about the underlying fs.

Another special, non-POSIX piece that needs to be written and maintained.

> > In any case, there are tools that create a farm of symlinks, and when you
> > try to write to a file (pointing to a RO area/file), you get an error. This
> > gives you 90% of what you want, _without_ aggravating the filesystem
> > hackers.
> 
> Great, so you found *your* solution already.  I've done the same
> without the need for symlinks in a 90-line patch, good enough for my
> immediate needs right now.  But someday I'd like to have the remaining
> 10% as well. :)

I had my solution with _no_ kernel patch. Better still, it also works on
propietary Unix systems. Even better yet, any newbie Unix (even without any
Linux-with-funky-patch background) user understands what is going on here.
Fully POSIX compliant.

> > > I would dearly love to use something like to make it easy to track 
> > > changes made all over a source tree.  If I could sync them up at the 
> > > begining, then make all my changes in the overly, then doing a diff is 
> > > really easy since you just look for places where the inodes are 
> > > different between the two filesystems.  Like having hard links, but the 
> > > filesystem breaks them for you when you write.
> > 
> > This is called BitKeeper, CVS, Subversion, arch, RCS, SCCS, ... Better yet,
> > it keeps the history of each file (not just the one version on RO media),
> > with annotations. You decide when a version is ready for archiving.
> > 
> > Sure, this would save disk space. But at today's prices, it just is not
> > worth the trouble.
> 
> Not true:
> - Even with bitkeeper, people copy their complete tree before making
> changes, at least Linus sais he does.  Go back to start, do not
> collect $2000.

Not needed at all. Sure, if you have enough disk... now hand over the $2000

> - Copying the kernel tree is not just a question of space and money,
> but also about time.

And both copies slowly diverge, and need to be sychronized sometime. You
owe me another $2000

> - When the time and disk hit of identical copies approaches zero,
> people will do this a lot more, they have new possibilities.  *That*
> is really important, not doing the same as before, just slightly
> optimized.

What you talking about is some kind of (modifiable) disk cache of data on
ro media... 

> -- 
> Everything should be made as simple as possible, but not simpler.
> -- Albert Einstein

This stuff definitely fails this, IMHO.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
