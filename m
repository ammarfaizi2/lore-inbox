Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTJXHMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJXHMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:12:32 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63170
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262037AbTJXHMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:12:30 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Wow.  Suspend to disk works for me in test8. :)
Date: Fri, 24 Oct 2003 02:09:18 -0500
User-Agent: KMail/1.5
Cc: Voicu Liviu <pacman@mscc.huji.ac.il>, linux-kernel@vger.kernel.org
References: <200310200225.11367.rob@landley.net> <200310201556.43520.rob@landley.net> <20031023135523.GE643@openzaurus.ucw.cz>
In-Reply-To: <20031023135523.GE643@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310240209.18678.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 October 2003 08:55, Pavel Machek wrote:
> Hi!
>
> > A couple of down sides I've noticed: I have to run "hwclock --hctosys"
> > after a resume because the time you saved at is the time the system
> > thinks it is when you resume (ouch).  And because of that, things that
> > should time out and renew themselves (like dhcp leases) have to be
> > thumped manually.
>
> I sent fix for that yesterday... but you'd need to fix swsusp.c's
> sysdev handling and mtrr-s => better wait.
> 			Pavel

It's largely working for me.  My laptop's backed up regularly, so I'm not 
risking too much data.  It reliably fails trying to suspend if I close the 
lid, and if I don't close the lid every once in a while the power down step 
won't power down immediately and the sucker will boot back up to the desktop 
and inform me that my dhcp lease file is corrupt, and then suddenly power 
down right from the desktop.  (I reboot and force a full fsck in this 
circumstance.)

I've also had it just hang there, on both suspend and resume, for upwards of 
30 seconds doing nothing I can see until I start holding the power button 
down: after ten seconds it'll hard power off, but after two or three it 
suddenly wakes up and continues with the suspend or resume.  (Suspend usually 
hangs in "snapshotting memory" or something like that.  Resume hangs printing 
........::::::::] at the end of the boot log, right before it would otherwise 
clear the screen and rerun the end of the power down phase.


Odd.  I'm still subscribed to the swsusp list, but stopped reading it some 
time ago because it was all about 2.4 and I haven't run 2.4 in months...

Rob
