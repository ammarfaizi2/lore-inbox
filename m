Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUJaV3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUJaV3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbUJaV3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:29:32 -0500
Received: from gprs214-91.eurotel.cz ([160.218.214.91]:24197 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261210AbUJaV32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:29:28 -0500
Date: Sun, 31 Oct 2004 22:29:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "Brown, Len" <len.brown@intel.com>,
       "Moore, Robert" <robert.moore@intel.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: Userspace ACPI interpreter ( was RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi)
Message-ID: <20041031212914.GH5578@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC000@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC000@pdsmsx403>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> On IA64 platform, ACPI interpreter seems to be mandatory for those
> >> stuff, but IA32 is not.  So, the ram disk is the generic solution 
> >> for loading user space interpreter for boot. 
> >
> >In two sentences: If you want to play with moving the interpreter
> >to user-space, please do so, and do it on ia64, so you have to
> >deal with the interesting problems.
> >
> >And this whole thing is a gigantic tangent that is only distracting
> >attention from the real question at hand, namely, Alex's dev_acpi
> >patch, which exists today and enables some very interesting new
> >functionality.
> >
> 
>   Yes, I agree Alex's dev_acpi is interesting, which could result in 
> the removal of some acpi specific drive such as battery.c, button.c,
> fan.c, thermal.c ....   So, I raised the question of userspace ACPI 
> interpreter.  Intuitively, userspace is the right place for interpreter.

I do not think you want to put thermal/fan into userspace. If you boot
machine with init=/bin/bash, you should have working system. System
without fan fail... fast.

Plus you want to do suspend/resume.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
