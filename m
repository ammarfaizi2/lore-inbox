Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUB0Sdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUB0Sdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:33:54 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:51537 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S261720AbUB0SdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:33:23 -0500
Subject: Re: Mobile Intel Pentium(R) 4 - M CPU 2.60GHz - kernel 2.6.3
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040227004631.31D663982E7@ws5-1.us4.outblaze.com>
References: <20040227004631.31D663982E7@ws5-1.us4.outblaze.com>
Content-Type: text/plain
Message-Id: <1077906333.9395.40.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 13:25:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same box, same problem. (Different kernel, 2.4) Its thermal limiting -
you -really- want cpufreq (or at least acpi) so that linux knows whats
going on.  I've found that running 'i8kfan 2 2' (blast fans), hit fn-z
(tell bios to reset fans) and then setting the fans to 1 1 (medium) will
keep it from happening, much of the time.

Alternately, just fn-z might do it, but it'll kick in again..

(Basically, the cooling on this thing sucks under heavy workloads.)

On Thu, 2004-02-26 at 19:46, Bob Dobbs wrote:
> Hello,
> 
> I am currently running kernel 2.6.3 on my Dell Inspiron 8500 laptop.
> I disabled all the ACPI and APM options in the kernel.
> 
> I have upgraded my bios
> I have tried from kernel 2.4.23 up to mm and love-sources and my current kernel 2.6.3.
> 
> What happens is during heavy loads my cpu drops from 2.60GHz down to 1.20GHz, this happens for a few minutes, say 5 - 10 at the most. But performance while running a game, puts the game into slow motion. (Which  is weird because 1.20GHz should be more than enough to run all of the  games I currently have). I have read up on the documentation in /usr/src/linux/Documentation, under the "power" and "cpu-freq" but after disabling ACPI and such, those options do not seem to work anymore.
> 
> I have also tried running a program called "cpufreqd" which launches at boot time, but once again without ACPI enabled in the kernel this seems  not to work either. Also /sys/devices/system/cpu/cpu0/cpufreq/ has the following files.
> 
> cpuinfo_min_freq
> cpuinfo_max_freq
> scaling_min_freq
> scaling_max_freq
> 
> I even tried to echo the options at bootup:
> 
> echo 2600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq &
> echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq &
> 
> I tried to make those files set at: 2.00GHz min and 2.60GHz max, but something changes them right back to 1.20GHZ no matter what I do.
> 
> I am sure I am missing something, but atm I am totally lost.. and I could surely be doing everything wrong to begin with... that is why I am asking for help.
> 
> Is there a patch or anything to force the cpu to run at 2.60GHz all the time?
> 
> Thank you
-- 
Disconnect <lkml@sigkill.net>

