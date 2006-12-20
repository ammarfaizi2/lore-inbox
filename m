Return-Path: <linux-kernel-owner+w=401wt.eu-S932839AbWLTBUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbWLTBUp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWLTBUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:20:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47548 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932839AbWLTBUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:20:44 -0500
Date: Tue, 19 Dec 2006 20:20:39 -0500
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Message-Id: <20061220011707.25341.6522.sendpatchset@localhost>
Subject: [PATCH 0/5][time][x86_64] GENERIC_TIME patchset for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Andi,

	I didn't hear any objections (or really, any comments) on my 
last release, so as I mentioned then, I want to go ahead and push this 
to Andrew for a bit of testing in -mm. Hopefully targeting for 
inclusion in 2.6.21 or 2.6.22.

Here's the performance data from the last release:

Vanilla TSC:
149 nsecs per gtod call
367 nsecs per CLOCK_MONOTONIC call
288 nsecs per CLOCK_REALTIME call
Vanilla ACPI PM:
1272 nsecs per gtod call
1335 nsecs per CLOCK_MONOTONIC call
1273 nsecs per CLOCK_REALTIME call

GENERIC_TIME TSC:
149 nsecs per gtod call
304 nsecs per CLOCK_MONOTONIC call
275 nsecs per CLOCK_REALTIME call
GENERIC_TIME ACPI PM:
1273 nsecs per gtod call
1275 nsecs per CLOCK_MONOTONIC call
1273 nsecs per CLOCK_REALTIME call

So almost no performance change.

New in the current C8 release:
o Synced up w/ 2.6.20-rc1
o Added a few small cleanups from Ingo

Let me know if you have any thoughts or comments!

thanks again!
-john
