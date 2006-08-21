Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWHUHCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWHUHCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 03:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWHUHCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 03:02:20 -0400
Received: from brick.kernel.dk ([62.242.22.158]:51536 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964993AbWHUHCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 03:02:19 -0400
Date: Mon, 21 Aug 2006 09:04:29 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andreas Herrmann <aherrman@de.ibm.com>,
       James Bottomley <jejb@SteelEye.com>,
       Linux SCSI <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] limit recursion when flushing shost->starved_list
Message-ID: <20060821070429.GM4290@suse.de>
References: <20060809153116.GA14043@lion28.ibm.com> <1156019429.3726.18.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156019429.3726.18.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19 2006, James Bottomley wrote:
> On Wed, 2006-08-09 at 17:31 +0200, Andreas Herrmann wrote:
> > Attached is a patch that should limit a possible recursion that can
> > lead to a stack overflow like follows:
> 
> Well, OK, initially I'll put this in scsi-misc, since I acknowledge its
> a problem.   However, it is one that block queue grouping should be able
> to get us out of ... and at that time, this code (and most of the
> starved list handling) should exit the scsi mid-layer.

Yep, the patch is a little nasty but I don't see a better way currently.
So the above outline sounds good to me.

-- 
Jens Axboe

