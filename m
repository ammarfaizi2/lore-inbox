Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWA0N6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWA0N6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWA0N6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:58:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59718 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751019AbWA0N6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:58:25 -0500
Date: Fri, 27 Jan 2006 15:00:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127140030.GL4311@suse.de>
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127123917.GI4311@suse.de> <43DA1D23.1000508@drzeus.cx> <43DA24A0.70004@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA24A0.70004@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Pierre Ossman wrote:
> Pierre Ossman wrote:
> > 
> > Doesn't seem like a generic solution is easily implemented. I'll start
> > hacking together some way of specifying that highmem isn't supported so
> > that mmc_block can indicate this to the block layer.
> > 
> 
> If I set the limit to BLK_BOUNCE_HIGH then (page_address(sg->page) +
> sg->offset) is guaranteed to be directly accessible for the entire
> sg->length on all architectures, right? This seems to be the assumption
> in the USB ub driver at least.

Yes, hence my initial suggestion to just do that.

-- 
Jens Axboe

