Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUIJJoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUIJJoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIJJoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:44:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62092 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267310AbUIJJos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:44:48 -0400
Date: Fri, 10 Sep 2004 11:44:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com
Subject: Re: FYI: my current bigdiff
Message-ID: <20040910094448.GD11281@atrey.karlin.mff.cuni.cz>
References: <20040909134421.GA12204@elf.ucw.cz> <20040910041320.DF700E7504@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910041320.DF700E7504@voldemort.scrye.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pavel> Hi!  This is my bigdiff. It is not for inclusion (I'll have to
> Pavel> split it), but it contains some usefull code (I believe :-).
> 
> Pavel> Oh, it speeds up swsusp quite a lot.
> 
> Indeed it does. 
> 
> After 42 days of uptime with 2.6.8-rc2-mm1 I decided to upgrade. 
> swsusp was very stable, but was getting slower and slower. Eariler
> tonight I suspended and it took about 15min to finish suspending. 
> 
> So, I built a new 2.6.9-rc1-mm4 + this bigdiff for swsusp. 
...
> After that first suspend/resume:
> 
> Sep  9 21:35:28 voldemort kernel: Stopping tasks: ====================================|
> Sep  9 21:35:28 voldemort kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H
> \^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-
> ^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^
> H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^Hdone (44436 pages freed)
> 
> (BTW, that looks pretty nasty in the logs, even though it's very nice
> to watch)

Hmm, not sure how to solve this. It does not look *that* bad in the
logs, I believe.

> Sep  9 21:36:13 voldemort kernel: eth1: mgt_commit: failure
> Sep  9 21:36:13 voldemort kernel: eth1: interface reset complete
> 
> Seems the usb and prism54 didn't play nice. 
> 
> After booting with the pci=routeirq as suggested wireless and usb
> played nice on suspend resume again. 

Good.

> I am copying this to the email address that is mentioned. 
> 
> So, after that glitch:
> 
> - - The display is much nicer. Congrats. 
> 
> - - Speed does seem to be nicer. It's taking me 40 seconds to do a
> complete suspend/resume cycle. 
> 
> - - Should PREEMPT and/or HIMEM work with this version? I can test them
> if support has been added/fixed/tweaked for them. 

Both should work.

> I have only done a few cycles, but it looks nice and stable. I would
> suggest you break it into smaller patches and get it applied. 
> Being applied to the main tree would be nice. 

I'm working on that, believe me.
								Pavel
