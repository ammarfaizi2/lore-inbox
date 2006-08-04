Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWHDDZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWHDDZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHDDZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:25:19 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:457 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1751264AbWHDDZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:17 -0400
Message-Id: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:14 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] -mm  generic clocksoure API
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
