Return-Path: <linux-kernel-owner+w=401wt.eu-S932201AbXADAZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbXADAZt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbXADAZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:25:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:7748 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932201AbXADAZs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:25:48 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,234,1165219200"; 
   d="scan'208"; a="184283756:sNHT29270619"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Date: Wed, 3 Jan 2007 16:25:46 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C01A4FB7D@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <20070104001225.GA31434@gnuppy.monkey.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lock stat for -rt 2.6.20-rc2-rt2.2.lock_stat.patch
Thread-Index: AccvlQtznhyyAOpAS0KJGWyZ7ftWhgAAJmmw
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Bill Huey \(hui\)" <billh@gnuppy.monkey.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 04 Jan 2007 00:25:47.0973 (UTC) FILETIME=[E1972F50:01C72F96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> 
> Good to know that. What did the output reveal ?
> 
> What's your intended use again summarized ? futex contention ? I'll
> read the first posting again.
> 

Earlier I used latency_trace and figured that there was read contention
on mm->mmap_sem during call to _rt_down_read by java threads
when I was running volanomark.  That caused the slowdown of the rt
kernel
compared to non-rt kernel.  The output from lock_stat confirm
that mm->map_sem was indeed the most heavily contended lock.

Tim
