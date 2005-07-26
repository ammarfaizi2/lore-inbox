Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVGZHUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVGZHUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 03:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGZHUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 03:20:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15068 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261833AbVGZHTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 03:19:02 -0400
Date: Tue, 26 Jul 2005 04:16:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kill bio->bi_set
Message-ID: <20050726021655.GA3085@suse.de>
References: <20050720222949.GE2548@suse.de> <m34qaljnvd.fsf@telia.com> <20050723205956.GA17370@suse.de> <m37jfea0xu.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37jfea0xu.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26 2005, Peter Osterlund wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> > On Sat, Jul 23 2005, Peter Osterlund wrote:
> > > Jens Axboe <axboe@suse.de> writes:
> > > 
> > > > Dunno why I didn't notice before, but ->bi_set is totally unnecessary
> > > > bloat of struct bio. Just define a proper destructor for the bio and it
> > > > already knows what bio_set it belongs too.
> > > 
> > > This causes crashes on my computer.
> > 
> > Did I neglect to mention it was untested? :)
> ...
> > Thanks, I'll go over these and submit a fixed version.
> 
> I fixed this myself. The patch below is tested with dm-crypt on top of
> pktcdvd on top of usb-storage, and worked fine in my tests.

Thanks! I was travelling, so I didn't get to it myself.

-- 
Jens Axboe

