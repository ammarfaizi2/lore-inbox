Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWCPADP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWCPADP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWCPADP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:03:15 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:35039 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932610AbWCPADO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:03:14 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Wed, 15 Mar 2006 16:02:57 +0800."
             <3ACA40606221794F80A5670F0AF15F840B32AC5E@pdsmsx403> 
Date: Thu, 16 Mar 2006 00:03:10 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJfxO-0005NY-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your intuition was right.  Testing by changing only the DSDT gives
slightly different results than by changing the kernel drivers.  So
far the results:

with only THM0 in the DSDT: HANGS (but only on the second sleep, not
   the first one, so a slight difference with the kernel-testing data)

with only THM0 and all methods doing nothing (either returning 0 or,
   for _TMP, 0xBB8):  NO hang

with only THM0 and all methods except _TMP doing nothing, but _TMP
   doing its normal code: NO hang [that's the difference between DSDT
   and kernel testing]

More bisection coming.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
