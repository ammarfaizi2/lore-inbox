Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132008AbQK2Szm>; Wed, 29 Nov 2000 13:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132035AbQK2Szc>; Wed, 29 Nov 2000 13:55:32 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:54145 "EHLO red.csi.cam.ac.uk")
        by vger.kernel.org with ESMTP id <S132008AbQK2Sz0>;
        Wed, 29 Nov 2000 13:55:26 -0500
From: James A Sutherland <jas88@cam.ac.uk>
To: Kurt Garloff <kurt@garloff.de>,
        --Damacus Porteng-- <kernel@bastion.yi.org>
Subject: Re: IDE-SCSI/HPT366 Problem
Date: Wed, 29 Nov 2000 18:20:09 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001129130616.A4879@bastion.sprileet.net> <20001129191402.F5891@garloff.etpnet.phys.tue.nl>
In-Reply-To: <20001129191402.F5891@garloff.etpnet.phys.tue.nl>
MIME-Version: 1.0
Message-Id: <00112918235301.10869@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Kurt Garloff wrote:
> 
> On Wed, Nov 29, 2000 at 01:06:16PM -0600, --Damacus Porteng-- wrote:
> > Problem:
> > 	The problem lies with using my EIDE CDRW - I set it up properly using
> > 	IDE-SCSI.  I can use my mp3tocdda shell script to encode mp3s to CD
> > 	(uses cdrecord as well) on the fly using either drive, however, when I
> > 	use cdrecord to write a data CD, the system hard-locks, no kernel
> > 	panic messages, and no Magic SysRQ keystroke works.  
> > 
> > 	Quite odd that I could do the cdrecord for audio tracks, but not
> > 	data..
> 
> Strange. If you read data from the harddisk on an IDE channel and write it
> (with cdrecord) to some CDRW on the same IDE channel, you have to expect
> trouble: As with IDE there is no disconnect from the bus (as opposed to
> SCSI), you risk buffer underruns. 

There shouldn't be any problems if you have the disk and CDrw drive on
different IDE busses, though, as I do. Also, provided the CDrw drive is
releasing the bus at times (which it should, presumably, since it can't be fast
enough to max out the bus all the time), you can then burst the data in from
the HDD, even on a shared bus. Even the fastest CDrw drive shouldn't get
underruns, I think.

Having said that, I'd still want to have both drives on different busses;
ideally, a SCSI CDrw and DVD drive, and ATA/100 HDDs. Now I just need to get
the numbers right on the lottery :-)

> A lockup however is not to be expected :-(

Indeed - a lockup is never the right result!


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
