Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264225AbUEHWyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbUEHWyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbUEHWyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:54:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29110 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264225AbUEHWyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:54:02 -0400
Date: Sun, 9 May 2004 00:54:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-ID: <20040508225401.GF29255@atrey.karlin.mff.cuni.cz>
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <20040503123150.GA1188@openzaurus.ucw.cz> <200405042018.23043.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405042018.23043.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm one of the people for whom Patrick's suspend worked and yours didn't.  Now 
> I've been busy with other things for a couple months (Penguicon 2.0 went 
> quite well, by the way), and there's talk of yanking Patrick's suspend code 
> from the kernel.  Right, so I've got to deal with this.  I can't say I'm 
> thrilled, but I DO want to continue to be able to suspend my laptop.
> 
> What kind of debug info do I need to report to get your suspend code fixed, 
> and who do I need to report it to?
> 
> I just tested 2.6.5, which went "boing" trying to suspend with some kind of 
> debug message that gave me a hex number (not a panic, but I didn't have a pen 
> handy, I can try again and write it down if you like.  Anything else I should 
> do?)

Try it with minimal drivers from signle user mode...

> I asked Nigel a few months ago, and he pointed me to an enormous flag day 
> patch that will probably be integrated into the kernel when hell freezes 
> over.  (I have no idea why it's so intrusive, by the way.  Isn't half the 
> point of sysfs and the new 2.6 device infrastructure that finding all the 
> devices that need to be shut up doesn't require the kind of insanity doing it 
> under 2.4 did?

Nigel's refrigerator is way more elaborate and very intrusive, but he
seems to work *always*. Original refrigerator (shared by swsusp and
pmdisk) only tries a bit and eventually gives up if stopping system is
too hard. Hopefully Nigel's code can be simplified.

> I read the docs and read through your code a bit, and every screenful or so it 
> says "this code is guaranteed to eat your data if you look at it funny".  
> I've been using Patrick's suspend code for something like eight months now, 
> and it never ate any of my data.  Failed to resume a few times, but no worse 
> than sync followed by yanking the power cord, fsck did its thing and life 
> went on.  (Yes, I back up regularly.  But I've gotten the distinct impression 
> that you have no faith whatsoever in your own work, and reinstalling and 
> restoring from backups is a real pain, especially when you're on the
> road.)

It did not eat *my* data in last eight months.

If patrick does not warn you, its his problem. If you suspend, mount
your filesytems, do some work and then resume, you are probably going
to do some pretty nasty corruption. Just don't do that.

But this problem is shared by swsusp, swsusp2 *and* pmdisk.

> Sigh.  I _really_ don't have time for this right now.  I wonder if it would be 
> possible to just send Patrick some money?

He's out of time, so money is not likely to help. Sending some money
to Nigel might do the trick ;-).
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
