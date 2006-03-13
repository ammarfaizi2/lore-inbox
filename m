Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWCMH2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWCMH2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 02:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCMH2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 02:28:07 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:65180 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751832AbWCMH2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 02:28:05 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       "Duncan" <1i5t5.duncan@cox.net>, "Pavlik Vojtech" <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Mon, 13 Mar 2006 12:51:57 +0800."
             <3ACA40606221794F80A5670F0AF15F840B2DAF0C@pdsmsx403> 
Date: Mon, 13 Mar 2006 07:28:02 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FIhTG-00079G-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you try to mute thermal poll?

Done.  The sleep.sh script now has

echo 0 > /proc/acpi/thermal_zone/THM2/polling_frequency
echo 0 > /proc/acpi/thermal_zone/THM0/polling_frequency
sleep 1

> I need the full log  for S3 suspend failure not just snippets.
> Please attach it on bugzilla.kernel.org

Done.

> The log for S3 suspend success cannot help me to track down.

For completeness, I didn't excise that portion of the log.  It's not
many lines, plus it doesn't make it harder to find the failing
portion: The suspend failure happens after the second "@@@@ SLEEP" in
the log.

Should I turn on more acpi_debug_level debugging?

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
