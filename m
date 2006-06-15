Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031114AbWFOS5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031114AbWFOS5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031113AbWFOS5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:57:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030788AbWFOS5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:57:05 -0400
Date: Thu, 15 Jun 2006 20:57:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Frederic TEMPORELLI <frederic.temporelli@ext.bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: IO blocks are limited to 512KBytes (blk_queue_max_sectors)
Message-ID: <20060615185746.GG3456@suse.de>
References: <44917313.9040800@ext.bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44917313.9040800@ext.bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15 2006, Frederic TEMPORELLI wrote:
> So, what is the nice way to change the block layer for getting large IO 
> blocks (> 1024 sectors) ?

# echo large_value > /sys/block/<dev>/queue/max_sectors_kb

where large_value <= max_hw_sectors_kb

-- 
Jens Axboe

