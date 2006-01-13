Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161532AbWAMPgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161532AbWAMPgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161552AbWAMPgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:36:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39271 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161532AbWAMPgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:36:02 -0500
Date: Fri, 13 Jan 2006 16:37:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: bzolnier@gmail.com, rmk@arm.linux.org.uk, james.steward@dynamicratings.com,
       jgarzik@pobox.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
Message-ID: <20060113153722.GR3945@suse.de>
References: <11371658562541-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14 2006, Tejun Heo wrote:
> Hello, all.
> 
> This patchset tries to fix data corruption bug caused by not handling
> cache coherency during block PIO.  This patch implements
> blk_kmap/unmap helpers which take extra @dir argument and perform
> appropriate coherency actions.  These are to block PIO what dma_map/
> unmap are to block DMA transfers.
> 
> IDE, libata, SCSI, rd and md are converted.  Still left are nbd, loop
> and pktcddvd.  If I missed something, please let me know.
> 
> Russell, can you please test whether this fixes the bug on arm?  If
> this fixes the bug and people agree with the approach, I'll follow up
> with patches for yet unconverted drivers and documentation update.

Tejun,

Patches looks good, it's good to get this hole closed. Thanks!

-- 
Jens Axboe

