Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUHYXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUHYXCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUHYXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:00:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:30376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266257AbUHYXAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:00:11 -0400
Date: Wed, 25 Aug 2004 15:59:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Spam <spam@tnonline.net>
cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <112698263.20040826005146@tnonline.net>
Message-ID: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Spam wrote:
> 
> > My own order of preference is b) c) a).  The fact that one filesystem will
> > offer features which other filesystems do not and cannot offer makes me
> > queasy for some reason.
> 
>   This last sentence makes me wonder. Where is Linux heading? The idea
>   that   a  FS  cannot  contain  features that no other FS has is very
>   scary.

That's not what Andrew said or meant.

Note the "cannot offer". As in "there is no way to offer them even if the 
filesystem could support it otherwise". 

We have tons of filesystems that do things other filesystems cannot do.  
Most filesystems support writing to a file - despite the fact that some
filesystems (iso9600 being an obvious one) cannot. The infrastructure is
there in the VFS layer, and it becomes a _choice_ for the filesystem
whether it offers certain capabilities.

So look at what Andrew said, again: his top choice would be (b). Let's see 
what that was again, shall we?

> b) accept the reiser4-only extensions with a view to turning them into
>    kernel-wide extensions at some time in the future, so all filesystems
>    will offer the extensions (as much as poss) or

In other words, if reiserfs does something special, we should make 
standard interfaces for doing that special thing, so that everybody can 
do it without stepping on other peoples toes.

That doesn't mean that we'd _force_ everybody to do it. The same way we 
don't force iso9660 to write to a CD-ROM.

		Linus
