Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWEXAPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWEXAPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWEXAPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:15:15 -0400
Received: from [63.64.152.142] ([63.64.152.142]:1286 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S932117AbWEXAPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:15:13 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 0/9] I/OAT repost
Date: Tue, 23 May 2006 17:16:53 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060524001653.19403.31396.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of the I/OAT patches, the only changes from last time
are refreshing the patches and removing an unused macro that was causing
the vger spam filters to drop patch 2/9.

This patch series is the a full release of the Intel(R) I/O
Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
engine, and changes to the TCP stack to offload copies of received
networking data to application space.

These changes apply to Linus' tree as of commit
	387e2b0439026aa738a9edca15a57e5c0bcb4dfc
	[BRIDGE]: need to ref count the LLC sap

They are available to pull from
	git://63.64.152.142/~cleech/linux-2.6 ioat-2.6.18

There are 9 patches in the series:
	1) The memcpy offload APIs and class code
	2) The Intel I/OAT DMA driver (ioatdma)
	3) Core networking code to setup networking as a DMA memcpy client
	4) Utility functions for sk_buff to iovec offloaded copy
	5) Structure changes needed for TCP receive offload
	6) Rename cleanup_rbuf to tcp_cleanup_rbuf
	7) Make sk_eat_skb aware of early copied packets
	8) Add a sysctl to tune the minimum offloaded I/O size for TCP
	9) The main TCP receive offload changes

--
Chris Leech <christopher.leech@intel.com>
I/O Acceleration Technology Software Development
LAN Access Division / Digital Enterprise Group 
