Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSIZPtn>; Thu, 26 Sep 2002 11:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbSIZPtn>; Thu, 26 Sep 2002 11:49:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51710 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261330AbSIZPtm>;
	Thu, 26 Sep 2002 11:49:42 -0400
Date: Thu, 26 Sep 2002 08:54:45 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926085445.A22321@eng2.beaverton.ibm.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com> <20020926064455.GC12862@suse.de> <20020926065951.GD12862@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020926065951.GD12862@suse.de>; from axboe@suse.de on Thu, Sep 26, 2002 at 08:59:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 08:59:51AM +0200, Jens Axboe wrote:
> On Thu, Sep 26 2002, Jens Axboe wrote:
> BTW, for SCSI, it would be nice to first convert more drivers to use the
> block level queued tagging. That would provide us with a much better
> means to control starvation properly on SCSI as well.
> 
> -- 
> Jens Axboe

I haven't look closely at the block tagging, but for the FCP protocol,
there are no tags, just the type of queueing to use (task attributes)
- like ordered, head of queue, untagged, and some others. The tagging
is normally done on the adapter itself (FCP2 protocol AFAIK). Does this
mean block level queued tagging can't help FCP?

Maybe the same for iSCSI, other protocols, and pseudo adapters -
usb, ide, and raid adapters.

-- Patrick Mansfield
