Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292932AbSCDWPU>; Mon, 4 Mar 2002 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292937AbSCDWPK>; Mon, 4 Mar 2002 17:15:10 -0500
Received: from konza.flinthills.com ([64.39.200.1]:9970 "EHLO
	konza.flinthills.com") by vger.kernel.org with ESMTP
	id <S292932AbSCDWPG>; Mon, 4 Mar 2002 17:15:06 -0500
Subject: [Fwd: Re: Waking up Non-acpi (and non-apm) compliant IDE devices]
From: Derek James Witt <djw@flinthills.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 16:13:00 -0600
Message-Id: <1015279980.2413.4.camel@saiya-jin>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Forwarded Message-----

> From: Derek James Witt <djw@flinthills.com>
> To: Derek James Witt <djw@flinthills.com>
> Subject: Re: Waking up Non-acpi (and non-apm) compliant IDE devices
> Date: 04 Mar 2002 16:02:58 -0600
> 
> Ok, I found out that my drive is picky about which connector plug on the
> cable it is using. In this case, it is now using the middle connector. I
> can suspend and resume without disconnecting that drive. But at any
> rate, I would like to know if resetting the IDE controller is feasible
> (or is driverfs planning to do this anyway)?
> 
> 
> On Mon, 2002-03-04 at 12:52, Derek James Witt wrote:
> > Hey all. I just thought of something for this. I have an older Western
> > Caviar 36400 hard drive that disconnects once the computer goes to
> > sleep.  Currently, I disallow sleep mode for that very reason. But
> > anyway,  I'm curious if it's safe to do a reset of  the IDE controller. 
> > In my case, the drive is currently on primary slave. I moved it from
> > secondary master.   
> > 
> > Right now, I fear if I hard-reset the IDE controller (a Via 686
> > UDMA100), I might also disconnect the primary master (Quantum fireball
> > 6.4SE). That will render my box useless until I hit the the reset
> > button.  But, if I do a soft-reset, the caviar may not wake up. I know
> > the quantum will wake up fine upon a soft-reset and upon resume of the
> > system.  I'm going to try putting in interrupt 15 (secondary IDE) as a
> > primary power event in my bios and see if that can wake up the drive.
> > 
> > 
> > Oh, if you're curious, here is my fstab:
> > 
> > # /etc/fstab: static file system information.
> > #
> > # <file system>	<mount point>	<type>	<options>	<dump>	<pass>
> > /dev/hda6	/		xfs	defaults	1	1
> > /dev/hda5	/boot		xfs	defaults	1	1
> > /dev/hda7	/home		xfs	defaults	1	1
> > /dev/hdb3	/usr		xfs	defaults	1	1
> > /dev/hda9	/usr/local	xfs	defaults	1	1
> > 
> > /dev/hda8	none		swap	sw		0	0
> > /dev/hdb2	none		swap	sw		0	0
> > 
> > proc		/proc		proc	defaults	0	0
> > 
> > /dev/fd0	/floppy		auto	defaults,user,noauto	0	0
> > 
> > /dev/sr0	/cdrom		auto	defaults,ro,user,noauto	0	0
> > /dev/sr1	/cdrw		auto	defaults,ro,user,noauto	0	0
> > 
> > tmpfs		/dev/shm	tmpfs	defaults	0		0
> > 
> > /dev/hda1	/win2k		ntfs	defaults,ro,user,uid=cappicard	0	0
> > /dev/hdb1	/win2k-driveE	ntfs	defaults,ro,user,uid=cappicard	0	0
> > 
> > As you probably see, if my caviar (hdb) disconnects, I'm pretty-much SOL
> > if  I try to run X or any programs from /usr/*. And I have to resort to
> > SysRq to reboot the box (I hate finding a pen to hit the reset button). 
> > 
> > I'll let you know what I find out.
> > 
> > -- 
> > **  Derek J Witt                                              **
> > *   Email: mailto:djw@flinthills.com                           *
> > *   Home Page: http://www.flinthills.com/~djw/                 *
> > *** "...and on the eighth day, God met Bill Gates." - Unknown **
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> **  Derek J Witt                                              **
> *   Email: mailto:djw@flinthills.com                           *
> *   Home Page: http://www.flinthills.com/~djw/                 *
> *** "...and on the eighth day, God met Bill Gates." - Unknown **
