Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268231AbTBYSvn>; Tue, 25 Feb 2003 13:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268232AbTBYSvm>; Tue, 25 Feb 2003 13:51:42 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:40447 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268231AbTBYSvl>; Tue, 25 Feb 2003 13:51:41 -0500
Date: Tue, 25 Feb 2003 19:24:14 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Pavel Machek <pavel@suse.cz>
Cc: cpufreq@www.linux.org.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq: allow user to specify voltage
Message-ID: <20030225182414.GA3242@brodo.de>
References: <20030224225545.GA16991@elf.ucw.cz> <20030225004126.GA2477@brodo.de> <20030225180311.GI12028@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225180311.GI12028@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Feb 25, 2003 at 07:03:11PM +0100, Pavel Machek wrote:
> Hi!
> 
> Well, look again; if you use mVforce, it forces *just one* frequency
> (min=max=freq you specified), so it is actually okay.
But min=max=freq is awful... I know, I reccommended it sometimes, but with
the appearance of the userspace governor (already available on the cpufreq
homepage, http://www.brodo.de/cpufreq/advanced.html , will be submitted
soon) min=max=freq is deprecated.

> But I agree that hacking proc_intf is not the right thing to do. I did
> not see that sysfs access. Where is it?

kernel/cpufreq.c

> > - selecting the voltage manually is something which is only valid for some
> >   very few drivers - so let's only export one sysfs file[*] for these
> >   drivers.
> 
> Very few drivers? It should be common for at least Intel and AMD, no?
No. Intel doesn't let you select the exact voltage. IIRC, only vew 
VIA/Cyrix-longhaul-capable processors and, of course, powernow-k7 are vaild
targets for such a patch.

	Dominik
