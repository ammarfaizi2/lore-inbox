Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVDEOMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVDEOMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDEOMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:12:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30941 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261755AbVDEOL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:11:59 -0400
Date: Fri, 1 Apr 2005 21:18:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: LKML <linux-kernel@vger.kernel.org>, lenb@intel.com
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Message-ID: <20050401191848.GA1330@openzaurus.ucw.cz>
References: <200503280249.05933.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503280249.05933.shawn.starr@rogers.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've noticed something strange with issuing 'standby' to the system:
> 
> when echoing "standby" to /sys/power/state, nothing happens, not even a log or 
> system activity to attempt standby mode.
> 
> However, trying echo "1" to /proc/acpi/sleep the system attempts to (standby) 
> and aborts:
> 
> [4295945.236000] PM: Preparing system for suspend
> [4295946.270000] Stopping tasks: 
> =============================================================================|
> [4295946.370000] Restarting tasks... done
> 
> We get no reason as to why it quickly aborts. 

> [4294672.065000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> [4294676.827000] ACPI: (supports S0 S3 S4 S5)


...aha, but your system does not support S1 aka standby.
 
> What is '1' in /proc/acpi/sleep?  standby mode is not the same as suspend to 
> ram? when I put a normal desktop in standby mode its still 'on' but the hard 
> disk is put to sleep and the system runs in a lower power mode. 

stanby != suspend to ram.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

