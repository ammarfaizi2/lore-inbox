Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRBYAnb>; Sat, 24 Feb 2001 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129756AbRBYAnM>; Sat, 24 Feb 2001 19:43:12 -0500
Received: from msp-65-25-214-194.mn.rr.com ([65.25.214.194]:23680 "EHLO
	msp-65-25-214-194.mn.rr.com") by vger.kernel.org with ESMTP
	id <S129747AbRBYAnB>; Sat, 24 Feb 2001 19:43:01 -0500
Date: Sat, 24 Feb 2001 18:42:56 -0600
From: Rick Richardson <rickr@mn.rr.com>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: Re: vmware 2.0.3, kernel 2.4.0 and a cdrom
Message-ID: <20010224184255.A4372@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14 2001, Martin Maciaszek wrote: 
> Since I installed Kernel 2.4.0 VMware is no longer able to 
> recognize my cdrom drive. VMware shows a dialog box on power up 
> with following content: 
> [...] 
> CDROM: '/dev/scd0' exists, but does not appear tobe a CDROM device. 

On Mon Jan 15 2001, Jens Axboe wrote:
> Could you try with this patch, so maybe we can get some hints as to what 
> is going on? 

I didn't see any reply to the request to see the debug output from
the patch.  So here is the output when it is applied to kernel 2.4.2:

Feb 24 18:36:11 ipcroe kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
Feb 24 18:36:11 ipcroe kernel: sr0: scsi-1 drive
Feb 24 18:36:19 ipcroe kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
Feb 24 18:36:19 ipcroe kernel: Mode Sense (10) 00 0e 00 00 00 00 00 18 00 
Feb 24 18:36:19 ipcroe kernel: [valid=0] Info fld=0x0, Current sr00:00: sense key Illegal Request
Feb 24 18:36:19 ipcroe kernel: Additional sense indicates Invalid command operation code

-Rick

-- 
Rick Richardson  rickr@mn.rr.com      http://home.mn.rr.com/richardsons/
Twins Cities traffic animations are at http://members.nbci.com/tctraffic/

Important data should not be entrusted to Fisher, as it may eat it and make
loud belching noises. -- RH 7.1 beta release notes.
