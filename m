Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVJUOsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVJUOsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVJUOsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:48:30 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83]:45289 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964943AbVJUOs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:48:29 -0400
Date: Fri, 21 Oct 2005 09:48:28 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt_Domsch@dell.com, rocky.craig@hp.com
Subject: [PATCH 0/9] IPMI driver updates
Message-ID: <20051021144828.GA22995@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch of Dell has been working very hard getting the IPMI driver
working well on Dell machines, and I've been working on converting the
IPMI driver over to use refcounts without using macros of death.  This
is a set of patches destined for 2.6.15, if they are ok.

Patches included are:

ipmi-use-refcounts.patch - The big one, convert over to refcounts
ipmi-various-si-cleanups.patch - Lots of little cleanups from Matt
ipmi-watchdog-parm-in-sysfs.patch - Parms in sysfs are nice
ipmi-poweroff-cleanups.patch - Fix stupid mistakes on my part
ipmi-more-dell-fixes.patch - Fixes for handling some firmware issues
ipmi-si-start-transaction-hook.patch - Hooks for handling firmware bugs
	and some hacks for some Dell machines.
ipmi-bt-restart-reset-fixes.patch - Fix an error recovery case in BT
ipmi-kcs-error0-delay.patch - Fix an error recovery case in KCS
ipmi-timer-thread.patch - A thread to make IPMI run faster on average.

