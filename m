Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVH3XFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVH3XFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVH3XFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:05:23 -0400
Received: from fmr14.intel.com ([192.55.52.68]:30668 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932270AbVH3XFW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:05:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Date: Tue, 30 Aug 2005 16:05:04 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0443A9A1@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Thread-Index: AcWtFfSdDDh9ZVbYSUWGXEC/+e3vqgAoNSQQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Christoph Lameter" <clameter@engr.sgi.com>,
       "Rusty Lynch" <rusty@linux.intel.com>
Cc: "Andi Kleen" <ak@suse.de>, "Lynch, Rusty" <rusty.lynch@intel.com>,
       <linux-mm@kvack.org>, <prasanna@in.ibm.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
X-OriginalArrivalTime: 30 Aug 2005 23:05:06.0000 (UTC) FILETIME=[42B97D00:01C5ADB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Please do not generate any code if the feature cannot ever be 
>used (CONFIG_KPROBES off). With this patch we still have lots of 
>unnecessary code being executed on each page fault.

I can (eventually) wrap this call inside the #ifdef CONFIG_KPROBES.

But I'd like to keep following leads on making the overhead as
low as possible for those people that do have KPROBES configured
(which may be most people if OS distributors ship kernels with
this enabled).

-Tony
