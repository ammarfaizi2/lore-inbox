Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSKMOKT>; Wed, 13 Nov 2002 09:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSKMOKT>; Wed, 13 Nov 2002 09:10:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62992 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261463AbSKMOKS>; Wed, 13 Nov 2002 09:10:18 -0500
Date: Wed, 13 Nov 2002 15:17:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
Message-ID: <20021113141705.GJ10168@atrey.karlin.mff.cuni.cz>
References: <20021112175154.GA6881@elf.ucw.cz> <200211121801.gACI1ro25294@devserv.devel.redhat.com> <20021113134208.GD10168@atrey.karlin.mff.cuni.cz> <1037197942.11996.67.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
In-Reply-To: <1037197942.11996.67.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > As of obsolete... It is doing power managment outside of sysfs
> > framework... Which is not how it should be done.
> > 
> > > > +	do_idedisk_standby(drive);
> > > >  	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
> > > >  		if (do_idedisk_flushcache(drive))
> > > >  			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
> > > 
> > > What locking rules are you using here ?
> 
> flushcache takes the ide lock which is already held at that point. The
> code splits the unregister/standby path in two so that the unregister
> doesnt deadlock
> 
> > Linus actually asked me for the patch, and discussion about it was
> > public, then he silently droped it. This was "only" retransmit.
> 
> Ok.
> 
> I think your flushcache thing is safe in the new code, and I'm more than
> happy for the PM changes against the new code to use sysfs to go into
> the tree. 2.5.47-ac2 has pretty current ide - there isnt anything going
> to get moved around dramatically again just yet (I wamt to move the
> disk, tape, floppy,... drivers into a subdir later but not yet)

So, if I do basically same patch, but against 2.5.47-ac2 and submit it
to you, it might actually be acceptable? If so its good news.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
