Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVC1HtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVC1HtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 02:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVC1HtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 02:49:13 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:61854 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261279AbVC1HtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 02:49:10 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
Date: Mon, 28 Mar 2005 02:49:04 -0500
User-Agent: KMail/1.7.2
Cc: lenb@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503280249.05933.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

I've noticed something strange with issuing 'standby' to the system:

when echoing "standby" to /sys/power/state, nothing happens, not even a log or 
system activity to attempt standby mode.

However, trying echo "1" to /proc/acpi/sleep the system attempts to (standby) 
and aborts:

[4295945.236000] PM: Preparing system for suspend
[4295946.270000] Stopping tasks: 
=============================================================================|
[4295946.370000] Restarting tasks... done

We get no reason as to why it quickly aborts. 

[4294672.065000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294676.827000] ACPI: (supports S0 S3 S4 S5)

What is '1' in /proc/acpi/sleep?  standby mode is not the same as suspend to 
ram? when I put a normal desktop in standby mode its still 'on' but the hard 
disk is put to sleep and the system runs in a lower power mode. 

Shawn.
