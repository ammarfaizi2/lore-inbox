Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWDHBz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWDHBz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 21:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWDHBz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 21:55:29 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:4450 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964991AbWDHBz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 21:55:29 -0400
Message-ID: <4437180E.2090006@bigpond.net.au>
Date: Sat, 08 Apr 2006 11:55:26 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible problem in activate_task() with priority inheritance in
 2.6.17-rc1-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 8 Apr 2006 01:55:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In activate_task() the call to recalc_task_prio() is guarded by 
!rt_task().  This will suppress the recalculation of normal_prio for non 
RT tasks that just happen to be at real time priority as a result of 
priority inheritance.  Is that intentional?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
