Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292337AbSBBSJV>; Sat, 2 Feb 2002 13:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292336AbSBBSJM>; Sat, 2 Feb 2002 13:09:12 -0500
Received: from gear.torque.net ([204.138.244.1]:22291 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S292332AbSBBSJD>;
	Sat, 2 Feb 2002 13:09:03 -0500
Message-ID: <3C5C2B17.289A3049@torque.net>
Date: Sat, 02 Feb 2002 13:08:23 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: syzygy <syzygy@pubnix.org>, linux-kernel@vger.kernel.org
Subject: Re: SCSI + IDE = HANG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Baker wrote:
>I  have had a few random hangs with my machine since I added a maxtor 27
> gig IDE drive to it.  I kept trying different combinations of bus
> positions etc.  I figured it was flacky hardware or something.  I added
> the drive in the early 2.4 series.  Recently I became slightly suspicious
> of my Adaptec 2940U2W after reading all of the problems it had in the
> early 2.4.  So I upgraded the bios and got kernel 2.4.17.  Though the
> problem seems diminished it is certainly not gone...
> 
> Now for the kicker...  I found a 99% guarenteed way to hard lock my
> box.  I tried ripping two cds at a time.  One on the ide bus and one on
> the scsi.  Just a note the data is being stored to the maxtor 27 gig
> mentioned above.  The reason I point to the IDE + SCSI combo is that I can
> do two scsi cdroms ripping to the maxtor and it works much more
> reliably.  I am under the impression that IDE CDROMs use the ide bus quite
> heavily under ripping...

Keith,
Does turning off (or reducing the speed of) DMA to the
IDE cdrom with either one of these commands help?
    hdparm -d0 -c1 /dev/hdd 
    hdparm -d 1 -X 34 /dev/hdd
[This assumes the IDE cdrom is connected to /dev/hdd.]

Doug Gilbert
