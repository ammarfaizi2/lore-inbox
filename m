Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUCPReN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbUCPReK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:34:10 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:55182 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264232AbUCPRcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:32:09 -0500
Date: Tue, 16 Mar 2004 18:31:47 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040316173146.GB27046@wohnheim.fh-wedel.de>
References: <40563A2B.4040800@nortelnetworks.com> <200403161604.i2GG4Vcl004724@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403161604.i2GG4Vcl004724@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 March 2004 12:04:30 -0400, Horst von Brand wrote:
> Chris Friesen <cfriesen@nortelnetworks.com> said:
> 
> > I don't see how you win nothing.  I create an overlay filesystem. 
>  
> Completely empty is what you get then... and you have to explicitly link in
> each file. Or everything shows up here.

Correct.  Is that a problem?

> > delete a bunch of files in the overlay and it doesn't show through. 
> 
> Next time you mount it, what happens? How do you know the "top files" where
> deleted, and should not show up? 
> 
> What happens if I mount the live 2.6.4 kernel source over a CD containing
> 2.5.30? What happens to identical files, files that moved, changed files,
> deleted files? Pray tell, how does the kernel find out which is which?

What happens if I write to /dev/hda while having my rootfs /dev/hda1?
Bad things, damn right.  But why would anyone do that?

Can you tell me what the point behind your examples is?  It escapes
me.

> How do you back up a beast like this?

- Use a really large tape (stupid).
- cp /dev/... backup_medium
- Backup software with a clue about the underlying fs.

> In any case, there are tools that create a farm of symlinks, and when you
> try to write to a file (pointing to a RO area/file), you get an error. This
> gives you 90% of what you want, _without_ aggravating the filesystem
> hackers.

Great, so you found *your* solution already.  I've done the same
without the need for symlinks in a 90-line patch, good enough for my
immediate needs right now.  But someday I'd like to have the remaining
10% as well. :)

> > I would dearly love to use something like to make it easy to track 
> > changes made all over a source tree.  If I could sync them up at the 
> > begining, then make all my changes in the overly, then doing a diff is 
> > really easy since you just look for places where the inodes are 
> > different between the two filesystems.  Like having hard links, but the 
> > filesystem breaks them for you when you write.
> 
> This is called BitKeeper, CVS, Subversion, arch, RCS, SCCS, ... Better yet,
> it keeps the history of each file (not just the one version on RO media),
> with annotations. You decide when a version is ready for archiving.
> 
> Sure, this would save disk space. But at today's prices, it just is not
> worth the trouble.

Not true:
- Even with bitkeeper, people copy their complete tree before making
changes, at least Linus sais he does.  Go back to start, do not
collect $2000.
- Copying the kernel tree is not just a question of space and money,
but also about time.
- When the time and disk hit of identical copies approaches zero,
people will do this a lot more, they have new possibilities.  *That*
is really important, not doing the same as before, just slightly
optimized.

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
