Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbREZPmZ>; Sat, 26 May 2001 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbREZPmQ>; Sat, 26 May 2001 11:42:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51723 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261763AbREZPlr>;
	Sat, 26 May 2001 11:41:47 -0400
Date: Sat, 26 May 2001 17:09:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Harald Dunkel <harri@synopsys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: 'mount /cdrom' doesn't work
Message-ID: <20010526170902.E553@suse.de>
In-Reply-To: <3B0FBD25.8956C693@Synopsys.COM> <20010526163232.A553@suse.de> <3B0FC6A1.857DBF4@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0FC6A1.857DBF4@Synopsys.COM>; from harri@synopsys.COM on Sat, May 26, 2001 at 05:07:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26 2001, Harald Dunkel wrote:
> Jens Axboe wrote:
> > 
> > On Sat, May 26 2001, Harald Dunkel wrote:
> > > Hi folks,
> > >
> > > With 2.4.5 my CD and DVD drives have become unaccessable.
> > >
> > > Can you reproduce this problem?
> > 
> > Any kernel messages? And please show what happens.
> > 
> 
> Currently I am back to 2.4.4, but AFAIR I got a message 'no medium found' 
> or something like that on the command line.
> 
> I have found this in kern.log:
> 
> May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
> May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
> May 26 15:31:17 bilbo kernel: Detected scsi CD-ROM sr2 at scsi2, channel 0, id 0, lun 0
> May 26 15:31:17 bilbo kernel: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
> May 26 15:31:17 bilbo kernel: Uniform CD-ROM driver Revision: 3.12
> May 26 15:31:17 bilbo kernel: sr1: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
> May 26 15:31:17 bilbo kernel: sr2: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> May 26 15:31:17 bilbo kernel: VFS: Disk change detected on device sr(11,1)
> May 26 15:31:17 bilbo last message repeated 3 times
> May 26 15:31:17 bilbo kernel: Device 0b:01 not ready.
> May 26 15:31:17 bilbo kernel:  I/O error: dev 0b:01, sector 1024
> 
> Using 2.4.4 the same CD works in the same drive. 

The only changes that could matter would be SCSI driver changes. You
wouldn't happen to use the new aic7xxx driver?

-- 
Jens Axboe

