Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWIFTmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWIFTmK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWIFTmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:42:09 -0400
Received: from outmx019.isp.belgacom.be ([195.238.4.200]:54221 "EHLO
	outmx019.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750922AbWIFTmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:42:06 -0400
Date: Wed, 6 Sep 2006 21:41:49 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Samuel Tardieu <sam@rfc1149.net>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
Message-ID: <20060906194149.GA2386@infomag.infomag.iguana.be>
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net> <44FEB5B6.10008@draigBrady.com> <2006-09-06-14-07-50+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2006-09-06-14-07-50+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> | So in the case the BIOS sets the watchdog to 4 mins
> | for example the 2 drivers are a little different.
> | 
> | W83627HF resets to timeout seconds on module load
> | W83697HG resets to timeout seconds on /dev/watchdog open
> 
> Yes, I'm reluctant at changing anything set by the BIOS before the first
> *use* of the module. In particular, if the watchdog was not activated by
> default in the BIOS, I'd prefer the box not to reboot just because the
> module was loaded (maybe by mistake) if no daemon open /dev/watchdog
> at least once.

My feedback: it is important that during the initialization of the module,
the watchdog is being disabled. A watchdog should only start working after
it has been started via /dev/watchdog.

> In particular, some boxes may take a long time to boot, e.g. if fscks are
> needed; if the module is loaded by an initrd before filesystems are mounted
> and fscks are done, if I'm not mistaken the box could reboot in loop
> every time in the middle of fscks.

Please note that I added 4 days ago a patch of Marcus Junker <junker@anduras.de>
in my linux-2.6-watchdog-mm tree for the w83697hf chipset.
See: http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog-mm.git;a=commitdiff;h=d19ea38e6e99c4924c894cb54440e242179bf27d;hp=19cdb014d58f2c47470d86188a7e556380469008

Greetings,
Wim.

