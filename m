Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTDUJUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTDUJUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:20:32 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262788AbTDUJUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:20:31 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304210935.h3L9ZLXc000256@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Mon, 21 Apr 2003 10:35:21 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org
In-Reply-To: <200304210900.h3L90vu07375@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Apr 21, 2003 12:09:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What is so bad about the simple way: the one who wants to write
> > > (e.g. fs) and knows _where_ to write simply uses another newly
> > > allocated block and dumps the old one on a blacklist. The blacklist
> > > only for being able to count them (or get the sector-numbers) in
> > > case you are interested. If you weren't you might as well mark them
> > > allocated and that's it (which I would presume a _bad_ idea). If
> > > there are no free blocks left, well, then the medium is full. And
> > > that is just about the only cause for a write error then (if the
> > > medium is writeable at all).
> >
> > Modern disks generally do this kind of thing themselves.  By the time
>                ^^^^^^^^^^^^
> How many times does Stephan need to say it? 'Generally do'
> is not enough, because it means 'sometimes they dont'.

OK, _ALL_ modern disks do.

Name an IDE or SCSI disk on sale today that doesn't retry on write
failiure.  Forget I said 'Generally do'.

> Most filesystems *are* designed with badblock lists and such,
> it is possible to teach fs drivers to tolerate write errors
> by adding affected blocks to the list and continuing (as opposed
> to 'remounted ro, BOOM!'). As usual, this can only happen if someone
> will step forward and code it.
> 
> Do you think it would be a Wrong Thing to do?

Yes, I do.

It achieves nothing useful, and gives people a false sense of security.

We have moved on since the 1980s, and I believe that it is now up to
the drive firmware, or the block device driver to do this, it has no
place in a filesystem.

John.
