Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbUCPQH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCPQFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:05:19 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56192 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263359AbUCPQEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:04:45 -0500
Message-Id: <200403161604.i2GG4Vcl004724@eeyore.valparaiso.cl>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs 
In-Reply-To: Your message of "Mon, 15 Mar 2004 18:20:11 EST."
             <40563A2B.4040800@nortelnetworks.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 16 Mar 2004 12:04:30 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> said:
> Horst von Brand wrote:
> > Assuming one RW on top of a RO only now: What should happen when a
> > file/directory is missing from the top? If the bottom one "shows through",
> > you can't delete anything; if it doesn't, you win nothing (because you will
> > have to keep a complete copy RW on top).

> I don't see how you win nothing.  I create an overlay filesystem. 
 
Completely empty is what you get then... and you have to explicitly link in
each file. Or everything shows up here.
 
>                                                                   I 
> delete a bunch of files in the overlay and it doesn't show through. 

Next time you mount it, what happens? How do you know the "top files" where
deleted, and should not show up? 

What happens if I mount the live 2.6.4 kernel source over a CD containing
2.5.30? What happens to identical files, files that moved, changed files,
deleted files? Pray tell, how does the kernel find out which is which?

How do you back up a beast like this?
 
>                                                                     All 
> my other files are still links to the originals, with the

Something missing here?

In any case, there are tools that create a farm of symlinks, and when you
try to write to a file (pointing to a RO area/file), you get an error. This
gives you 90% of what you want, _without_ aggravating the filesystem
hackers.

> I would dearly love to use something like to make it easy to track 
> changes made all over a source tree.  If I could sync them up at the 
> begining, then make all my changes in the overly, then doing a diff is 
> really easy since you just look for places where the inodes are 
> different between the two filesystems.  Like having hard links, but the 
> filesystem breaks them for you when you write.

This is called BitKeeper, CVS, Subversion, arch, RCS, SCCS, ... Better yet,
it keeps the history of each file (not just the one version on RO media),
with annotations. You decide when a version is ready for archiving.

Sure, this would save disk space. But at today's prices, it just is not
worth the trouble.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
