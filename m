Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292888AbSCSV4i>; Tue, 19 Mar 2002 16:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292971AbSCSV42>; Tue, 19 Mar 2002 16:56:28 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:59273 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S292888AbSCSV4U>;
	Tue, 19 Mar 2002 16:56:20 -0500
Date: Tue, 19 Mar 2002 22:56:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Olivier Galibert <galibert@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020319225609.A12655@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com> <3C8D69E3.3080908@mandrakesoft.com> <20020311223439.A2434@zalem.nrockv01.md.comcast.net> <3C8D8061.4030503@mandrakesoft.com> <20020314141342.B37@toy.ucw.cz> <3C91D571.5070806@mandrakesoft.com> <20020318192004.GB194@elf.ucw.cz> <20020319102926.B9997@ucw.cz> <20020319212130.GG12260@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 10:21:30PM +0100, Pavel Machek wrote:
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

This behavior is permitted by the specification, as far as I know -
results of commands other than wakeup (and other pm commands) in sleep
or suspend mode are undefined ...

-- 
Vojtech Pavlik
SuSE Labs
