Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUBKGje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBKGje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:39:34 -0500
Received: from [212.239.226.205] ([212.239.226.205]:50304 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S263544AbUBKGjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:39:31 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Wed, 11 Feb 2004 07:24:18 +0100
User-Agent: KMail/1.5.4
Cc: Kiko Piris <kernel@pirispons.net>, Bart Samwel <bart@samwel.tk>,
       linux-kernel@vger.kernel.org, Dax Kelson <dax@gurulabs.com>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <200401131200.16025.lkml@kcore.org> <20040113110110.GA6711@suse.de>
In-Reply-To: <20040113110110.GA6711@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402110724.18676.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 12:01, Jens Axboe wrote:
> On Tue, Jan 13 2004, Jan De Luyck wrote:
> > On Monday 12 January 2004 15:02, Jens Axboe wrote:
> > > bo is accounted when io is actually put on the pending queue for the
> > > disk, so they really do go hand in hand. So you should use block_dump
> > > to find out why.
> >
> > It's nearly always reiserfs that causes the disk to spin up. Also, I'm
> > seeting the harddisk led light up every 5-7 seconds :-( weird.
>
> Does 2.6 laptop mode patch even include the necessary reiser changes to
> make this work properly?

To followup on this: I've recently moved my entire installation to ext3 (I had 
to RMA the disk, tarred everything up, formatted another disk, put everything 
back but on ext3 this time), on which the laptopmode actually makes a 
difference. I can hear the disk spindown, and it stays that way for a 
reasonably long time (e.g. +- 10 minutes has happened).

So there does seem to be a serious difference between the reiserfs commit 
option and the ext3 option.

Just letting you folks know.

Jan

-- 
Baruch's Observation:
	If all you have is a hammer, everything looks like a nail.

