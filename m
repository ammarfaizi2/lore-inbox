Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbTFWJmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbTFWJmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:42:45 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:6283 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S265972AbTFWJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:42:43 -0400
Date: Mon, 23 Jun 2003 19:58:37 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: can't get linux to perform a bios suspend (was: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend)
Message-ID: <20030623095837.GE583@zip.com.au>
References: <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz> <20030618081600.GA484@zip.com.au> <20030618101728.GA203@elf.ucw.cz> <20030618102602.GA593@zip.com.au> <20030618103528.GB203@elf.ucw.cz> <20030621142400.GB5388@zip.com.au> <20030622151549.GD199@elf.ucw.cz> <20030623005814.GA583@zip.com.au> <20030623095058.GB6158@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623095058.GB6158@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 11:50:58AM +0200, Pavel Machek wrote:
> > 
> > And it activated bios suspend just fine. It didn't resume properly though.
> > The bios resume screen was left behind and the whole setup hung. I've
> > been using the suspend2disk functionality of this laptop under apm and 2.4.x
> > just fine (for months really - I rarely 'rebooted' my laptop) so I don't
> > think it's the bios that's b0rked.
> 
> And did you use S4bios with 2.4.X? apm and acpi are really different.

No. Never really used acpi under 2.4.x cos it all seemed like a bit mess
to me and the couple of times I tried it it just didn't do much of anything.
apm worked so I stuck with it. When I moved to 2.5.x I decided to test-run
as much as possible and so started using acpi.

As a note: at least the screen displayed and the requirements from the 
bios are both thesame when apm and acpi are used.

> Modification you did is wrong; I'd try
> 
> #ifdef CONFIG_SOFTWARE_SUSPEND
>         if ((state == 4) && (state_string[1] != 'b')) {
> 	        software_suspend();
>                 goto Done;
>         }
> #endif  

I had that in my original testing. It hung. I'll try again and tell
you where.

> Does s3 work for you? s3 and s4bios should be really similar.

Haven't tried s3. Will do so asap.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
