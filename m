Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUJNJOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUJNJOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269995AbUJNJOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:14:15 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:27334 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266603AbUJNJNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:13:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: Linux-2.6.8 Hates DOS partitions
Date: Thu, 14 Oct 2004 11:14:57 +0200
User-Agent: KMail/1.6.2
Cc: Andries Brouwer <aebr@win.tue.nl>
References: <Pine.LNX.4.61.0410131329110.3818@chaos.analogic.com> <20041013213519.GA3379@pclin040.win.tue.nl> <Pine.LNX.4.61.0410131833370.12624@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410131833370.12624@chaos.analogic.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410141114.57224.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 of October 2004 00:51, Richard B. Johnson wrote:
> On Wed, 13 Oct 2004, Andries Brouwer wrote:
> 
> > On Wed, Oct 13, 2004 at 01:31:34PM -0400, Richard B. Johnson wrote:
> >
> >> Only the DOS partitions and the swap are used in this new configuration.
> >> This is a new "Fedora Linux 2" installation on a completely
> >> different IDE hard disk, in which I have to enable boot disks in
> >> the BIOS to boot the new system.
> >>
> >> Immediately after installing the new system I reverted (in the BIOS)
> >> to the original to make sure that I was still able to boot the old
> >> system and the DOS partition. Everything was fine.
> >>
> >> Then I installed linux-2.6.8 after building a new kernel with
> >> the old ".config" file used as `make oldconfig`. Everything was
> >> fine after that, also.
> >>
> >> I have now run for about a week and I can't boot the DOS partition
> >> anymore!
> >>
> >> I can copy everything  from C: and D: from within Linux
> >> and then re-do the DOS partitions, BUT.... bad stuff
> >> will happen again unless the cause is found.
> >
> > Well, if you do and the same thing happens, we know that there is 
something
> > reproducible here. That is always good to know. It might be that you did
> > something a week ago and forgot all about it and now have a strange bug.
> >
> > If this is reproducible, then there are lots of possible explanations.
> >
> > Have you considered the numbering of the disks? You changed things in
> > the BIOS. Did the Linux SCSI disk numbering remain the same?
> >
> > Andries
> >
> 
> I just had to reinstall the "Fedora Linux 2" release from scratch the
> second time. What it does is, even though I told it to leave my
> SCSI disks alone, and even though I bought a new ATA Disk just for
> it, and even though I carefully told the installation program to
> use ONLY /dev/hda... Guess what? It installed a piece of GRUB
> on my first SCSI, /dev/sda, where the LILO boot-loader for DOS
> and linux-2.4.26 exists! It looks like it put it in a partition
> table!
> 
> So, every time I install a new Linux version, GRUB writes something
> else there. Eventually it probably gets big enough to make the DOS D: 
> partition go away, and soon DOS drive C: becomes unbootable. I can't
> find any other reason.

AFAICT, there is a bug either in the version of GRUB that is distributed with 
FC2 or in the FC2 installer.  I've heard people complaining that the FC2 GRUB 
prevents WinXP from booting when installed, although I've installed SuSE 
along with XP for many times with no such problems.

The workaround seems to be not to install GRUB and use LILO if you need a 
dual-boot system with FC2.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
