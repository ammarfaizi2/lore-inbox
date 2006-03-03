Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWCCVEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWCCVEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCCVEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:04:22 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:38351 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932220AbWCCVEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:04:21 -0500
To: Matthew Garrett <mjg59@srcf.ucam.org>
cc: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions 
In-Reply-To: Your message of "Fri, 03 Mar 2006 16:51:19 GMT."
             <20060303165119.GA30228@srcf.ucam.org> 
Date: Fri, 03 Mar 2006 21:04:18 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FFHRi-000451-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll try it, although I don't think I'll get any data on the problem.
>> The unmodified DSDT (bios 1.11) lacks an S3 sleep object, so I had to
>> modify the DSDT even to get S3 to sleep at all.  See
>> <http://bugzilla.kernel.org/show_bug.cgi?id=3534> for that discussion.

> I think it's arguably a bit extreme to describe "My setup is so 
> unsupported that I had to modify my firmware to enable sleep and then 
> override the kernel's sanity checks and it's stopped working with 
> 2.6.16" as a regression.

I agree, and that was the point of 'picture of me hanging head in
shame', so there's no need to rub it in.

Anyway, the TP600X w/ vanilla DSDT *was* unsupported (circa 2.6.11),
but now the ACPI interpreter can interpret the vanilla DSDT and go
into S3 sleep (before, it would complain about a missing S3 sleep
object because the DSDT used a funny syntax).  There were other
problems in the vanilla DSDT (e.g. probably using fn-F7 to switch to
an external display doesn't work) but I'll investigate them one at a
time.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
