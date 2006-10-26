Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423472AbWJZRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423472AbWJZRmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423589AbWJZRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 13:42:14 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:21510 "EHLO
	smtp-vbr16.xs4all.nl") by vger.kernel.org with ESMTP
	id S1423472AbWJZRmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 13:42:13 -0400
Date: Thu, 26 Oct 2006 19:41:53 +0200
From: thunder7@xs4all.nl
To: Inter filmati <interfc@jumpy.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq/powernowd limiting CPU frequency on kernels >=2.6.16
Message-ID: <20061026174153.GB18076@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <001501c6f921$56c3fe40$2b20ff27@flaviopc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001501c6f921$56c3fe40$2b20ff27@flaviopc>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inter filmati <interfc@jumpy.it>
Date: Thu, Oct 26, 2006 at 07:08:20PM +0200
> Most recent kernel where this bug did not occur:2.6.15
> Distribution:Ubuntu64bit
> Hardware Environment: X2 3800+, DFI NF4 Ultra-D, X800GT
> Software Environment:
> Problem Description: I overclocked via bios my cpu (factory: 200x10) to 
> 2565mhz

this ugly quoting would be prevented if you used a line length of 72.

> (285x9), and I haven't any problems 'til 2.6.15, it goes down to 285x5 in 
> idle
> and up to 285x9 in full load. If I upgrade to a newer kernel, it says 1ghz 
> in
> idle and 1,8ghz in full load (I wonder it takes the fsb value, that is 
> 200mhz,
> directly form cpu and not from the bios, so it assumes 200x5 in idle and 
> 200x9
> in full load)
> 
> Steps to reproduce:
> simply compile a kernel >=2.6.16 and try to overclock your cpu from the bios
> raising the FSB (or HT)
> 
No so simple: I mildly overclocked my FSB, from 2400 to 2520 MHz and I
see:

cpufrequtils 002: cpufreq-info (C) Dominik Brodowski 2004-2006
Report errors and bugs to linux@brodo.de, please.
analyzing CPU 0:
  driver: powernow-k8
  CPUs which need to switch frequency at the same time: 0 1
  hardware limits: 1000 MHz - 2.40 GHz
  available frequency steps: 2.40 GHz, 2.20 GHz, 2.00 GHz, 1.80 GHz, 1000 MHz
  available cpufreq governors: ondemand, powersave, performance
  current policy: frequency should be within 1000 MHz and 2.40 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1000 MHz.
analyzing CPU 1:
[the same]

from demsg:
time.c: Detected 2520.575 MHz processor.

Which means that my X2 4600+ works just fine, but after overclocking
cpufreq restores it to the FSB that it should run on.

If you care about that changed, try to find out what patch caused this,
but in general, there's no support for overclocking in the kernel, and
bugreports from overclocked systems are frowned upon.

Kind regards,
Jurriaan
-- 
"What sort of timeframe did you have in mind?"
"An immediate one," I said. "The immediater the better."
	Jim Butcher - Blood Rites
Debian (Unstable) GNU/Linux 2.6.18-mm3 2x5042 bogomips load 0.91
