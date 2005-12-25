Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVLYOoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVLYOoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 09:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVLYOoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 09:44:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42214 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750829AbVLYOoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 09:44:11 -0500
Date: Sun, 25 Dec 2005 15:44:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reiser4 with 2.6.15-rc5-rt4
Message-ID: <Pine.LNX.4.61.0512251535450.19959@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


it is possible to to patch the reiser4 code into 2.6.15-rc5-rt4, but 
rcu_barrier() is only available within the #ifndef CONFIG_PREEMPT_RCU block 
in kernel/rcupdate.c. However, if one has CONFIG_PREEMPT_RT=y, then 
CONFIG_PREEMPT_RCU=y, and hence no rcu_barrier() and the other two 
functions are available.
Does anyone have a patch that adds a rcu_barrier() and friends to the 
PREEMT_RCU block?


Jan Engelhardt
-- 
