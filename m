Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVJYBMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVJYBMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVJYBMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:12:24 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:36503 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751403AbVJYBMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:12:24 -0400
Message-ID: <435D8675.3080303@bigpond.net.au>
Date: Tue, 25 Oct 2005 11:12:21 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.14-rc5-mm1 build fails for non SMP systems
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 25 Oct 2005 01:12:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_DEBUG_SPINLOCK configured in I'm getting a large number 
of "implicit declaration of function ‘__raw_read_unlock’" warnings and a 
subsequent failure at the link stage.

A trivial change to include/linux/spinlock_up.h (i.e. moving the 
definition of __raw_read_unlock() outside the ifdef) can get rid of this 
warning but I'm not sure that it's the right thing to do as I suspect 
this may be an indication of a less trivial problem elsewhere.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
