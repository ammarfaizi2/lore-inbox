Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbTFRKDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFRKDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:03:50 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:8677 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265021AbTFRKDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:03:49 -0400
Date: Wed, 18 Jun 2003 12:17:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: CaT <cat@zip.com.au>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030618101728.GA203@elf.ucw.cz>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618081600.GA484@zip.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I didn't have any actual nfs mounts at the time but I tried it
> > > with an otherwise similar system. It went through, got to freeing
> > > memory, showed me a bunch of fullstops being drawn and then went
> > > into an endless BUG loop. All I could pick out (after many a moment
> > > of staring) was 'schedule in atmoic'.
> > > 
> > > I'll do a proper test with a console cable present in a few days. I
> > > can't atm cos I'm not on the same network and don't have a 2nd 
> > > computer to hook up the null-modem cable to.
> 
> Was able to capture the output for this case (it's long). The result
> without preempt is below this one.

> I hit the power button here and shut the box down.
> 
> > Turn it off. You don't want to debug preempt and nfs at the same time.
> 
> And this is with preempt off:
> 
> Stopping tasks: XFree86 entered refrigerator
> =pdflush entered refrigerator
...
> =init entered refrigerator
> =procmail entered refrigerator
> =|
> Freeing memory: .........................|
> Syncing disks before copy
> Suspending devices
> Suspending device c052c48c
> Suspending devices
> Suspending device c052c48c
> suspending: hda ------------[ cut here ]------------
> kernel BUG at drivers/ide/ide-disk.c:1110!

Okay, you hit some ide problems, but freezing NFS worked okay. Did you
have active NFS mounts at this point?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
