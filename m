Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWIFLO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWIFLO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWIFLO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:14:59 -0400
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:31675 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S1750768AbWIFLO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:14:58 -0400
Message-ID: <44FEAD7E.6010201@draigBrady.com>
Date: Wed, 06 Sep 2006 12:14:06 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Tardieu <sam@rfc1149.net>
CC: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net>
In-Reply-To: <87fyf5jnkj.fsf@willow.rfc1149.net>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Tardieu wrote:
> Winbond W83697HG watchdog timer

Looks good, thanks.

I've got a W83697H*F* here on a VIA motherboard,
which is the same from a watchdog point of view.
It is on port 0x2e though.
Is 0x4e a good default?
Is W83697HG a good name?

Note I've CC'd Wim Van Sebroeck who is the watchdog tree maintainer.

I noticed you didn't include the check that's in the
W83627HF driver to reset the timeout if already running
from the BIOS. This was because some BIOS set the timeout
to 4 minutes for example, so when the driver was loaded
and reset the mode to seconds, the machine rebooted
before the init scripts could run and start the userspace
watchdog daemon.

cheers,
Pádraig.
