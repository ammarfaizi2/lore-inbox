Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422848AbWJFS5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422848AbWJFS5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422852AbWJFS5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:57:52 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:10531 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1422848AbWJFS5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:57:39 -0400
Message-Id: <20061006185439.667702000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 06 Oct 2006 11:54:39 -0700
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
CC: johnstul@us.ibm.com
Subject: [PATCH 00/10] -mm: generic clocksource API -v2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Each patch has it's own change log in the patch header, and each 
patch compiles and boots if applied individually (but in series order). 

---- Original release notes below

This patch set is meant to modify the clocksource structure and API so that it
can be used by more than just the timekeeping code. My motivation is mainly
that I feel the current clocksource interface could be used for much more
than just timekeeping. So if we keep the clocksource interface (which I think
we should) then we should get everything out of it that we can.

This set modifies the API, then converts the time keeping code over to the new
API. I also added a generic sched_clock() which just re-uses the clocksource
interface to provide a high quality scheduling clock (assuming a good
clocksource). Several ARM board just output nanoseconds based on jiffies which
is still possible with the generic sched_clock().

I tested this on SMP and UP x86, and compile tested for ARM.

Daniel

--

