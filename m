Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293122AbSCSWen>; Tue, 19 Mar 2002 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSCSWeY>; Tue, 19 Mar 2002 17:34:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7428 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293109AbSCSWeE>; Tue, 19 Mar 2002 17:34:04 -0500
Date: Tue, 19 Mar 2002 14:33:27 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Pavel Machek <pavel@suse.cz>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Olivier Galibert <galibert@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020319212130.GG12260@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.10.10203191430520.525-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel,

No, it is called being a "BAD HOST".  Things were added before the
infrastructure was complete to support feature.  Thus the feature is now a
BUG.  Sorry but that is the simple true, one of the reasons why I asked
you to delay but it is not important now.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Tue, 19 Mar 2002, Pavel Machek wrote:

> Hi!
> 
> > > > commands.  With the proper sequencing, you can even do power management 
> > > > of the drives in userspace.  You don't want to do system suspend/resume 
> > > > that way, but you can certainly have a userspace policy daemon running, 
> > > > that powers-down and powers-up the drives, etc.
> > > 
> > > See noflushd, Hdparm is able to powersave disks well, already, and it
> > > was in 2.2.X, too.
> > 
> > Not all of them safely, though. Many a drive will corrupt data if it
> > receives a command when not spinned up. You need to issue a wake command
> > first, which hdparm doesn't, it just leaves it to the kernel to issue a
> > read command or whatever to wake the drive ...
> 
> Is this common disk bug, or are they permitted to behave like that?
> 
> 									Pavel
> -- 
> Casualities in World Trade Center: ~3k dead inside the building,
> cryptography in U.S.A. and free speech in Czech Republic.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

