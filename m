Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSFFSbM>; Thu, 6 Jun 2002 14:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317047AbSFFSag>; Thu, 6 Jun 2002 14:30:36 -0400
Received: from [195.39.17.254] ([195.39.17.254]:44192 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317056AbSFFS2O>;
	Thu, 6 Jun 2002 14:28:14 -0400
Date: Sun, 2 Jun 2002 06:43:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, Xavier Bestel <xavier.bestel@free.fr>,
        Andreas Dilger <adilger@clusterfs.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020602064321.C219@toy.ucw.cz>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <20020604233124.GA18668@turbolinux.com> <3CFD50B9.259366F4@zip.com.au> <1023272806.15438.106.camel@bip> <20020605103351.GA15883@suse.de> <3CFDEE17.FD1306A0@zip.com.au> <20020605105346.GC15883@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, it could be per-queue.  That would add complexity to
> > the already-murky fs/fs-writeback.c.  It that justifiable?

Doing it per-queue is right, doing is per-system is clearly wrong. 

> I dunno, it's up to you. I guess this is mainly IDE specific anyways,

SCSI can do spindowns, too, and it *needs* kernel support for that. On
IDE, this can be (in a racy way) done userspace, too.

> but you apply the same logic to just one (for instance) of your disks on
> a home desktop system.


-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

