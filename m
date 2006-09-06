Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWIFLtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWIFLtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWIFLtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:49:36 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:60347 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1750731AbWIFLte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:49:34 -0400
Message-ID: <44FEB5B6.10008@draigBrady.com>
Date: Wed, 06 Sep 2006 12:49:10 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Tardieu <sam@rfc1149.net>
CC: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net>
In-Reply-To: <2006-09-06-13-29-46+trackit+sam@rfc1149.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Tardieu wrote:
> On  6/09, Pádraig Brady wrote:
> | I noticed you didn't include the check that's in the
> | W83627HF driver to reset the timeout if already running
> | from the BIOS. This was because some BIOS set the timeout
> | to 4 minutes for example, so when the driver was loaded
> | and reset the mode to seconds, the machine rebooted
> | before the init scripts could run and start the userspace
> | watchdog daemon.
> 
> Note that the watchdog is enabled only when the device is open and is
> signalled during the wdt_enable() routine just after switching the mode
> to seconds.

Sorry I missed that. That's fine so.

So in the case the BIOS sets the watchdog to 4 mins
for example the 2 drivers are a little different.

W83627HF resets to timeout seconds on module load
W83697HG resets to timeout seconds on /dev/watchdog open

cheers,
Pádraig.
