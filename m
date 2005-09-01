Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVIASpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVIASpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVIASpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:45:35 -0400
Received: from fmr16.intel.com ([192.55.52.70]:56273 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030286AbVIASpe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:45:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Date: Thu, 1 Sep 2005 14:44:51 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E34@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Thread-Index: AcWu0fDrWwTqA0RoTYm9ntckSAWhfAAUkS6Q
From: "Brown, Len" <len.brown@intel.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Sep 2005 18:44:52.0771 (UTC) FILETIME=[3D574F30:01C5AF25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>How can we handle it, if we do not even know that it failed? 
>How should the user recognize something is broken?

We probably shouldn't have used the word "fail" here.

I expect the IO and MSR accesses will always "succeed",
but they may not always have the exact effect the OS requested.
I think we (the OS) need to get used to this.

The HW reserves the right to second guess the OS for a
variety of reasons, including temperature, power,
reliability, or dependencies between different hardware
units that may not be exposed to the OS.  I think as
hardware becomes more complex and more power-optimized,
we'll see more of this, not less.

cheers,
-Len
