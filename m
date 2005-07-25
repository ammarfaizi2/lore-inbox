Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVGYPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVGYPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGYPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 11:55:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54191 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261166AbVGYPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 11:55:07 -0400
Date: Mon, 25 Jul 2005 17:53:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ250 vs. HZ1000
Message-ID: <20050725155322.GA1046@openzaurus.ucw.cz>
References: <20050725161333.446fe265.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050725161333.446fe265.Ballarin.Marc@gmx.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I did some measurements in order to compare power drain with HZ250 and
> HZ1000.
> To measure the actual drain, I used the "smart" battery's internal measurement.
> (Available with acpi-sbs in /proc/acpi/sbs/SBS0/SB0/state.)
> No clue how accurate this is.
> 
> Here some battery details, in case someone knows:
> charge reporting error:  25%
> SB specification:        v1.1 (with PEC)
> manufacturer name:       Panasonic
> manufacture date:        2004-11-27
> device name:             02ZL
> device chemistry:        Lion
> 
> Kernel: 2.6.13-rc3-mm1 + acpi-sbs
> 
> CPU:
> cpu family	: 6
> model		: 13
> model name	: Intel(R) Pentium(R) M processor 1.60GHz
> stepping		: 6
> 
> The "ondemand" governor was running, using acpi_cpufreq. (Idle at 600MHz).
> 
> Systems was running X11/KDE to get a more or less realistic scenario. No
> cron jobs, network traffic or additional applications. WLAN and built-in
> display were disabled completely, all fans and LEDs were off, internal hard
> disc was running. Additional peripherals: external keyboard, mouse, display
> and externally-powered hard disk (USB).


USB devices prevent entering C3 and any interesting powersaving,
try without USB...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

