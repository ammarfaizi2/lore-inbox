Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291835AbSBHVMz>; Fri, 8 Feb 2002 16:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291826AbSBHVMq>; Fri, 8 Feb 2002 16:12:46 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:48901 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S291835AbSBHVM0>;
	Fri, 8 Feb 2002 16:12:26 -0500
Date: Fri, 8 Feb 2002 11:50:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org
Subject: Re: Warning, 2.5.3 eats filesystems
Message-ID: <20020208105050.GA175@elf.ucw.cz>
In-Reply-To: <20020206233051.GA503@chiara.cavy.de> <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0202061836450.22680-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> > > > beware.
> > 
> > > I can confirm that there are filesystem corruption issues with 2.5.3;
> > > after this message I rebooted and did a forced fsck which turned up
> > > around a half dozen inodes where the block count in the inode itself was
> > > too high.
> > 
> > Exactly the same thing here, and I bet it _is_ 2.5.3 and not a relict from
> > a 2.5.3-pre patch because I switched directly from 2.4.17 to 2.5.3
> > without ever using any pre patch at this machine.
> 
> Very interesting.  Which filesystems are mounted (other than ext2) and
> are you been able to reproduce it on 2.5.3-pre6?

For me, mounted filesystems look like this:

none on /proc type proc (rw)
none on /proc type proc (rw)
none on /proc type proc (rw)
/dev/hda3 on /suse type ext2 (rw)
none on /proc type proc (rw)
none on /proc/bus/usb type usbdevfs (rw)
/dev/cfs0 on /overlay type coda (rw)

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
