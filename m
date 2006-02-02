Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWBBRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWBBRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWBBRi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:38:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65374 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750831AbWBBRiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:38:25 -0500
Date: Thu, 2 Feb 2006 18:40:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] blk: Fix SG_IO ioctl failure retry looping
Message-ID: <20060202174032.GB4215@suse.de>
References: <200602021729.k12HTtmg018944@d03av02.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602021729.k12HTtmg018944@d03av02.boulder.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02 2006, Brian King wrote:
> 
> When issuing an SG_IO ioctl through sd that resulted
> in an unrecoverable error, a nearly infinite retry loop
> was discovered. This is due to the fact that the block
> layer SG_IO code is not setting up rq->retries. This
> patch also fixes up the sg_scsi_ioctl path.

Looks good, applied. Thanks!

-- 
Jens Axboe

