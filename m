Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKXVWS>; Fri, 24 Nov 2000 16:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129601AbQKXVWI>; Fri, 24 Nov 2000 16:22:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20997 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S129518AbQKXVVy>;
        Fri, 24 Nov 2000 16:21:54 -0500
Date: Fri, 24 Nov 2000 21:51:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Drizzt <drizzt.dourden@iname.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More info about de USB HP 8230e and problems]
Message-ID: <20001124215150.G11366@suse.de>
In-Reply-To: <20001124050948.A1043@menzoberrazan.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001124050948.A1043@menzoberrazan.dhis.org>; from drizzt.dourden@iname.com on Fri, Nov 24, 2000 at 05:09:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24 2000, Drizzt wrote:
> I have using the next software:
> 
> a) test11 + storage checkout from linux-usb at sourceforge ( without 
>    this checkout fails too).
> 
> b) cdrecord 1.10a6
> 
> If I start to burn a CD at x4 speed, I have always the next error from
> cdrecord:
> Track 01: 102 of 109 MB written (fifo 100%)./opt/schily/bin/cdrecord:
> Input/output error. write_g1: scsi sendcmd: retryable error
> CDB:  2A 00 00 00 CD 03 00 00 1F 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 03 00 00 00 00 12 00 00 00 00 0C 09 00 00
> Sense Key: 0x3 Medium Error, Segment 0
> Sense Code: 0x0C Qual 0x09 (write error - loss of streaming) Fru 0x0
> Sense flags: Blk 0 (not valid)
> 
> Well the size of track varies in function that have buring.
> 
> With the storage-usb debug active I have the next log:
> 
> usb-storage: Command WRITE_10 (10 bytes)
> usb-storage: 2a 00 00 00 cd 03 00 00 1f 00 ff bf
> usb-storage: Transferred out 38 of 38 bytes
> usb-storage: Transferred out 32768 of 32768 bytes
> usb-storage: Transferred out 30720 of 30720 bytes
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Transferred out 14 of 14 bytes
> usb-storage: Waited not busy for 0 steps
> usb-storage: Transferred out 12 of 12 bytes
> usb-storage: Waited not busy for 2 steps
> usb-storage: Transferred in 18 of 18 bytes
> usb-storage: 70 00 03 00 00 00 00 12 00 00 00 00 0C 09 00 00
> usb-storage: 00 00
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x3, ASC: 0xc, ASCQ: 0x9
				   ^^^^^^^^^^^^^^^^^^^^^^^^

Loss of streaming. The drive emptied it's buffer before any
new data was delivered to it.

> If I burning the CD with the same software at x2 speed with these computer I
> have no problem burning the CD.

Then you should probably just stay there, it seems things can't keep up.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
