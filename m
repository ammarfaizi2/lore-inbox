Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136348AbREIL40>; Wed, 9 May 2001 07:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136354AbREIL4R>; Wed, 9 May 2001 07:56:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35338 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136348AbREILz6>;
	Wed, 9 May 2001 07:55:58 -0400
Date: Wed, 9 May 2001 13:55:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: patch: packet-0.0.2k
Message-ID: <20010509135553.R521@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Put up the final packet-0.0.2k patch, against 2.4.4 and 2.4.5-pre1.
A more complete changelog, since packet-0.0.2j:

        - Fix b_count bh bug, forgot to release buffers
        - Fix lock_buffer buf
        - Remove pkt_gather_data rerun to print buggy buffer list, that
          bug has been fixed.
        - Changed proc layout to /proc/driver/pktcdvd/pktcdvdX, one file
          per writer. Also compiles without proc fs support now.
        - Set quiet bit on write cache settings, drive may not support
          it
        - Remove PACKET_WAKEUP ioctl (buggy too, noticed by jgarzik)
        - Merge with 2.4.5-pre1
        - Added recovery mode
        - (with above) Added relocate_blocks super operation
        - Missing break in PACKET_GET_STATS ioctl
        - invalidate_device changes
        - Always piggy buffers to maintain b_end_io consistency
        - Change several BUG's to complain and abort nicely
        - Remove __dump_rq from ll_rw_blk and SCSI
        - Updated INSTALL and FAQ
        - Added kernel UDF diff
        - Fixup end_request handling
        - Put unplug back in
        - Rewrite kernel thread setup/exit
        - Set device RO on BLKROSET

*.kernel.org/pub/linux/kernel/people/axboe/packet/

The sourceforge packages are going up as I write this, so should be
there very soon. Note that a UDF patch is now included against the
kernel UDF, so you don't have to use cvs udf for a stable setup.

Background -- this is a module that allows transparent writing to CD-RW
(CD-R will follow) discs, so you can use it as a big floppy basically.

-- 
Jens Axboe

