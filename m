Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292294AbSBBPDd>; Sat, 2 Feb 2002 10:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292295AbSBBPDY>; Sat, 2 Feb 2002 10:03:24 -0500
Received: from mustard.heime.net ([194.234.65.222]:20908 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292294AbSBBPDP>; Sat, 2 Feb 2002 10:03:15 -0500
Date: Sat, 2 Feb 2002 16:03:03 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Roger Larsson <roger.larsson@norran.net>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed
In-Reply-To: <20020202154449.D4934@suse.de>
Message-ID: <Pine.LNX.4.30.0202021602001.10631-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2002, Jens Axboe wrote:

> On Sat, Feb 02 2002, Roy Sigurd Karlsbakk wrote:
> > > Jens said earlier "Roy, please try and change
> > > the queue_nr_requests assignment in ll_rw_blk:blk_dev_init() to
> > > something like 2048." - Roy have you tested this too?
> >
> > No ... Where do I change it?
>
> drivers/block/ll_rw_blk.c:blk_dev_init()
> {
> 	queue_nr_requests = 64;
> 	if (total_ram > MB(32))
> 		queue_nr_requests = 256;
>
> Change the 256 to 2048.

Is this an attempt to fix the problem #2 (as described in the initial
email), or to further improve throughtput?

Problem #2 is _the_ worst problem, as it makes the server more-or-less
unusable

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

