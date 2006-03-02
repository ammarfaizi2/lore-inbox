Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWCBTSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWCBTSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCBTSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:18:50 -0500
Received: from fmr18.intel.com ([134.134.136.17]:28100 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750976AbWCBTSt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:18:49 -0500
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 14:16:07 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30063F8FF8@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16rc5 'found' an extra CPU.
Thread-Index: AcY+EkTfG7mmYEUyT02yIQkbL9mmawAGmdZw
From: "Brown, Len" <len.brown@intel.com>
To: "Romano Giannetti" <romanol@upcomillas.es>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: "Dave Jones" <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 19:16:07.0221 (UTC) FILETIME=[C1C82E50:01C63E2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/acpi/processor/CPU0/throttling 

Yes, the generic layer should expose throttling.
But before it does so, it needs to learn that T-states
have very different implications from P-states.

Indeed it is a bug in the current architecture that
P-states are exposed by cpufreq on some systems,
and T-states are exposed on other systems, and
they are treated like they are the same.

It is also bug that T-states are exposed
on some systems, while ACPI is simultaneously
assuming exclusive access to them for thermal throttling.

-Len
