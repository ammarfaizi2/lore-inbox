Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVA0XEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVA0XEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVA0XEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:04:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57062 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261265AbVA0XCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:02:44 -0500
Message-ID: <41F97305.6050404@pobox.com>
Date: Thu, 27 Jan 2005 18:02:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support #2
References: <20050127120244.GO2751@suse.de> <20050127150845.GY2751@suse.de>
In-Reply-To: <20050127150845.GY2751@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> A few changes:
> 
> - Cleanup up the driver additions even more, blk_complete_barrier_rq()
>   does all the work now.
> 
> - Fixed up the exports
> 
> - Comment functions
> 
> - Fixed a bug with SCSI and write back caching disabled
> 
> - Rename blk_queue_flush() to blk_queue_flushing() to indicate it's a
>   state


Tiny nit for SATA drivers:

Define a ATA_ORDERED_IO constant in libata.h, rather than hardcoding the 
1 in each driver.

