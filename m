Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTE1GRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 02:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTE1GRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 02:17:35 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52110 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264547AbTE1GRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 02:17:33 -0400
Date: Wed, 28 May 2003 08:30:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/blkdev (2.5.70)
Message-ID: <20030528063046.GI845@suse.de>
References: <200305272323.29063.ivg2@cornell.edu> <20030528052934.GS8978@holomorphy.com> <Pine.LNX.4.50.0305280130160.15323-100000@montezuma.mastecende.com> <20030528061136.GH845@suse.de> <Pine.LNX.4.50.0305280210060.15323-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305280210060.15323-100000@montezuma.mastecende.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Zwane Mwaikambo wrote:
> On Wed, 28 May 2003, Jens Axboe wrote:
> 
> > Previous request, what are you talking about?
> 
> I meant the rq will be removed off the request queue.
> 
> blk_queue_start_tag
> blkdev_dequeue_request;

Yes that is fine, the problem is that blkdev_dequeue_request() complains
about the request not being on the list. Which looks very corrupt.

-- 
Jens Axboe

