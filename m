Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVATBXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVATBXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVATBXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:23:39 -0500
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:22671 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S262021AbVATBXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:23:32 -0500
Message-ID: <41EF080D.7020101@bigpond.net.au>
Date: Thu, 20 Jan 2005 12:23:25 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Con Kolivas <kernel@kolivas.org>, Chris Han <xiphux@gmail.com>
Subject: [ANNOUNCE][RFC] plugsched-2.0 patches ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... are now available from:

<http://prdownloads.sourceforge.net/cpuse/plugsched-2.0-for-2.6.10.patch?download>

as a single patch to linux-2.6.10 and at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-2.0-for-2.6.10.patchset.tar.gz?download>

as a (gzipped and tarred) patch set including "series" file which 
nominates the order of application of the patches.

This is an update of the earlier version of plugsched (previously 
released by Con Kolivas) and has a considerably modified scheduler 
interface that is intended to reduce the amount of code duplication 
required when adding a new scheduler.  It also contains a sysfs 
interface based on work submitted by Chris Han.

This version of plugsched contains 4 schedulers:

1. "ingosched" which is the standard active/expired array O(1) scheduler 
created by Ingo Molnar,
2. "staircase" which is Con Kolivas's version 10.5 O(1) staircase scheduler,
3. "spa_no_frills" which is a single priority array O(1) scheduler 
without any interactive response enhancements, etc., and
4. "zaphod" which is a single priority array O(1) scheduler with 
interactive response bonuses, throughput bonuses and a choice of 
priority based or entitlement based interpretation of "nice".

Schedulers 3 and 4 also offer unprivileged real time tasks and hard/soft 
per task CPU rate caps.

The required scheduler can be selected at boot time by supplying a 
string of the form "cpusched=<name>" where <name> is one of the names 
listed above.

The default scheduler (that will be used in the absence of a "cpusched" 
boot argument) can be configured at build time and is set to "ingosched" 
by default.

The file /proc/scheduler contains a string describing the current scheduler.

The directory /sys/cpusched/<current scheduler name>/ contains any 
scheduler configuration control files that may apply to the current 
scheduler.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
