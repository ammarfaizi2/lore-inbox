Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263332AbVGOQfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbVGOQfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 12:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbVGOQfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 12:35:53 -0400
Received: from fmr16.intel.com ([192.55.52.70]:36267 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S263334AbVGOQfC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 12:35:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Fri, 15 Jul 2005 12:33:15 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Thread-Index: AcWJIOHkaU7FfzkYT0KVSuN7gYVC/gAOCHZA
From: "Brown, Len" <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "dean gaudet" <dean-list-linux-kernel@arctic.org>,
       "Chris Wedgwood" <cw@f00f.org>, "Andrew Morton" <akpm@osdl.org>,
       <dtor_core@ameritech.net>, <torvalds@osdl.org>, <vojtech@suse.cz>,
       <david.lang@digitalinsight.com>, <davidsen@tmr.com>,
       <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>,
       <mbligh@mbligh.org>, <diegocg@gmail.com>, <azarah@nosferatu.za.org>,
       <christoph@lameter.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 15 Jul 2005 16:33:18.0692 (UTC) FILETIME=[E8467240:01C5895A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That's an APIC bug.
>When Intel originally released the APIC (some
>thirteen years ago) they stated it should be used as a source of the
timer
>interrupt instead of the 8254.  There is no excuse for changing the
>behaviour after so many years.  So if you are on a broken system, you
may
>want to work around the bug, but it shouldn't impact good systems.


I'm perfectly happy having Linux optimize itself for the hardware
that it is running on.  However, the (harsh, I know) reality is that
systems with a reliable LAPIC timer in the face of C3 do not exist
today, and probably never will.  (don't shoot me, it wasn't my design
decision, I'm just the messenger:-)  Further, I expect that power saving
features, such as C3, will become more important and deployed more
widely in the future, rather than less widely.

So, the 13-year-old design advice will continue to apply to
13-year-old systems, but newer systems with C3 and HPET
should be using them.

-Len
