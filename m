Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTFRKLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 06:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTFRKLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 06:11:24 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:39309 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S265128AbTFRKLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 06:11:21 -0400
Date: Wed, 18 Jun 2003 20:26:02 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030618102602.GA593@zip.com.au>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618101728.GA203@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 12:17:28PM +0200, Pavel Machek wrote:
> > > Turn it off. You don't want to debug preempt and nfs at the same time.
> > 
> > And this is with preempt off:
> > 
> > Stopping tasks: XFree86 entered refrigerator
> > =pdflush entered refrigerator
> ...
> > =init entered refrigerator
> > =procmail entered refrigerator
> > =|
> > Freeing memory: .........................|
> > Syncing disks before copy
> > Suspending devices
> > Suspending device c052c48c
> > Suspending devices
> > Suspending device c052c48c
> > suspending: hda ------------[ cut here ]------------
> > kernel BUG at drivers/ide/ide-disk.c:1110!
> 
> Okay, you hit some ide problems, but freezing NFS worked okay. Did you
> have active NFS mounts at this point?

Yup. I upgraded to .72 and tried again (using the new taskfile stuff) and
this time it suspended. On resume though, the framebuffer console wasn't
really functioning. I had to switch to X and then switch back again before
it was all groovy.

Ponderance: Why did it do a full s/w suspend when I asked for the bios
to handle it? I have s4bios showing up in /proc/acpi/sleep and the bios
is set to suspend to disk. I've even got an a0 partition fully formatted
and it still ignored it all.

I was using the following line to activate it:

echo 4b >/proc/acpi/sleep

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
