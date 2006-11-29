Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757076AbWK2DAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076AbWK2DAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 22:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757046AbWK2DAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 22:00:23 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:22989 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1757072AbWK2DAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 22:00:22 -0500
Date: Tue, 28 Nov 2006 22:00:18 -0500
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Message-Id: <20061129025728.15379.50707.sendpatchset@localhost>
Subject: [PATCH 0/5][time][x86_64] GENERIC_TIME patchset for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi,
	First let me apologize, I've been busy with other things and 
its been far too long since I last posted this. Anyway, I found some 
time to resync my trees and wanted to send this along.

You had asked earlier about performance impact:

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

Ingo has a few cleanups I need to merge, but otherwise I think this is 
getting close to ready for inclusion into -mm for testing. Please let 
me know if you have any major objections and if not I'll re-diff it 
against -mm and send it to Andrew. 

New in the current C7 release:
o Synched up w/ 2.6.19-rc6-git11
o Reworked the patch order to be a bit more logical
o Dropped the apic_runs_main_timer removal on Andi's request

Let me know if you have any thoughts or comments!

thanks again!
-john
