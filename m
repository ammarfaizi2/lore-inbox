Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280587AbRKBHYE>; Fri, 2 Nov 2001 02:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRKBHX5>; Fri, 2 Nov 2001 02:23:57 -0500
Received: from 48.ppp1-8.hob.worldonline.dk ([213.237.85.48]:15744 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S280587AbRKBHXo>; Fri, 2 Nov 2001 02:23:44 -0500
Date: Fri, 2 Nov 2001 08:23:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Dan Podeanu <pdan@spiral.extreme.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi bug, or..?
Message-ID: <20011102082314.E607@suse.de>
In-Reply-To: <Pine.LNX.4.33L2.0111020346001.7137-200000@spiral.extreme.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0111020346001.7137-200000@spiral.extreme.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02 2001, Dan Podeanu wrote:
> 
> Hello,
> 
> Upon trying to mount a CD-RW I get the following error:
> 
> ide-scsi: hdc: unsupported command in request queue (0)
> end_request: I/O error, dev 16:01 (hdc), sector 64
> isofs_read_super: bread failed, dev=16:01, iso_blknum=16, block=32
> mount: wrong fs type, bad option, bad superblock on /dev/hdc1,
> 
> Note that I use the hdd=ide-scsi parameter and that the CD is detected as
> SCSI:
> 
> hdc: CD-W54E, ATAPI CD/DVD-ROM drive
> 
> SCSI subsystem driver Revision: 1.00
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: TEAC      Model: CD-W54E           Rev: 1.1B
>   Type:   CD-ROM                             ANSI SCSI revision: 02

You are trying to mount /dev/hdc and that is handled by ide-scsi. Mount
/dev/sr0 instead. For that you must also remember to configure SCSI
CD-ROM support, which you haven't done:

# CONFIG_BLK_DEV_SR is not set

-- 
Jens Axboe

