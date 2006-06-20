Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWFTBQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWFTBQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 21:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWFTBQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 21:16:19 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:10565 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965037AbWFTBQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 21:16:19 -0400
Message-ID: <44974C60.9050508@bigpond.net.au>
Date: Tue, 20 Jun 2006 11:16:16 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Why is activate_task() used in __migrate_task()?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 20 Jun 2006 01:16:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem to me that using activate_task() in __migrate_task() in 
lieu of __activate_task() has two undesirable consequences: 1) 
recalculating and resetting prio and 2) resetting the time stamp.  The 
fact that the time stamp is adjusted for the change of run queue just 
before activate_task() is called reinforces my suspicion that these 
consequences are unintended.

Is there a reason for using activate_task() that I can't see?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
