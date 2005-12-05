Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbVLETml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbVLETml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVLETmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:42:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:32926 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932536AbVLETmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:42:39 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512050626.jB56Qf1o032238@auster.physics.adelaide.edu.au>
References: <200512050626.jB56Qf1o032238@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 11:42:36 -0800
Message-Id: <1133811756.7605.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 16:56 +1030, Jonathan Woithe wrote:
> Hi all
> 
> When running Ingo's 2.6.14-rt21 (and in fact rt kernels back to at least
> 2.6.13-rc days), the clock on my i915-based laptop runs slow.  The degree
> of slowness appears directly related to how busy the machine is.  If
> it is just sitting around doing very little the time is kept rather
> well.  However, as soon as the load increases the RTC and system time
> diverge significantly.  For example, running jackd for 2 minutes results
> in the system time loosing as much as 20 seconds compared to the CMOS RTC.
> Processes doing HDD I/O also seem to affect the system time similarly.
> 
> Selectively disabling different timer-related kernel options does not make
> any difference.  However, the clock seems fine under vanilla 2.6.14,
> suggesting an issue somewhere in the rt patches.

Could you please send me your dmesg and the output of:

	cat  /sys/devices/system/clocksource/clocksource0/*


Thanks
-john


