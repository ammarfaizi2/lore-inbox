Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUB0Or4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUB0Or4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:47:56 -0500
Received: from fmr99.intel.com ([192.55.52.32]:6276 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262890AbUB0Orv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:47:51 -0500
Subject: Re: Mobile Intel Pentium(R) 4 - M CPU 2.60GHz - kernel 2.6.3
From: Len Brown <len.brown@intel.com>
To: Bob Dobbs <bob_dobbs@linuxmail.org>
Cc: linux-kernel@vger.kernel.org,
       "cpufreq@www.linux.org.uk" <cpufreq@www.linux.org.uk>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F3C81@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F3C81@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077893211.22404.184.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Feb 2004 09:46:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps with ACPI disabled you've left CPU frequency control in the
hands of SMM (the BIOS)?  That would be consistent with Linux having no
visibility or conrol over what is going on.  There may be some BIOS
SETUP options to turn it off.

cheers,
-Len

Thu, 2004-02-26 at 19:46, Bob Dobbs wrote:
> Hello,
> 
> I am currently running kernel 2.6.3 on my Dell Inspiron 8500 laptop.
> I disabled all the ACPI and APM options in the kernel.
>
> I have upgraded my bios
> I have tried from kernel 2.4.23 up to mm and love-sources and my
> current kernel 2.6.3.
> 
> What happens is during heavy loads my cpu drops from 2.60GHz down to
> 1.20GHz, this happens for a few minutes, say 5 - 10 at the most. But
> performance while running a game, puts the game into slow motion.
> (Which  is weird because 1.20GHz should be more than enough to run all
> of the  games I currently have). I have read up on the documentation
> in /usr/src/linux/Documentation, under the "power" and "cpu-freq" but
> after disabling ACPI and such, those options do not seem to work
> anymore.
> 
> I have also tried running a program called "cpufreqd" which launches
> at boot time, but once again without ACPI enabled in the kernel this
> seems  not to work either. Also /sys/devices/system/cpu/cpu0/cpufreq/
> has the following files.
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
> I tried to make those files set at: 2.00GHz min and 2.60GHz max, but
> something changes them right back to 1.20GHZ no matter what I do.
> 
> I am sure I am missing something, but atm I am totally lost.. and I
> could surely be doing everything wrong to begin with... that is why I
> am asking for help.
> 
> Is there a patch or anything to force the cpu to run at 2.60GHz all
> the time?
> 
> Thank you


