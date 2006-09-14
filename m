Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWINTHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWINTHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWINTHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:07:25 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:6295 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751035AbWINTHY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:07:24 -0400
From: Philippe Grenard <philippe.grenard@m4x.org>
Reply-To: philippe.grenard@m4x.org
To: Tejun Heo <htejun@gmail.com>
Subject: Re: (Another?) Seagate / Sil3112a problem...
Date: Thu, 14 Sep 2006 21:07:21 +0200
User-Agent: KMail/1.9.4
References: <J5J0S1$E84BD2336C01F896088E954AAF120859@laposte.net> <45096B80.3040303@gmail.com>
In-Reply-To: <45096B80.3040303@gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609142107.21940.philippe.grenard@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 14 septembre 2006 16:47, vous avez écrit :
> philippe.grenard wrote:
> [--snip--]
>
> > Seagate 7200.8 drive.
> > Well, all went well for a week or two, but then the drive
> > began to make strange noises, and i got some weird messages
> > from dmesg output...
> > I feared a drive failure, so I made a full Seagate diagnoses
> > of the disk, but no errors...
> > Well, maybe I got bad luck with that drive, so I decided to
> > get another one. I took another Seagate, 250Go, 7200.10 this time.
> >
> > I put this new Seagate (let's call it S_new, the other being
> > S_old) to the first connector of the Sil 3112a chip, and put
> > the "old" one on the second connector : thus I have sda for
> > S_new, and sdb for S_old...
> >
> > What is really surprising, is that i still got issues with
> > sda, but none with sdb... so the believed faulty drive is not,
> > as i got no dmesg errors from sdb...
> >
> > thus i suspect either a faulty controller, or a problem with
> > the driver (sata_sil) i use...(or even something with IRQ as I
> > don't understand anything with IRQ...)
> > I tried to put both disks numbers in the "blacklist" in
> > sata_sil.c, but apart from a degraded speed, it didn't do
> > anything...
>
> Don't do that.  It has nothing to do with your problem.
>
> > The other observation I made, was that these problems happens
> > only when the computer is still "cold" : I mean, after an hour
> > or two, no problem with this... and even if i reboot (I really
> > mean reboot, not halt and restart : when the power still turns
> > on), i got no problem...
> >
> > Well since I use my computer for Desktop, it really is an
> > issue for me at the moment, especially when the disk is making
> > a noise...
> >
> > I'm on Linux for about 2 or 3 years now, under Debian/SID,
> > with kernel 2.6.17.13 from kernel.org (self-compiled)
> >
> > Here is the output of dmesg if it helps...
> > I can provide any information you would find useful, even make
> > some tests, but if you could be not too technical, that would
> > really be great, as I'm a real noob with Hardware problems...
> >
> > Any help/links/infos/hints would really be appreciated!
> > I've already googled a lot and found that Seagate/sil3112a is
> > a problematic couple, but i didn't find any solution for that...
> > I'll try this evening with an older kernel (if you have any
> > suggestion for a kernel version...) to see if it's not related
> > to a kernel upgrade...
>
> All recent Seagate drives work fine w/ sil3112.  Only some old models of
> .7 drives are problematic.
>
> > EXT3-fs: unable to read superblock
> > ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xec timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
> > ata1: command 0xb0 timeout, stat 0xd0 host_stat 0x0
> > ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ
> > 0xb/47/00
> > ata1: status=0xd0 { Busy }
>
> You'll probably get better result with 2.6.18-rc7 which includes new
> libata error handling and more detailed diagnostic messages.  However,
> your problem seems to be hardware issue.  Probably the controller or the
> cable.
>
> I think your link is just flaky enough to cause problem from time to
> time and even when it does it oscillates between link established and
> broken.  Such condition can cause rapid continuous hardresets to the
> attached device, which, depending on drive, can result in weird noise.
>
> So, several things to try...
>
> * make sure the cables are well-plugged
>
> * if you have a spare, swap cables.  if not, swap the first and second
> cable and see what happens.
>
> * if the problem still persists && it doesn't follow the cable (ie. you
> swapped the first and second cable but the first port still fails), your
> controller or circuits on board is the problem.  Buy a add-on card, it's
> really cheap these days.

Thanks for these tips! I'll try it asap...
I thought to buy an add-on card too, but i wanted to avoid as possible the 
same sil 3112a controller...
which card(s) or manufacturer would you recommend for a Linux use?

thanks again for the help!

Philippe
