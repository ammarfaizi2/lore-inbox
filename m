Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVGOJj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVGOJj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVGOJj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:39:58 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:62470 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261702AbVGOJhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:37:51 -0400
Date: Fri, 15 Jul 2005 10:37:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       dtor_core@ameritech.net, torvalds@osdl.org, vojtech@suse.cz,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: RE: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30040CF924@hdsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61L.0507151031380.15977@blysk.ds.pg.gda.pl>
References: <F7DC2337C7631D4386A2DF6E8FB22B30040CF924@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Brown, Len wrote:

> >Of course using APIC internal timers is generally the best idea on SMP,
> >but they may have had reasons to avoid them (it's not an ISA interrupt,
> so
> >it could have been simply out of question in the initial design).
> 
> Best?  No.
> 
> Local APIC timers are based on a clock which on many processors will
> STOP when the processor enters power saving idle states, such as C3.
> So the LAPIC timer will not accurately reflect how much time
> has passed across entry/exit from idle.

 That's an APIC bug.  When Intel originally released the APIC (some 
thirteen years ago) they stated it should be used as a source of the timer 
interrupt instead of the 8254.  There is no excuse for changing the 
behaviour after so many years.  So if you are on a broken system, you may 
want to work around the bug, but it shouldn't impact good systems.

  Maciej
