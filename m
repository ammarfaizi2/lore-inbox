Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281555AbRKMJDw>; Tue, 13 Nov 2001 04:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281556AbRKMJDk>; Tue, 13 Nov 2001 04:03:40 -0500
Received: from 75.ppp1-8.hob.worldonline.dk ([213.237.85.75]:53378 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S281555AbRKMJDc>; Tue, 13 Nov 2001 04:03:32 -0500
Date: Tue, 13 Nov 2001 10:02:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@caldera.de>, Mark Peloquin <peloquin@us.ibm.com>,
        dalecki@evision.ag, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Re: Hardsector size support in 2.4 and 2.5
Message-ID: <20011113100230.A15827@suse.de>
In-Reply-To: <OF9F38B076.0F9781F3-ON85256B02.006D5DFE@raleigh.ibm.com> <20011112212735.A28486@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011112212735.A28486@caldera.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12 2001, Christoph Hellwig wrote:
> On Mon, Nov 12, 2001 at 02:05:19PM -0600, Mark Peloquin wrote:
> > So any block device, can always expect to receive buffer heads
> > whose b_rsector value represents the offset from the beginning
> > of that device in 512 byte multiples? And this will continue
> > to hold true in 2.5 as well?
> 
> There is a good chance that no 2.5 block driver will ever see a buffer_head,
> take a look at http://www.kernel.org/pub/linux/kernel/people/axboe/v2.5/ for
> details.

To expand on the specific point -- in 2.5, what will change is that
b_rsector (or equiv field, bi_sector in bio) will be offset from the
beginning of the disk, not the beginning of the partition. This moves
toe partion remaps out of the driver itself.

-- 
Jens Axboe

