Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVHKBV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVHKBV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVHKBV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:21:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39340 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750705AbVHKBV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:21:28 -0400
Subject: [RFC - 0/13] NTP cleanup work (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>, zippel@linux-m68k.org,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:21:19 -0700
Message-Id: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The goal of this patch set is to isolate the in kernel NTP state
machine in the hope of simplifying the current timekeeping code and
allowing for optional future changes in the timekeeping subsystem.

I've tried to address some of the complexity concerns for systems that
do not have a continuous timesource, preserving the existing behavior
while still providing a ppm interface allowing smooth adjustments to
continuous timesources. 

Patches 1-10 and patch 13 should be fairly straight forward only moving
and cleaning up various bits of code.

Patches 11 and 12 are somewhat more functional changes and should be
reviewed more carefully. Especially by someone who knows the PPC64
ppc_adjtimex() function in depth.

I've lightly tested this code on i386 and it seems to work properly. I'm
currently working to get more thorough testing done, but I wanted to get
it out there for review and hopefully a bit of testing.

Please let me know if you have any feedback or suggestions.

thanks
-john

