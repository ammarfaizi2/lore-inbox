Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTK1XmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 18:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTK1XmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 18:42:20 -0500
Received: from gprs144-43.eurotel.cz ([160.218.144.43]:58752 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263571AbTK1XmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 18:42:16 -0500
Date: Sat, 29 Nov 2003 00:43:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tell user when ACPI is killing machine
Message-ID: <20031128234301.GA18147@elf.ucw.cz>
References: <20031128145558.GA576@elf.ucw.cz> <20031128220140.GB1714@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128220140.GB1714@vitelus.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On critical overheat (or perceived critical overheat -- acpi bioses on
> > some notebooks apparently report bogus values from time to time),
> > kernel itself calls /sbin/halt *without telling anything*. User can
> > not see anything, his machine just shuts down cleanly. Bad.
> 
> Sorry if this is a bit OT, but why doesn't ACPI scale the CPU

Yep it is OT.

> frequency back instead of shutting down? This is what APM does on my
> laptop (presumably in the BIOS) but when I enable ACPI the machine
> shuts down whenever I do something CPU intensive (yes; it's a poorly
> designed laptop). I have cpufreq support (cpufreq: P4/Xeon(TM) CPU
> On-Demand Clock Modulation available). Has this kind of thing been

It should try scaling first (and it works for me (tm)), but when
temperature reaches "critical" limit it is assumed that everything
failed and shutdown is only option. (On hp omnibook even in slowest
possible mode, if you play .mpg video it overheats.)

> added since I last tried it, or do I actually have to actively set up
> cpufreq in user space to get thermally-induced clock modulation? Or is
> not even possible with the current state of things?

cpufreq is not connected to acpi thermal subsystem. Dominik has some
patches to change that, IIRC.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
