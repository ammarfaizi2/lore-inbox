Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTCFA02>; Wed, 5 Mar 2003 19:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTCFA02>; Wed, 5 Mar 2003 19:26:28 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11012 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267547AbTCFA00>;
	Wed, 5 Mar 2003 19:26:26 -0500
Date: Thu, 6 Mar 2003 01:36:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: davej@suse.de, John Clemens <john@deater.net>, cpufreq@www.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Re: cpufreq: allow user to specify voltage
Message-ID: <20030306003607.GA124@elf.ucw.cz>
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

> Here's my suggestion, (partly) based on something Patrick Mochel suggested
> for the passing of attribute files of cpufreq drivers to the cpufreq core:
> a NULL-terminated list of device_attributes *attr is passed to the core. And
> if attr itself is NULL, no attribute is passed, of course. Using this
> approach, this patch against cpufreq-CVS-HEAD adds a file
> 
> /sys/devices/sys/cpu0/scaling_available_freqs (something Carl Thompson
> 						asked for)
> 
> for the powernow-k7.c and the p4-clockmod.c drivers (other frequency table
> based drivers can be added at will -- Carl, please don't realy _solely_ on
> this file: some drivers don't use frequency tables but still might want to
> use your great userspace scaling program!)
> 
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

It seems to work. I'll crash my machine now (and go to sleep ;-). So
if you don't get another mail within 30 minutes of this, it worked.

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
