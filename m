Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVLENC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVLENC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVLENC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:02:28 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:12635 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932404AbVLENC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:02:28 -0500
Date: Mon, 5 Dec 2005 14:02:24 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051205130224.GC17993@harddisk-recovery.com>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de> <20051204183239.GE14247@wotan.suse.de> <1133725767.19768.12.camel@mindpipe> <20051205011611.GA12664@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205011611.GA12664@redhat.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 08:16:11PM -0500, Dave Jones wrote:
> I can't think of a single valid reason why a program would want
> to know the MHz rating of a CPU. Given that it's a) approximate,
> b) subject to change due to power management, c) completely nonsensical
> across CPU vendors, and d) only one of many variables regarding CPU
> performance, any program that bases any decision on the values found
> by parsing that field of /proc/cpuinfo is utterly broken beyond belief.

If you want a userspace governor to change the CPU speed, you need to
export the value to userland. There are several papers showing[1] that
such speed scheduling should be done by power-aware applications which
need to tell the OS what speed they require to run to meet their
processing needs.

I agree that /proc/cpuinfo shouldn't be used (though it is a nice
interface for humans to read about the CPU speed), but the current
sysfs interface should do.


Erik

[1] See for example
http://www.pds.twi.tudelft.nl/~pouwelse/energy_priority_scheduling.ps.gz
http://www.pds.twi.tudelft.nl/~pouwelse/power_aware_video_decoding.ps

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
