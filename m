Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVC3VZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVC3VZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVC3VYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:24:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44163 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262454AbVC3VXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:23:06 -0500
Date: Wed, 30 Mar 2005 23:22:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, seife@suse.de,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: smp/swsusp done right
Message-ID: <20050330212253.GB1347@elf.ucw.cz>
References: <20050323204019.GA11616@elf.ucw.cz> <Pine.LNX.4.61.0503301413050.12965@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503301413050.12965@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is against -mm kernel; it is smp swsusp done right, and it
> > actually works for me. Unlike previous hacks, it uses cpu hotplug
> > infrastructure. Disable CONFIG_MTRR before you try this...
> > 
> > Test this if you can, and report any problems. If not enough people
> > scream, this is going to -mm.
> 
> Yay! Thanks for getting that done Pavel =)

Well, I guess it is thank you -- I got rid of ugly FIXME that would
involve arch-dependend assembly to be solved properly.

... hmm, can play_dead handle all the memory being overwritten? Also
it should probably save and restore registers including MTRRs.

...so I more moved ugly FIXME to better place. Oh well, at least it
uses common infrastructure now. People at Intel doing suspend-to-RAM
on smp systems will need to solve it properly, anyway, because they
need to go to real mode and back.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
