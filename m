Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSBCGei>; Sun, 3 Feb 2002 01:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSBCGe2>; Sun, 3 Feb 2002 01:34:28 -0500
Received: from pubnix.org ([204.80.221.10]:24023 "EHLO pubnix.org")
	by vger.kernel.org with ESMTP id <S286303AbSBCGeY>;
	Sun, 3 Feb 2002 01:34:24 -0500
Date: Sun, 3 Feb 2002 01:31:18 -0500 (EST)
From: syzygy <syzygy@pubnix.org>
To: Douglas Gilbert <dougg@torque.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI + IDE = HANG
In-Reply-To: <3C5C2B17.289A3049@torque.net>
Message-ID: <Pine.GSO.4.21.0202030129420.20173-100000@pubnix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the first command sucseeded and my machine seems to be stable with
it...  I then tried the second command and got this...

/dev/hdd:
 setting using_dma to 1 (on)
 setting xfermode to 34 (multiword DMA mode2)
 HDIO_DRIVE_CMD(setxfermode) failed: Input/output error
 using_dma    =  1 (on)

I noted that it turned dma back on and left 32 bit alone...  but the xfer
mode seemed to fail...  it does jhowever still seem stable...  thoughts?



Keith Baker	
Email:	Syzygy@pubnix.org

Life is a sexually transmitted disease with 100% mortality. 

On Sat, 2 Feb 2002, Douglas Gilbert wrote:

> Keith Baker wrote:
> >I  have had a few random hangs with my machine since I added a maxtor 27
> > gig IDE drive to it.  I kept trying different combinations of bus
> > positions etc.  I figured it was flacky hardware or something.  I added
> > the drive in the early 2.4 series.  Recently I became slightly suspicious
> > of my Adaptec 2940U2W after reading all of the problems it had in the
> > early 2.4.  So I upgraded the bios and got kernel 2.4.17.  Though the
> > problem seems diminished it is certainly not gone...
> > 
> > Now for the kicker...  I found a 99% guarenteed way to hard lock my
> > box.  I tried ripping two cds at a time.  One on the ide bus and one on
> > the scsi.  Just a note the data is being stored to the maxtor 27 gig
> > mentioned above.  The reason I point to the IDE + SCSI combo is that I can
> > do two scsi cdroms ripping to the maxtor and it works much more
> > reliably.  I am under the impression that IDE CDROMs use the ide bus quite
> > heavily under ripping...
> 
> Keith,
> Does turning off (or reducing the speed of) DMA to the
> IDE cdrom with either one of these commands help?
>     hdparm -d0 -c1 /dev/hdd 
>     hdparm -d 1 -X 34 /dev/hdd
> [This assumes the IDE cdrom is connected to /dev/hdd.]
> 
> Doug Gilbert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

