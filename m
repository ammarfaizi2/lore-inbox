Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUFGN5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUFGN5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUFGN5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:57:49 -0400
Received: from holomorphy.com ([207.189.100.168]:14775 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264623AbUFGN5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:57:42 -0400
Date: Mon, 7 Jun 2004 06:57:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040607135738.GZ21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406070139.38433.kernel@kolivas.org> <20040607135631.GY21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607135631.GY21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 06:56:31AM -0700, William Lee Irwin III wrote:
> There is only one "array" per runqueue; the removed code should be at
> most a BUG_ON() or WARN_ON(); I opted to delete it altogether.

JIFFIES_TO_NS() is unused.

Index: kolivas-2.6.7-rc2/kernel/sched.c
===================================================================
--- kolivas-2.6.7-rc2.orig/kernel/sched.c	2004-06-07 06:49:10.104411000 -0700
+++ kolivas-2.6.7-rc2/kernel/sched.c	2004-06-07 06:50:39.987747000 -0700
@@ -74,7 +74,6 @@
  * Some helpers for converting nanosecond timing to jiffy resolution
  */
 #define NS_TO_JIFFIES(TIME)	((TIME) / (1000000000 / HZ))
-#define JIFFIES_TO_NS(TIME)	((TIME) * (1000000000 / HZ))
 
 //This is the time all tasks within the same priority round robin.
 #define RR_INTERVAL		((10 * HZ / 1000) ? : 1)
