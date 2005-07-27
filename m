Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVG0V2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVG0V2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVG0VZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:25:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63660 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262442AbVG0VXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:23:25 -0400
Date: Wed, 27 Jul 2005 22:52:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
Subject: Re: [ACPI] Re: [Alsa-devel] [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Message-ID: <20050727205249.GA708@openzaurus.ucw.cz>
References: <200507261247.05684.rjw@sisk.pl> <200507261251.48291.rjw@sisk.pl> <s5hmzo8ljf6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hmzo8ljf6.wl%tiwai@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The following patch adds free_irq() and request_irq() to the suspend and
> > resume, respectively, routines in the snd_intel8x0 driver.
> 
> The patch looks OK to me although I have some concerns.
> 
> - The error in resume can't be handled properly.
> 
>   What should we do for the error of request_irq()?
> 
> - Adding this to all drivers seem too much.

There's probably no other way. Talk to Len Brown.

>   We just need to stop the irq processing until resume, so something
>   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
>   more uesful?

Its more complex than that. Irq numbers may change during resume.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

