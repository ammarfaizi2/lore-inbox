Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbSKGBGq>; Wed, 6 Nov 2002 20:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266264AbSKGBGq>; Wed, 6 Nov 2002 20:06:46 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:36502 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S266263AbSKGBGp> convert rfc822-to-8bit; Wed, 6 Nov 2002 20:06:45 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.46: SCSI and/or ReiserFS v3.6 broken? Kernel panic (fwd)
Date: Thu, 7 Nov 2002 02:13:20 +0100
User-Agent: KMail/1.4.7
References: <Pine.LNX.4.02.10211060930300.27381-100000@palpatine.science-computing.de>
In-Reply-To: <Pine.LNX.4.02.10211060930300.27381-100000@palpatine.science-computing.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200211070112.53314.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. November 2002 09:47 schrieb Karsten Weiss:
> Hi Andrew!
>
> > Dieter Nützel wrote:
> > > VFS: Cannot open root device "803" or 08:03
> > > Please append a correct "root=" boot option
> > > Kernel panic: VFS: unable to mount root fs on 08:03
> >
> > That was happening to me yesterday as well.  After a bit
> > of poking around and recompiling, it mysteriously went away.
> >
> > The same has happened about ten times over the past few months,
> > and rebuilding the world makes it go away.  On ext3.
> >
> > Something is definitely fishy.  It's unhelpful that it cures
> > itself just as you get geared up to fix it.
> >
> > Does a full rebuild fix it for you?
>
> For what it's worth (maybe it does ring a bell):
>
> We have the same problem with kernels >=2.4.19 on ext3 partitions. It
> happens in the last line of the SuSE-7.3 initial ramdisk linuxrc script.

OK, it is a SuSE 7.3 based system.
 
> However, if we comment out the last line of linuxrc it works:

I have no "linuxrc" file.

Even without initrd (didn't use it anyway) it do _NOT_ work.

> [...module loading skipped...]
> mount -n -t proc proc /proc
> mount -n -t ext3 /dev/sda4 /mnt
> rm -f /mnt/.initrd 2>/dev/null
> mkdir -p /mnt/.initrd
> cd /mnt
> pivot_root . .initrd
> umount -n /.initrd/proc
> !!!
> exec sh -c 'umount -n /.initrd; rmdir /.initrd ; mount -n -oremount,ro /'
> </dev/console >/dev/console 2>&1 !!!
>
> The affected machines are HP X4000s (dual Xeon, 4 GB RAMBUS, SCSI
> harddisks)

With "pci=noacpi" at the boot prompt I get the aic7xxx "debug mode".
How can I dump such stuff to a screen, file, line printer?
=> SCSI and not ReiserFS

Without 2.5.46 ;-(

-Dieter
