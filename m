Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVAYQVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVAYQVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVAYQVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:21:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15291 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261999AbVAYQVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:21:04 -0500
Date: Tue, 25 Jan 2005 17:21:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Elias da Silva <silva@aurigatec.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Message-ID: <20050125162102.GS2751@suse.de>
References: <200501220327.38236.silva@aurigatec.de> <200501251029.22646.silva@aurigatec.de> <20050125124512.GM2751@suse.de> <200501251713.27402.silva@aurigatec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501251713.27402.silva@aurigatec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25 2005, Elias da Silva wrote:
> On Tuesday 25 January 2005 13:45, you wrote:
> [snip]
> : If I'm not mistaken, Peter Jones has posted a few iterations of such an
> : fs some months ago.
> 
> Thank you. I will check this...
> 
> : > Do we have a clear understanding that this fs would only
> : > be a benefit if *All* the different ways to access the device would
> : > use the same policy enforcement and consistently allow or
> : > disallow certain operations regardless of the access method?
> : 
> : The command restriction table _only_ works through the SG_IO path, which
> : does include CDROM_SEND_PACKET as well since it is layered on top of
> : SG_IO. It doesn't control various driver ioctl exported interfaces, they
> : would need to add a callback to verify_command() for permission checks.
> 
> Hmm... what exactly does that mean? Who is ment by "_they_ would need..."?

It refers back to 'various driver ioctl' earlier, so it refers to the
driver itself.

-- 
Jens Axboe

