Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132660AbRDONzL>; Sun, 15 Apr 2001 09:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132659AbRDONzB>; Sun, 15 Apr 2001 09:55:01 -0400
Received: from relay.freedom.net ([207.107.115.209]:6410 "HELO relay")
	by vger.kernel.org with SMTP id <S132658AbRDONyt>;
	Sun, 15 Apr 2001 09:54:49 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQEYOYTStNTVz2tGCQR4barIcm2W0ki/Pyi+zP/VdcidTRiOLHOZM8wf
Date: Sun, 15 Apr 2001 07:53:22 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Writing to Pana DVD-RAM
In-Reply-To: <20010414213259Z132548-682+222@vger.kernel.org> <3AD8CC04.EA5022C1@coplanar.net>
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010415135500Z132658-682+339@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DOH!  You're right.

I can now write to it, but only get one chance.  Copy a file to DVDRAM, read, print, etc, but when I try to rm or mv, segfault.  Foreverafter the DVDRAM is 'busy'.  Cannot umount.  Must reboot then umount.  Remount, get another write, but on subsequent write, segfault.

I am using UDF2. (UDF2.1 won't mount)  Would I be better off with UDF1.2, or FAT32?  How can I get details of the driver's capabilities?
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914



Jeremy Jackson wrote:

> cacook@freedom.net wrote:
>
> > Hello,
> >
> > I am running RedHat Wolverine (beta) with kernel 2.4.2.  I have a SCSI subsystem (AHA2740) with a Panasonic LF-D101 DVDRAM on it.
> >
> > I read that the CDROM driver is built to recognize DVDRAMs and allow writes; well I can mount and read the UDF file system fine, but am not allowed writes.  I have UDF2.0 on the disk, because it didn't recognize UDF2.1.
> >
> > Also, when I  make xconfig,  it includes UDF support, but read-only. (Write-Experimental is grayed-out)
> >
> > In fstab: /dev/scd1 is mounted to /mnt/dvdram  udf  default 0 0. (paraphrasing)
> >
> > I need the DVDRAM for backups and file transfers.  Is the problem the driver, the UDF filesystem, my setup, or what?
> > --
> > C.
> >
> > The best way out is always through.
> >       - Robert Frost  A Servant to Servants, 1914
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> Check that "Experimental " is enabled under "Code Maturity level options",
> if you can't find it try using "make menuconfig" instead of "make xconfig"
> Note that the UDF-write support option is listed as "Dangerous"... possibly
> making things difficult, but then again if you have a DVD-RAM,
> how bad can things be :)
>
> Cheers,
>
> Jeremy




