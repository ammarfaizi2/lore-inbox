Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRBAXds>; Thu, 1 Feb 2001 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbRBAXdi>; Thu, 1 Feb 2001 18:33:38 -0500
Received: from tools.cfourusa.com ([209.254.33.11]:51341 "EHLO tools.c4usa.com")
	by vger.kernel.org with ESMTP id <S131018AbRBAXd3>;
	Thu, 1 Feb 2001 18:33:29 -0500
Message-ID: <017c01c08ca7$49b3a170$1a21fed1@ASHAMAN>
From: "Dan Egli" <dan@frankenstein-cpu.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: Modules and DevFS
Date: Thu, 1 Feb 2001 16:32:48 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just edited my rc.local file to add symlinks of the old names to the files
of the new names. Works great for my purposes.

-- Dan Egli
----- Original Message -----
From: "Michael B. Trausch" <fd0man@crosswinds.net>
To: "William Knop" <w_knop@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, January 31, 2001 3:56 PM
Subject: Re: Modules and DevFS


> On Thu, 1 Feb 2001, William Knop wrote:
> >
> > >One thing that I've noticed with devfs is that all the old-style names
are
> > >symlinks.
> >
> > Hmm... I have no symlinks until the module loads. Therefore X sees no
> > /dev/input/mouse, doesn't ask the kernel for it, the kernel doesn't load
the
> > module, and DevFS doesn't add the /dev entry. There's got to be an easy
way
> > around this. Perhaps it has already been implimented, but I haven't been
> > able to get anything to work well (manual loading for me).
> >
>
> As I understand it, devfsd, the daemon that you should have installed and
> use with devfs (at least until all old-style device names are gone), is
> what puts the compatability symlinks in there.  DevFS, if you tell it to
> mount at kernel boot, (which you should), provides the actual device
> inodes, for example:  /dev/tts/*, /dev/pty/*, /dev/vc/*, etc.
>
> DevFSd provides symlinks as follows:
>
> /dev/ttyS0 = /dev/tts/0
> /dev/tty0 = /dev/vc/0
> /dev/pty* = /dev/pty/*
>
> Until programs use the new names (e.g., init should tell getty to use
> /dev/vc/0 instead of /dev/tty0), and everything on the system doesn't need
> support for the old-style names, you need to use devfsd and
> such.
>
> I can't say that other than naming things and installing the daemon, I've
> nto had any problems with modules and whatnot.  Maybe you'll be forced to
> a solution that Documentation/filesystems/devfs/README presents for those
> who need a device there - You may have to create a device inode manually
> via a startup script at bootup... You should read that file for more
> details.
>
> - Mike
>
>
===========================================================================
> Michael B. Trausch
fd0man@crosswinds.net
> Avid Linux User since April, '96!                           AIM:
ML100Smkr
>
>               Contactable via IRC (DALNet) or AIM as ML100Smkr
>
===========================================================================
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
