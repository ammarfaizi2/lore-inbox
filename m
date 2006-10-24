Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752115AbWJXH7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbWJXH7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWJXH7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:59:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59148 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752115AbWJXH7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:59:13 -0400
Date: Tue, 24 Oct 2006 07:58:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl, ncunningham@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024075855.GA4211@ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl> <20061023095522.e837ad89.akpm@osdl.org> <20061023171450.GA3766@elf.ucw.cz> <20061023105022.8b1dc75d.akpm@osdl.org> <20061023213943.GA21361@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023213943.GA21361@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Apparently uswsusp has gained support for S3 while the in-kernel driver
> > does not support S3.  That's disappointing.
> 
> I'm still not sure why that's an especially desirable feature. Every 
> laptop I've played with will automatically resume from S3 when the 
> battery level becomes critical, which gives you the opportunity to 
> suspend to disk. And when it doesn't, you can generally emulate it using 
> the ACPI alarm to wake up. Is there really a significant quantity of 
> hardware out there that doesn't support either of these?

Well, there are reasons *against* your implementation:

1) waking laptop at random time (737 taking off?) may be dangerous for
the laptop (and its surroundings)

2) old li-ions are probably able to keep laptop suspended for 20
hours, but will die if you attempt to resume after 10 hours of sleep
without ac power.

That said, patch for 's2ram, wakeup on battery low' for uswsusp would
be welcome.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
