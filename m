Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWBNJsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWBNJsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWBNJse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:48:34 -0500
Received: from lucidpixels.com ([66.45.37.187]:49344 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030533AbWBNJse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:48:34 -0500
Date: Tue, 14 Feb 2006 04:48:31 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: LibPATA code issues / 2.6.15.4
Message-ID: <Pine.LNX.4.64.0602140439580.3567@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I'd have to double check but I do not recall getting these errors before 
the pass-thru code was introduced in 2.6.15, I also was not running the 
smart daemon until 2.6.15 for SATA drives as it was not supported.

I had a few issues before that I posted to LKML, those were due to too 
many SATA devices etc, everything is back to normal for the most part.

Speed, etc, all is well again, almost...

/dev/sdc:
  Timing buffered disk reads:  154 MB in  3.02 seconds =  50.97 MB/sec
/dev/sdc:
  Timing buffered disk reads:  162 MB in  3.00 seconds =  53.94 MB/sec

The only issue I have is when I copy a lot of files to a WD 400GB drive I 
these pesky errors in dmesg:

  ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
  ata3: status=0x51 { DriveReady SeekComplete Error }
  ata3: error=0x04 { DriveStatusError }

Yet, everything copied (226GB) or so to the 400GB drive without a single 
I/O error that I am aware of.  So my question is, why do I get these 
errors in dmesg if they are not critical?

Thanks,

Justin.


