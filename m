Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWCEQ3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCEQ3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWCEQ3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:29:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932172AbWCEQ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:29:07 -0500
Date: Sun, 5 Mar 2006 17:29:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spontaneous reboots with latest 2.6.16 RC-s
Message-ID: <20060305162905.GC20287@stusta.de>
References: <Pine.SOC.4.61.0603021501560.23598@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0603021501560.23598@math.ut.ee>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 03:19:09PM +0200, Meelis Roos wrote:
> I have had 3 spontaneous reboots in last week with 2.6.16-rc[45] 
> timescale kernels. Could be kernel or X or hardware, not sure yet. When 
> they happened, mplayer was used to play some movie fullscreen with 
> Matrox G400 and XVideo (X.org 6.9) and there was slight disk and network 
> activity. This reboot is not reproducible at will, it will only happen 
> sometimes.
> 
> This is a lone home computer so no serial console.
> 
> Plain Duron PC with up-to-date Debian unstable. Have kept it mostly up 
> to date with the exception that I kept using X.org 6.8.2 for a long time 
> before switching to X.org 6.9 - so it might be X problem instead and it 
> might only have surfaced after I restarted after upgrading to X.org 6.9.
> 
> Earlier 2.6.16 RC-s (or git snapshots from that time) were OK, where OK 
> means that I did not see any problems.
> 
> 2.6.16-rc2 was stable for 11 days
> 2.6.16-rc3-g5552... was OK for 2 days
> 2.6.16-rc3-gab47... rebooted
> 2.6.16-rc4-g9e95... rebooted
> 2.6.16-rc5-gb1e2... rebooted (todays snapshot)
> 
> /proc/interrupts, lspci -vvvn and dmesg of a bootup are below. Any ideas 
> if this could be something with a kernel?
>...

It could be, but it could also be hardware.
Does the machine survive a night of memtest86?

Please turn on all debugging options in the kernel.

It's extremely unlikely that it's in any way related, but is this the 
machine you reported the psmouse problems for?

Can you find a pattern that triggers the problem with a nearly 100% 
probability? E.g. "24 hours of mplayer fullscreen"?
If yes, check 2.6.16-rc3-g5552 if it really is OK, and then do a binary 
search for the commit that causes your problem.

> Meelis Roos (mroos@linux.ee)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

