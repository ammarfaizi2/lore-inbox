Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVGPCz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVGPCz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 22:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVGPCz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 22:55:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11917 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261232AbVGPCzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:55:25 -0400
Subject: [RFC - 0/12] NTP cleanup work (v. B4)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>, zippel@linux-m68k.org
Content-Type: text/plain
Date: Fri, 15 Jul 2005 19:55:17 -0700
Message-Id: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	In my attempts to rework the timeofday subsystem, it was suggested I
try to avoid mixing cleanups with functional changes. In response to the
suggestion I've tried to break out the majority of the NTP cleanups I've
been working out of my larger patch and try to feed it in piece meal. 

The goal of this patch set is to isolate the in kernel NTP state machine
in the hope of simplifying the current timeofday code.

Patches 1-10 should be fairly straight forward only moving and cleaning
up various bits of code.

Patches 11 and 12 are somewhat more functional changes and should be
reviewed more carefully. Especially by someone who knows the PPC64
ppc_adjtimex() function in depth.

I haven't been able to test this code, only checking that the code
builds on a number of arches, but since I may not have access to my
cogito repositories while I'm at OLS, I thought it might be worth while
to send this out for discussion.

Shortly after I send out these patches I hope to send out the rest of my
timeofday changes with apply on top of this patch set.

thanks
-john


