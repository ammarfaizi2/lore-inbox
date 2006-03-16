Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752236AbWCPH5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbWCPH5o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbWCPH5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:57:44 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:11250 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752230AbWCPH5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:57:43 -0500
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
In-Reply-To: Your message of "Thu, 16 Mar 2006 15:28:47 +0800."
             <3ACA40606221794F80A5670F0AF15F840B37A72F@pdsmsx403> 
Date: Thu, 16 Mar 2006 07:57:40 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJnMa-0000bW-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To verify this, please hack acpi_thermal_active.

Do you mean hack it for now to return without doing anything (like if
'tz' wasn't valid)?  Or do it farther in the function, like by
changing

				result =
				    acpi_bus_set_power(active->devices.
						       handles[j],
						       ACPI_STATE_D0);
to 

				result = 1;

>  Disable active/passive cooling request before suspend.

Do I need to hack acpi_thermal_passive() as well?

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
