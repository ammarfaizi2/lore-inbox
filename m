Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273367AbRIRLEv>; Tue, 18 Sep 2001 07:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273372AbRIRLEl>; Tue, 18 Sep 2001 07:04:41 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:58636 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S273367AbRIRLEe>;
	Tue, 18 Sep 2001 07:04:34 -0400
Date: Tue, 18 Sep 2001 13:04:43 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
        Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA6791A.616636CE@MissionCriticalLinux.com>
Message-ID: <Pine.LNX.4.21.0109181248480.22180-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Bruce Blinn wrote:

> Date: Mon, 17 Sep 2001 15:28:42 -0700
> From: Bruce Blinn <blinn@MissionCriticalLinux.com>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: root@chaos.analogic.com,
>      Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
>      linux-kernel@vger.kernel.org
> Subject: Re: Reading Windows CD on Linux 2.4.6
> 
> Alan Cox wrote:
> > 
> > > Here are the results of the methods that were suggested for producing a
> > > CD image.  They all seem to fail at the same place because the resulting
> > > file is the same size.
> > >
> > >       # dd if=/dev/cdrom of=/tmp/cd1.iso
> > >       dd: /dev/cdrom: Input/output error
> > >       1440+0 records in
> > >       1440+0 records out
> > 
> > Bad CD image - or that is all the data on it. If its bad blocks you can tell
> > dd to continue past bad blocks and pad them with zero - handy for rescueing
> > uncompressed tape backups
> 
> I do not think the disk is missing data or that there are any bad
> blocks.  The reason I say this is because I can access every file on the
> disk when the CD is mounted as an iso9660 file system on a 2.2.19
> kernel.  I compared the files with the originals and they are identical.
Maybe it is not a single session disk?

Could you try
cdrecord -toc dev=x,y
where x,y are numbers returned for your SCSI (either native or emulated)
device by
 cdrecord -scanbus

I have never played with multisession disks so far, but I don't think dd
could read anything more than the first track ...

> 
> The only reason I found out dd would not copy the disk is because Masoud
> asked for an image.
> I tried using dd to copy a much larger CD (150 Mb) and it fails at the
> same place and the resulting file is the same size (737280 bytes).  So
> it fails long before the end of the data.
This would again make me suspect Win software does not produce 
single-session disks ...

> 
> By the way, dd works fine when copying other CDs that were not created
> under Windows.
> 
> Thanks,
> Bruce
> 
Best regards,

Wojtek

