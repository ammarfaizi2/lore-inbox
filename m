Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWIFMHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWIFMHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 08:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWIFMHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 08:07:52 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:40927 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S1750772AbWIFMHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 08:07:51 -0400
Date: Wed, 6 Sep 2006 14:07:50 +0200
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net> <44FEB5B6.10008@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44FEB5B6.10008@draigBrady.com>
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-06-14-07-50+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6/09, Pádraig Brady wrote:

| So in the case the BIOS sets the watchdog to 4 mins
| for example the 2 drivers are a little different.
| 
| W83627HF resets to timeout seconds on module load
| W83697HG resets to timeout seconds on /dev/watchdog open

Yes, I'm reluctant at changing anything set by the BIOS before the first
*use* of the module. In particular, if the watchdog was not activated by
default in the BIOS, I'd prefer the box not to reboot just because the
module was loaded (maybe by mistake) if no daemon open /dev/watchdog
at least once.

In particular, some boxes may take a long time to boot, e.g. if fscks are
needed; if the module is loaded by an initrd before filesystems are mounted
and fscks are done, if I'm not mistaken the box could reboot in loop
every time in the middle of fscks.

  Sam

