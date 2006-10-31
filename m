Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWJaHNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWJaHNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWJaHNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:13:51 -0500
Received: from brick.kernel.dk ([62.242.22.158]:34119 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422848AbWJaHNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:13:50 -0500
Date: Tue, 31 Oct 2006 08:15:32 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] Check bio address after mapping through partitions.
Message-ID: <20061031071531.GT14055@kernel.dk>
References: <20061031124940.24199.patches@notabene> <1061031015145.24246@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061031015145.24246@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, NeilBrown wrote:
> This would be good for 2.6.19 and even 18.2, if it is seens acceptable.
> raid0 at least (possibly other) can be made to Oops with a bad partition 
> table and best fix seem to be to not let out-of-range request get down
> to the device.
> 
> ### Comments for Changeset
> 
> Partitions are not limited to live within a device.  So
> we should range check after partition mapping.
> 
> Note that 'maxsector' was being used for two different things.  I have
> split off the second usage into 'old_sector' so that maxsector can be
> still be used for it's primary usage later in the function.
> 
> Cc: Jens Axboe <jens.axboe@oracle.com>
> Signed-off-by: Neil Brown <neilb@suse.de>

Code looks good to me, but for some reason your comment exceeds 80
chars. Can you please fix that up?

Acked-by: Jens Axboe <jens.axboe@oracle.com>

-- 
Jens Axboe

