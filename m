Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVGNVhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVGNVhI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGNVhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:37:07 -0400
Received: from fmr14.intel.com ([192.55.52.68]:34734 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261730AbVGNVhE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:37:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Thu, 14 Jul 2005 17:35:33 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30040CF924@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Thread-Index: AcWIWmDchQJij/LWQViSUIBmjHKYUAAYKwdA
From: "Brown, Len" <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>,
       "Lee Revell" <rlrevell@joe-job.com>
Cc: "dean gaudet" <dean-list-linux-kernel@arctic.org>,
       "Chris Wedgwood" <cw@f00f.org>, "Andrew Morton" <akpm@osdl.org>,
       <dtor_core@ameritech.net>, <torvalds@osdl.org>, <vojtech@suse.cz>,
       <david.lang@digitalinsight.com>, <davidsen@tmr.com>,
       <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       <mbligh@mbligh.org>, <diegocg@gmail.com>, <azarah@nosferatu.za.org>,
       <christoph@lameter.com>
X-OriginalArrivalTime: 14 Jul 2005 21:35:35.0691 (UTC) FILETIME=[F85B1DB0:01C588BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Of course using APIC internal timers is generally the best idea on SMP,
>but they may have had reasons to avoid them (it's not an ISA interrupt,
so
>it could have been simply out of question in the initial design).

Best?  No.

Local APIC timers are based on a clock which on many processors will
STOP when the processor enters power saving idle states, such as C3.
So the LAPIC timer will not accurately reflect how much time
has passed across entry/exit from idle.

True, this has not been an issue on SMP, since there have not been
SMP systems shipping with C3, but as you know soon everything
interesting will be SMP...

-Len

