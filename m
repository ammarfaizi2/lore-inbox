Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272415AbRIRQJd>; Tue, 18 Sep 2001 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272467AbRIRQJY>; Tue, 18 Sep 2001 12:09:24 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:49930 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S272415AbRIRQJP>; Tue, 18 Sep 2001 12:09:15 -0400
Message-ID: <3BA771A8.D2C26AEF@MissionCriticalLinux.com>
Date: Tue, 18 Sep 2001 09:09:12 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-bcb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wojtek Pilorz <wpilorz@bdk.pl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
        Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <Pine.LNX.4.21.0109181248480.22180-100000@celebris.bdk.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wojtek Pilorz wrote:
> >
> > I do not think the disk is missing data or that there are any bad
> > blocks.  The reason I say this is because I can access every file on the
> > disk when the CD is mounted as an iso9660 file system on a 2.2.19
> > kernel.  I compared the files with the originals and they are identical.
> Maybe it is not a single session disk?
> 
> Could you try
> cdrecord -toc dev=x,y
> where x,y are numbers returned for your SCSI (either native or emulated)
> device by
>  cdrecord -scanbus
> 
> I have never played with multisession disks so far, but I don't think dd
> could read anything more than the first track ...
> 
> >
> > The only reason I found out dd would not copy the disk is because Masoud
> > asked for an image.
> > I tried using dd to copy a much larger CD (150 Mb) and it fails at the
> > same place and the resulting file is the same size (737280 bytes).  So
> > it fails long before the end of the data.
> This would again make me suspect Win software does not produce
> single-session disks ...
> 
> >
> > By the way, dd works fine when copying other CDs that were not created
> > under Windows.
> >
> > Thanks,
> > Bruce
> >
> Best regards,
> 
> Wojtek

When I run the cdrecord -scanbus command I get the following error;
presumably because my CD is not SCSI???

	# cdrecord -scanbus
	Cdrecord 1.8 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
	cdrecord: No such file or directory. Cannot open SCSI driver.
	cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you
are root. 

I suspect you are right about it being a multi-session disk.  That
sounds familiar.  I just double checked, and I cannot find an option in
my Windows software to force a single session disk.  However, if the
disk is multi-session, why can the 2.2.19 kernel could read it?

Thanks
Bruce
-- 
Bruce Blinn                               408-615-9100
Mission Critical Linux, Inc.              blinn@MissionCriticalLinux.com
www.MissionCriticalLinux.com
