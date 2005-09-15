Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVIOIuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVIOIuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVIOIuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:50:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39108 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932218AbVIOIuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:50:46 -0400
Date: Thu, 15 Sep 2005 14:20:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, schwidefsky@de.ibm.com
Subject: [PATCH 0/3] NO_IDLE_HZ support patches
Message-ID: <20050915085015.GA10191@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_NO_IDLE_HZ (supported on s390 and ARM currently, but also gaining
x86 support very soon) lets timer ticks to be skipped on idle CPUs. This
has several implications on core kernel, which are addressed in
these patches sent in separate mails.


Patch 0/3	- 	This mail.
Patch 1/3	-	Fix a RCU race condition
Patch 2/3	- 	add_timer_on needs to check for wakeup of
			sleeping CPU.
Patch 3/3	- 	Take care of scheduler load imbalance because
			rebalance does not happen when idle
			CPU shuts of ticks for extended periods.
			(This is more of place holder right now for
			a real patch).
			

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
