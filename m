Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262855AbSJAWSE>; Tue, 1 Oct 2002 18:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262861AbSJAWSD>; Tue, 1 Oct 2002 18:18:03 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9476 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262855AbSJAWSC>;
	Tue, 1 Oct 2002 18:18:02 -0400
Date: Mon, 30 Sep 2002 02:38:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
       cpufreq@www.linux.org.uk
Subject: Re: cpufreq patches for 2.5.39 follow
Message-ID: <20020930023850.E35@toy.ucw.cz>
References: <20020928112130.A1217@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020928112130.A1217@brodo.de>; from linux@brodo.de on Sat, Sep 28, 2002 at 11:21:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The interface to userspace is /proc/cpufreq, and the user can "echo" a new
> policy into this file using the following syntax:
> [cpu:]min_freq:max_freq:policy		or
> [cpu%]min_pctg%max_pctg%policy

Should we have both in kernel?

How does it interact with ACPI? Ie. I do echo "100%100%foo", but ACPI thermal
managment decides to slow down?

> Patch 3/5: cpufreq-i386-drivers
> -------------------------------
> Six i386 CPUFreq drivers are ready to be merged this time. These are:
> elanfreq.c:	  The AMD Elan CPU family offers extensive clock scaling
> longhaul.c:	  VIA Longhaul processor clock + voltage scaling
> longrun.c:        Transmeta Crusoe Longrun clock + voltage scaling
> p4-clockmod.c:    clock modulation on P4 Xeon processors
> powernow-k6.c:	  mobile AMD K6-2+ / mobile AMD K6-3+ clock scaling
> speedstep.c:	  clock and voltage scaling on mobile Intel Pentium 3 and 4s,
> 		  but (unfortunately) only on ICH2-M or ICH3-M based
>                   chipsets.
> 
> Support for mobile AMD K7 processors is still in development.

What about mobile celerons?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

