Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUACUcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUACUcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:32:25 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:34503 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263646AbUACUcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:32:23 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Jens Axboe <axboe@suse.de>, packet-writing <packet-writing@suse.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
	<20040103191414.GE1080@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2004 21:32:13 +0100
In-Reply-To: <20040103191414.GE1080@elf.ucw.cz>
Message-ID: <m2hdzc93jm.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> > --- linux/drivers/block/pktcdvd.c.old	2004-01-02 00:23:57.000000000 +0100
> > +++ linux/drivers/block/pktcdvd.c	2004-01-02 00:24:01.000000000 +0100
> > @@ -2164,6 +2164,7 @@
> >  	request_queue_t *q = disks[pkt_get_minor(pd)]->queue;
> >  
> >  	blk_queue_make_request(q, pkt_make_request);
> > +	blk_queue_hardsect_size(q, CD_FRAMESIZE);
> >  	blk_queue_max_sectors(q, PACKET_MAX_SECTORS);
> >  	blk_queue_merge_bvec(q, pkt_merge_bvec);
> >  	q->queuedata = pd;
> > 
> 
> Where do I get this file? It does not appear to be in 2.6.0.
> 
> [I have few partly-bad cd-rws, and putting ext2 on them would be
> "cool" :-)]

Look here:

        http://w1.894.telia.com/~u89404340/packet.html

Download here:

        http://w1.894.telia.com/~u89404340/patches/packet/2.6/

Note that this software is still beta quality at best. I'm not sure if
you'll have any success with partly bad cd-rws, but it doesn't hurt to
try I guess.

I haven't made a new release with the two latest bug fixes, so if you
plan to put ext2 on the disc, you need the quoted hardsect_size patch
and the bio split patch from a few days ago.

        http://marc.theaimsgroup.com/?l=linux-kernel&m=107306015810846&w=2

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
