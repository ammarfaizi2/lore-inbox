Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130060AbRBDGmG>; Sun, 4 Feb 2001 01:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRBDGl5>; Sun, 4 Feb 2001 01:41:57 -0500
Received: from mail.diligo.fr ([194.153.78.251]:34570 "EHLO mail.diligo.fr")
	by vger.kernel.org with ESMTP id <S130060AbRBDGln>;
	Sun, 4 Feb 2001 01:41:43 -0500
Date: Sun, 4 Feb 2001 07:37:47 +0100
From: patrick.mourlhon@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
Message-ID: <20010204073747.C529@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You were my best hope, cause i did something similar for
a Hp 720c on parallel port, and it worked. I did excatly
what you've just said.
But the whole thing still doesn't work properly.

I finally could mount the device, then read the first root directory.
But couldn't get more... always got what you see at the end of the
error message.. I/O error, which resulted in no files appearing from
a 'ls' command.

I've got those kind of message now :

Feb  4 07:18:35 Line kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 2e 00 00 01 00 
Feb  4 07:18:35 Line kernel: SCSI host 0 abort (pid 0) timed out - resetting
Feb  4 07:18:35 Line kernel: SCSI bus is being reset for host 0 channel 0.
Feb  4 07:18:35 Line kernel: hdb: ATAPI reset complete
Feb  4 07:18:35 Line kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 2e 00 00 01 00 
Feb  4 07:18:35 Line kernel: SCSI host 0 abort (pid 0) timed out - resetting
Feb  4 07:18:35 Line kernel: SCSI bus is being reset for host 0 channel 0.
Feb  4 07:18:37 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  4 07:18:41 Line kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: Request Sense 00 00 00 40 00 
Feb  4 07:18:41 Line kernel: Info fld=0x0, Current sd0b:00: sense key Medium Error
Feb  4 07:18:41 Line kernel:  I/O error: dev 0b:00, sector 184
Feb  4 07:20:09 Line kernel: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 00 2e 00 00 01 00 
Feb  4 07:20:09 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  4 07:20:09 Line kernel: hdb: ATAPI reset complete
Feb  4 07:20:09 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  4 07:20:09 Line kernel: hdb: ATAPI reset complete
Feb  4 07:20:10 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
Feb  4 07:20:10 Line kernel: scsi0 channel 0 : resetting for second half of retries.
Feb  4 07:20:10 Line kernel: SCSI bus is being reset for host 0 channel 0.
Feb  4 07:20:10 Line kernel: hdb: status timeout: status=0xd0 { Busy }
Feb  4 07:20:10 Line kernel: hdb: drive not ready for command
Feb  4 07:20:21 Line kernel: hdb: ATAPI reset complete
Feb  4 07:20:22 Line kernel: Device 0b:00 not ready.
Feb  4 07:20:22 Line kernel:  I/O error: dev 0b:00, sector 184


On Sun, 04 Feb 2001, Marko Kreen wrote:

> On Sat, Feb 03, 2001 at 11:05:44PM +0100, patrick.mourlhon@wanadoo.fr wrote:
> > Hi,
> > 
> > I've never could make this CDRW ATAPI to work, if someone could
> > provide me any clue about the baby. I just said that people on the
> > kernel mailing list may care of its but. It looks like the baby didn't
> > even noticed. ;-)
> 
> Compile in options 'SCSI generic', 'SCSI cdrom and 'SCSI
> emulation support' then add 'hdb=scsi' to kernel parameters.
> 
> Now you can use it as SCSI cdrom, and cd-writers recognize it
> too.  Eg. for cdrecord you should probably put 'dev=0,0,0' to
> command line (I assume you have no other SCSI controller).
> 
> 
> -- 
> marko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
