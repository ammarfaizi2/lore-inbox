Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVFBNDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVFBNDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVFBNBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:01:54 -0400
Received: from fmr18.intel.com ([134.134.136.17]:14800 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261412AbVFBNBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:01:21 -0400
Message-Id: <20050602125754.993470000@araj-em64t>
Date: Thu, 02 Jun 2005 05:57:55 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Cc: Rusty Russell <rusty@rustycorp.com.au>
Cc: Srivattsa Vaddagiri <vatsa@in.ibm.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: [patch 0/5] x86_64 CPU hotplug patch series.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached are the set of patches to support x86-64 logical cpu hot-add/remove.

Special thanks to Andi for painfully reviewing some interim versions.

It seems to hold tight for overnight stress tests with make -j's and 
hotplug happening in parallel. 

Andrew: Could you help test staging in -mm so we can get some wider testing
from those interested.

*Sore Point*: Andi doesnt agree with one patch that removes ipi-broadcast 
and uses only online map cpus receive IPI's. This is much simpler approach to 
handle instead of trying to remove the ill effects of IPI broadcast to CPUs in 
offline state.

Initial concern from Andi was IPI performance, but some primitive test with a 
good number of samples doesnt seem to indicate any degration at all, infact the
results seem identical. (Barring any operator errors :-( ).

It would be nice to hear other opinions as well, hopefuly we can close on
what what the right approach in this case. Link to an earlier discussion
on the topic.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111695485610434&w=2

Rusty (who has been hiding somewhere in the woods these days :-)), could 
you suggest something...

Cheers,
Ashok Raj

