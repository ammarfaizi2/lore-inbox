Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTE1GNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 02:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTE1GNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 02:13:14 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:2946
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264544AbTE1GNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 02:13:14 -0400
Date: Wed, 28 May 2003 02:16:10 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jens Axboe <axboe@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/blkdev (2.5.70)
In-Reply-To: <20030528061136.GH845@suse.de>
Message-ID: <Pine.LNX.4.50.0305280210060.15323-100000@montezuma.mastecende.com>
References: <200305272323.29063.ivg2@cornell.edu> <20030528052934.GS8978@holomorphy.com>
 <Pine.LNX.4.50.0305280130160.15323-100000@montezuma.mastecende.com>
 <20030528061136.GH845@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Jens Axboe wrote:

> Previous request, what are you talking about?

I meant the rq will be removed off the request queue.

blk_queue_start_tag
blkdev_dequeue_request;

Bad wording, clue anaemia.

> do_ide_request()
> ide_do_request()
> start_request(drive, rq);	/* this rq is _never_ off the list */
> __ide_do_rw_disk(drive, rq);
> idedisk_start_tag(drive, rq);
> 	blkdev_dequeue_request(rq);	/* boom */
> 
> It does _not_ look valid.

And thus he spake...

-- 
function.linuxpower.ca
