Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130204AbRALDty>; Thu, 11 Jan 2001 22:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132637AbRALDte>; Thu, 11 Jan 2001 22:49:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5139 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130204AbRALDtc>;
	Thu, 11 Jan 2001 22:49:32 -0500
Date: Fri, 12 Jan 2001 04:49:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Bill Crawford <billc@netcomuk.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac7
Message-ID: <20010112044922.A2961@suse.de>
In-Reply-To: <3A5E7BDE.8B8616AF@netcomuk.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A5E7BDE.8B8616AF@netcomuk.co.uk>; from billc@netcomuk.co.uk on Fri, Jan 12, 2001 at 03:37:02AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12 2001, Bill Crawford wrote:
> depmod: *** Unresolved symbols in /lib/modules/2.4.0-ac7/kernel/drivers/scsi/scsi_mod.o
> depmod:         queued_sectors

Apologies, I didn't think of modular SCSI/IDE for this...

--- /opt/kernel/linux-2.4.0-ac7/drivers/block/ll_rw_blk.c	Fri Jan 12 04:47:18 2001
+++ drivers/block/ll_rw_blk.c	Fri Jan 12 04:47:40 2001
@@ -1389,3 +1389,4 @@
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
 EXPORT_SYMBOL(generic_unplug_device);
+EXPORT_SYMBOL(queued_sectors);

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
