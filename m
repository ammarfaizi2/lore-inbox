Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbTFRKVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265133AbTFRKVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:21:45 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:30700 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265132AbTFRKVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:21:44 -0400
Date: Wed, 18 Jun 2003 12:35:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030618103528.GB203@elf.ucw.cz>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz> <20030618102602.GA593@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618102602.GA593@zip.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Turn it off. You don't want to debug preempt and nfs at the same time.
> > > 
> > > And this is with preempt off:
> > > 
> > > Stopping tasks: XFree86 entered refrigerator
> > > =pdflush entered refrigerator
> > ...
> > > =init entered refrigerator
> > > =procmail entered refrigerator
> > > =|
> > > Freeing memory: .........................|
> > > Syncing disks before copy
> > > Suspending devices
> > > Suspending device c052c48c
> > > Suspending devices
> > > Suspending device c052c48c
> > > suspending: hda ------------[ cut here ]------------
> > > kernel BUG at drivers/ide/ide-disk.c:1110!
> > 
> > Okay, you hit some ide problems, but freezing NFS worked okay. Did you
> > have active NFS mounts at this point?
> 
> Yup. I upgraded to .72 and tried again (using the new taskfile stuff) and
> this time it suspended. On resume though, the framebuffer console wasn't
> really functioning. I had to switch to X and then switch back again before
> it was all groovy.

Thanx.

> Ponderance: Why did it do a full s/w suspend when I asked for the bios
> to handle it? I have s4bios showing up in /proc/acpi/sleep and the bios
> is set to suspend to disk. I've even got an a0 partition fully formatted
> and it still ignored it all.

I don't know, try looking at drivers/acpi/sleep/main.c, and if
neccessary insert some printk()s to see what's going on.

> I was using the following line to activate it:
> 
> echo 4b >/proc/acpi/sleep

That seems right.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
