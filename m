Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKMNfT>; Wed, 13 Nov 2002 08:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261365AbSKMNfT>; Wed, 13 Nov 2002 08:35:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48908 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261339AbSKMNfS>; Wed, 13 Nov 2002 08:35:18 -0500
Date: Wed, 13 Nov 2002 14:42:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@redhat.com>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
Message-ID: <20021113134208.GD10168@atrey.karlin.mff.cuni.cz>
References: <20021112175154.GA6881@elf.ucw.cz> <200211121801.gACI1ro25294@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211121801.gACI1ro25294@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This code in ide is obsolete and unused. I have followup patch to
> > integrate IDE into sysfs. Please apply,
> 
> The code is not obsolete, it is not unused.

Can you point out what uses it? I certainly could not find it and
killing standby/etc produced no compilation errors.

As of obsolete... It is doing power managment outside of sysfs
framework... Which is not how it should be done.

> > +	do_idedisk_standby(drive);
> >  	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
> >  		if (do_idedisk_flushcache(drive))
> >  			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
> 
> What locking rules are you using here ?

I did not change the code, it works exactly as it did before (ide disk
is never ATAPI device). If it is broken then sorry (but it was broken
before).

> Linus please reject this patch. Its just getting in the way of actually
> fixing the IDE code properly.

Linus actually asked me for the patch, and discussion about it was
public, then he silently droped it. This was "only" retransmit.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
