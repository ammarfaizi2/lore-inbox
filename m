Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbTCFXBW>; Thu, 6 Mar 2003 18:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbTCFXBU>; Thu, 6 Mar 2003 18:01:20 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12804 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261177AbTCFXA3>;
	Thu, 6 Mar 2003 18:00:29 -0500
Date: Thu, 6 Mar 2003 21:42:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: Pavel Machek <pavel@suse.cz>, davej@suse.de,
       John Clemens <john@deater.net>, cpufreq@www.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Re: cpufreq: allow user to specify voltage
Message-ID: <20030306204230.GC276@elf.ucw.cz>
References: <20030225190949.GM12028@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302251419290.12073-100000@pianoman.cluster.toy> <20030225193341.GA19556@atrey.karlin.mff.cuni.cz> <20030228211638.GA888@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228211638.GA888@brodo.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And for powernow-k7.c , the file
> 
> /sys/devices/sys/cpu0/scaling_setvoltage
> 
> should show the current voltage for the current speed (scaling_setspeed).
> "echoing" a different value (must be lower than the current voltage) changes
> the voltage for this frequency only. However, this override is "static" so
> that if you switch to a different frequency in the meantime but get back to
> the one you wanted to override the voltage setting for, the new 
> user-specified value is remembered.
> 
> This is untested (don't have a powernow-k7-capable notebook), so handle with
> care.

Thanx, it works. I'd drop "can't set higher voltage" limitation
[hardware protects you, anyway, and if you make it so low your system
is unstable you can no longer fix it without reboot], but that's
minor.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
