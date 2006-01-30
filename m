Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWA3VgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWA3VgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWA3VgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:36:14 -0500
Received: from smtp05.web.de ([217.72.192.209]:22493 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S1030189AbWA3VgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:36:12 -0500
Subject: cpufreq: powenow-k7 up-machine with smp-kernel
From: Thomas Meyer <thomas.mey@web.de>
To: linux-kernel@vger.kernel.org
Cc: bcollins@ubuntu.com
Content-Type: text/plain
Date: Mon, 30 Jan 2006 22:36:05 +0100
Message-Id: <1138656965.14867.8.camel@hotzenplotz.treehouse>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The patch in mm-tree
"powernow-k7-work-when-kernel-is-compiled-for-smp.patch" doesn't work
with current linus git-tree. The real problem is the function
"recalibrate_cpu_khz" which is parted of timers/timer_tsc.c (an
impilicit dependency! is this timer always available?).
for an smp kernel this function always returns -ENODEV.
The other changes in the patch are not needed, as fas as i understand.

Without the recalibrate_cpu_khz call the driver works on an up-machine
with an smp-kernel.

Why is the powernow-k7 driver the only driver which does this call to
recalibrate_cpu_khz, which corrects the jiffies for the new cpu
frequency)?


with kind regards
Thomas

