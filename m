Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVB1Saj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVB1Saj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVB1Saj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:30:39 -0500
Received: from calma.pair.com ([209.68.1.95]:37134 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261668AbVB1Sag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:30:36 -0500
Date: Mon, 28 Feb 2005 13:30:36 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: linux-kernel@vger.kernel.org
Subject: Scheduler question in __wake_up_common() - Real Time Apps
Message-ID: <20050228183036.GA22914@calma.pair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about the implementation in __wake_up_common() that I'm
hoping someone might know the background on.  This function wakes up
a specified number of tasks for a wait_queue.  I'm wondering why it doesn't
wake up the tasks in priority order, so that for things following wake-one 
semantics high priority tasks get woken up before lower priority tasks.

The only thing I can think of off the top of my head is that it simplifies the 
O(1) implementation, but I'm wondering if maybe there is something else.

Thanks,

Chad
