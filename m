Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268039AbTBYTX2>; Tue, 25 Feb 2003 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268126AbTBYTX2>; Tue, 25 Feb 2003 14:23:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22792 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268039AbTBYTX1>; Tue, 25 Feb 2003 14:23:27 -0500
Date: Tue, 25 Feb 2003 20:33:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Clemens <john@deater.net>
Cc: Dominik Brodowski <linux@brodo.de>, cpufreq@www.linux.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: allow user to specify voltage
Message-ID: <20030225193341.GA19556@atrey.karlin.mff.cuni.cz>
References: <20030225190949.GM12028@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302251419290.12073-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302251419290.12073-100000@pianoman.cluster.toy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So I guess adding /sys/bus/system/devices/cpu0/voltage? Should code to
> > do that be in kernel/cpufreq.c or is it possible to do sysfs from
> > powernow-k7 [it does not seem easy]?
>  								Pavel
> I agree, there shoul dbe a way to add sysfs files from a cpufreq driver
> module.  I told dave I was looking into overriding the powernow tables,
> but I can't seem to get enough time away from my day job right now.
> 
> for the powernow driver, and the userspace governor, I'd like to export a
> file "current_setting" or something that contains:
> 
> <frequency> <voltage> <fsb? maybe for other drivers>
> 
> A write to this file of one, two, or three values would result in changing
> the frequency to the closest standard table match we have.  Unless, the
> user specifies an "override" flag as a module parameter.  If the override
> flag is set, then writing to that file will set the speed and voltage to
> exactly what you specify (within the min/max hardware limits), and
> basically ignore the standard BIOS table.

Actually I think sysfs is trying to get it into one-file-per-value...

...which is going to be problem for writing because it will not be
able to atomically update different values at once...

Oh and forget module parameter :-).
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
