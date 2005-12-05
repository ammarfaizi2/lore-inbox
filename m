Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbVLEWIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbVLEWIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVLEWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 17:08:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36773 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751414AbVLEWIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 17:08:43 -0500
Date: Mon, 5 Dec 2005 22:34:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
       Daniel Petrini <d.pensator@gmail.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [PATCH] i386 No Idle HZ aka dynticks v051205
Message-ID: <20051205213446.GA4388@elf.ucw.cz>
References: <200512051154.45500.kernel@kolivas.org> <20051205211602.GB1728@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205211602.GB1728@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The main change to this version is the inclusion of Dominik's patches to
> > cpufreq ondemand, acpi c-states and bus mastering which should start making
> > the potential power saving features of dyntick a reality (thanks!).
> > One buildfix for !CONFIG_NO_IDLE_HZ as well.
> > 
> > If you get strange stalls with this patch then almost certainly it is a
> > problem with dynticks and your apic so booting with the "noapic" option
> > should fix it.
> > 
> > Split out patches, timertop and pmstats utilities and latest patch available
> > here:
> > http://ck.kolivas.org/patches/dyn-ticks/
> > 
> > FAQ:
> > What Hz should I use with dynticks in the config?
> > 1000 to realise the benefits of the power saving features and low latency.
> > 
> > Should I enable timer statistics?
> > Only if you're planning on using the timertop utility to help you recognise
> > the biggest sources of timers currently in use to help you improve power
> > savings.
> 
> Strange. It works okay here (thinkpad x32, configured SMP), but
> something strange is going on with cursor. I use softcursor (normal
> underline but highlight background), and underline no longer blinks
> over it.
> 
> Try:
> 
>     echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"
> 
> on vanilla and no-idle-hz kernels to see what I mean. I'm using
> framebuffer console here.

Ok, so the problem is in -rc5 mainline, not in dynticks... Perhaps it
is time to get dynticks merged to -mm tree?
								Pavel
-- 
Thanks, Sharp!
