Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUABQgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUABQgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:36:38 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:1445 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265594AbUABQgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:36:36 -0500
Date: Fri, 2 Jan 2004 17:35:52 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, Libor Vanek <libor@conet.cz>,
       Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102163552.GD31489@wohnheim.fh-wedel.de>
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040102160020.A24026@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 January 2004 16:00:20 +0000, Christoph Hellwig wrote:
> On Fri, Jan 02, 2004 at 04:38:27PM +0100, Libor Vanek wrote:
> > I'm working on my diploma thesis which is adding snapshot capability 
> > into Linux VFS (so you can do directory based snapshots - not complete 
> > device, like in LVM). It'll consist of two separete modules:
> > Snapshot module:
> > - will hijack (one or another way) calls to open/move/unlink/mkdir/etc. 
> > syscall
> > - when will detect change to selected directory (which I want to 
> > snapshot), it'll copy/move old file/directory to some temporary 
> > (selected when creating snapshot) - in fact - copy on write behaviour
> 
> This should be implemented as a stackable filesystem..

Does this filesystem stack work with multiple mount points?

My guess is that the filesystem change notification would be a better
solution, either in userspace or in kernelspace, doesn't matter.  But
that is far from finished or even generally accepted.


For the diploma thesis, feel free to use any hack you like, including
hijacking syscalls.  But remember that it is a hack and nothing else,
only helping you to remain on schedule and focus more on the real
subject.  And don't plan on kernel acceptance either, as you will fail
either that or the thesis and I'd choose the thesis.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
