Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270658AbTHLQcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270929AbTHLQcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:32:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28039 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270658AbTHLQct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:32:49 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
Date: Tue, 12 Aug 2003 18:32:48 +0200
User-Agent: KMail/1.5
Cc: Jan Niehusmann <jan@gondor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030806150335.GA5430@gondor.com> <20030811003343.A16918@pclin040.win.tue.nl> <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121832.48212.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 of August 2003 17:36, Alan Cox wrote:
> On Sul, 2003-08-10 at 23:33, Andries Brouwer wrote:
> >         if (drive->addressing == 1)             /* 48-bit LBA */
> >                 return lba_48_rw_disk(drive, rq, (unsigned long long)
> > block); if (drive->select.b.lba)                /* 28-bit LBA */ return
> > lba_28_rw_disk(drive, rq, (unsigned long) block); return
> > chs_rw_disk(drive, rq, (unsigned long) block);
> >
> > with checking the size of block.
> > And init_idedisk_capacity() does not check addressing.
>
> It should also issue LBA28 if the size of th range and the end block
> fall under the LBA28 limit because thst saves you valuable I/O time.

Yep, but its other issue.

> Jens had patches for that but I don't know where they went in 2.6

Jens and me agreed that they should be included after taskfile IO
is integrated as the only IO path.  Otherwise there are too many
corner cases to deal with.

--bartlomiej

