Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129761AbQK3Ew5>; Wed, 29 Nov 2000 23:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130235AbQK3Evr>; Wed, 29 Nov 2000 23:51:47 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129932AbQK3Ev1>;
        Wed, 29 Nov 2000 23:51:27 -0500
Message-ID: <20001129225210.A10380@bastion.sprileet.net>
Date: Wed, 29 Nov 2000 22:52:10 -0600
From: Damacus Porteng <kernel@bastion.yi.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
In-Reply-To: <20001129191402.F5891@garloff.etpnet.phys.tue.nl> <Pine.LNX.4.10.10011291025411.1743-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <Pine.LNX.4.10.10011291025411.1743-100000@master.linux-ide.org>; from Andre Hedrick on Wed, Nov 29, 2000 at 10:27:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre:

Is that to say that I'd experience this problem with any EIDE CDRW used on one
of the HPT366 channels, or is it to say that only several CDRWs aren't
supported under this chipset?

Also, in regards to Kurt, I wasn't running the CDRW on the same channel as the
source.

Intel PIIX4		HPT366
-----------		------
/dev/hda (CDRW, worked)	/dev/hde (boot: 36.5G)
/dev/hdb		/dev/hdf (storage: 61.4G)
/dev/hdc		/dev/hdg (CDRW, failed)
/dev/hdd		/dev/hdh

In the crashing setup, the boot drive was /dev/hde, source drive was /dev/hdf.
CDRW was /dev/hdg (Second channel, master.)  In the working setup, boot and
source were the same, CDRW was moved to hda.

Regards,

Damacus Porteng

On Wed, Nov 29, 2000 at 10:27:17AM -0800, Andre Hedrick wrote:
> On Wed, 29 Nov 2000, Kurt Garloff wrote:
> 
> > Strange. If you read data from the harddisk on an IDE channel and write it
> > (with cdrecord) to some CDRW on the same IDE channel, you have to expect
> > trouble: As with IDE there is no disconnect from the bus (as opposed to
> > SCSI), you risk buffer underruns. 
> > A lockup however is not to be expected :-(
> 
> It is completely expected bacause of teh active timing changes done on
> this chipset design.  The timings are for ATA DMA and not ATAPI.
> You should expect a 100% hardlock on mistimed IO access.
> 
> Cheers,
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Damnit, Linus, I'm a network admin, not a kernel hacker!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
