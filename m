Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135859AbRDTLAp>; Fri, 20 Apr 2001 07:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135860AbRDTLAd>; Fri, 20 Apr 2001 07:00:33 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:51474 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135859AbRDTLAV>;
	Fri, 20 Apr 2001 07:00:21 -0400
From: thunder7@xs4all.nl
Date: Fri, 20 Apr 2001 12:44:16 +0200
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: [lkml]Re: ac10 ide-cd oopses on boot
Message-ID: <20010420124416.A658@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010420004914.A1052@werewolf.able.es> <E14qNWF-0008Jc-00@the-village.bc.nu> <20010420013429.A1054@werewolf.able.es> <20010419223850.A2177@nostromo.devel.redhat.com> <3ADFA532.CAEE58BB@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3ADFA532.CAEE58BB@home.com>; from ledzep37@home.com on Thu, Apr 19, 2001 at 09:55:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 09:55:46PM -0500, Jordan wrote:
> Bill Nottingham wrote:
> > 
> > J . A . Magallon (jamagallon@able.es) said:
> > > > Can you back out the ide-cd changes Jens did and see if that fixes it ?
> > >
> > > Reverted the changes in ide-cd.[hc], and same result.
> > 
> > You want to back out the stuff from drivers/cdrom/cdrom.c; I backed
> > out the parts of the patch new there to ac10, and it worked again
> > for me...
> > 
> That worked here as well...here is a patch that should restore
> linux/drivers/cdrom/cdrom.c back to its working ac9 state from ac10.
> 
<snip patch; can be found on lkml>

2.4.3-ac10 wouldn't boot for me without this patch.
I have only scsi cdrom(s) on an symbios 860:

Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-R412C  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: SONY     Model: SDT-5000         Rev: 330B
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-M1401 Rev: 1008
  Type:   CD-ROM                           ANSI SCSI revision: 02

With this patch, it boots just fine.

Good luck,
Jurriaan
-- 
And all the while, all the while, I still hear that call
To the land of gold and poison that beckons to us all
Do you think you're so brave just to go running to that which beckons to us all?
	New Model Army - Valleys of Green and Grey
GNU/Linux 2.4.3-ac10 SMP/ReiserFS 2x1743 bogomips load av: 0.20 0.05 0.01
