Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268269AbTBYRw6>; Tue, 25 Feb 2003 12:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268270AbTBYRw6>; Tue, 25 Feb 2003 12:52:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31751 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268269AbTBYRw5>; Tue, 25 Feb 2003 12:52:57 -0500
Date: Tue, 25 Feb 2003 19:03:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, cpufreq@www.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: allow user to specify voltage
Message-ID: <20030225180311.GI12028@atrey.karlin.mff.cuni.cz>
References: <20030224225545.GA16991@elf.ucw.cz> <20030225004126.GA2477@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225004126.GA2477@brodo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This allows user to specify voltage manually. This gives me 40 extra
> > minutes (1h50m -> 2h30m) on HP omnibook which appears to have broken
> > bios tables. Please apply,
> 
> Please don't apply this patch -- for the following reasons:
> - it only uses the deprecated, overloaded cpufreq proc_intf
> - selecting the voltage within the policy (minimum and maximum frequency,
>   mode of operation) is not where it should be done: you may want a
>   different voltage at min-speed as at max-speed. So the frequency tables,
>   or -even better- the amd-k7-specific table may be a better choice for
>   this.

Well, look again; if you use mVforce, it forces *just one* frequency
(min=max=freq you specified), so it is actually okay.

But I agree that hacking proc_intf is not the right thing to do. I did
not see that sysfs access. Where is it?

> - selecting the voltage manually is something which is only valid for some
>   very few drivers - so let's only export one sysfs file[*] for these
>   drivers.

Very few drivers? It should be common for at least Intel and AMD, no?

									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
