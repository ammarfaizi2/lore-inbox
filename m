Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273723AbRIQW2x>; Mon, 17 Sep 2001 18:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273722AbRIQW2o>; Mon, 17 Sep 2001 18:28:44 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:57616 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S273723AbRIQW23>; Mon, 17 Sep 2001 18:28:29 -0400
Message-ID: <3BA6791A.616636CE@MissionCriticalLinux.com>
Date: Mon, 17 Sep 2001 15:28:42 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-bcb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: root@chaos.analogic.com,
        Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <E15j68m-0007wc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Here are the results of the methods that were suggested for producing a
> > CD image.  They all seem to fail at the same place because the resulting
> > file is the same size.
> >
> >       # dd if=/dev/cdrom of=/tmp/cd1.iso
> >       dd: /dev/cdrom: Input/output error
> >       1440+0 records in
> >       1440+0 records out
> 
> Bad CD image - or that is all the data on it. If its bad blocks you can tell
> dd to continue past bad blocks and pad them with zero - handy for rescueing
> uncompressed tape backups

I do not think the disk is missing data or that there are any bad
blocks.  The reason I say this is because I can access every file on the
disk when the CD is mounted as an iso9660 file system on a 2.2.19
kernel.  I compared the files with the originals and they are identical.

The only reason I found out dd would not copy the disk is because Masoud
asked for an image.
I tried using dd to copy a much larger CD (150 Mb) and it fails at the
same place and the resulting file is the same size (737280 bytes).  So
it fails long before the end of the data.

By the way, dd works fine when copying other CDs that were not created
under Windows.

Thanks,
Bruce
