Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVHLCU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVHLCU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVHLCUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:20:24 -0400
Received: from waste.org ([216.27.176.166]:64679 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964783AbVHLCTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:48 -0400
Date: Thu, 11 Aug 2005 21:18:28 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
Message-Id: <1.502409567@selenic.com>
Subject: [PATCH 0/8] netpoll: various bugfixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up a few outstanding bugs in netpoll:

- two bugfixes from Jeff Moyer's netpoll bonding
- a tweak to e1000's netpoll stub
- timeout handling for e1000 with carrier loss
- prefilling SKBs at init
- a fix-up for a race discovered in initialization
- an unused variable warning

This patch set was tested over repeated rebooting with both tg3 and
e1000 and random cable disconnection, with and without SMP and
preempt. Please apply.
