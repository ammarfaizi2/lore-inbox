Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTJXH4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTJXH4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:56:21 -0400
Received: from gprs146-220.eurotel.cz ([160.218.146.220]:42113 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262106AbTJXH4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:56:15 -0400
Date: Fri, 24 Oct 2003 09:56:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Voicu Liviu <pacman@mscc.huji.ac.il>, linux-kernel@vger.kernel.org
Subject: Re: Wow.  Suspend to disk works for me in test8. :)
Message-ID: <20031024075600.GC1519@elf.ucw.cz>
References: <200310200225.11367.rob@landley.net> <200310201556.43520.rob@landley.net> <20031023135523.GE643@openzaurus.ucw.cz> <200310240209.18678.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310240209.18678.rob@landley.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > A couple of down sides I've noticed: I have to run "hwclock --hctosys"
> > > after a resume because the time you saved at is the time the system
> > > thinks it is when you resume (ouch).  And because of that, things that
> > > should time out and renew themselves (like dhcp leases) have to be
> > > thumped manually.
> >
> > I sent fix for that yesterday... but you'd need to fix swsusp.c's
> > sysdev handling and mtrr-s => better wait.
> > 			Pavel
> 
> It's largely working for me.  My laptop's backed up regularly, so I'm not 
> risking too much data.  It reliably fails trying to suspend if I close the 
> lid, and if I don't close the lid every once in a while the power down step 
> won't power down immediately and the sucker will boot back up to the desktop 
> and inform me that my dhcp lease file is corrupt, and then suddenly power 
> down right from the desktop.  (I reboot and force a full fsck in this 
> circumstance.)

Well, this looks like ACPI problems to me. You might want to set it to
reboot and hit powerswitch manually.

> I've also had it just hang there, on both suspend and resume, for upwards of 
> 30 seconds doing nothing I can see until I start holding the power button 
> down: after ten seconds it'll hard power off, but after two or three it 
> suddenly wakes up and continues with the suspend or resume.  (Suspend usually 
> hangs in "snapshotting memory" or something like that.  Resume hangs printing 
> ........::::::::] at the end of the boot log, right before it would otherwise 
> clear the screen and rerun the end of the power down phase.

Not sure what is going on there.

I have similar hangs on omnibook xe3 when I do not load ohci driver
(but they happen during regular operation)....

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
