Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbULGJZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbULGJZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULGJZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:25:44 -0500
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:13834 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261693AbULGJZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:25:38 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc3 b44 resume problem
Date: Tue, 7 Dec 2004 10:25:31 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200412071025.32825.robin.rosenberg.lists@dewire.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't get my wired network running after resume from suspend to ram:

Dec  7 18:48:36 xine kernel: ifconfig: page allocation failure. order:8, 
mode:0x21
After stopping the network, and netplugd and rmmodding b44 and mii I still get
this when trying to start my network (when b44 is activated).

Dec  7 18:51:18 xine kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Dec  7 18:51:18 xine kernel:  [__alloc_pages+569/887] 
__alloc_pages+0x239/0x377
Dec  7 18:51:18 xine kernel:  [__get_free_pages+27/54] 
__get_free_pages+0x1b/0x36
Dec  7 18:51:18 xine kernel:  [dma_alloc_coherent+188/247] 
dma_alloc_coherent+0xbc/0xf7
Dec  7 18:51:18 xine kernel:  [pg0+546065382/1069609984] 
b44_alloc_consistent+0x99/0x152 [b44]
Dec  7 18:51:18 xine kernel:  [pg0+546066627/1069609984] b44_open+0x20/0xef 
[b44]
Dec  7 18:51:18 xine kernel:  [dev_open+116/131] dev_open+0x74/0x83
Dec  7 18:51:18 xine kernel:  [dev_change_flags+86/295] 
dev_change_flags+0x56/0x127
Dec  7 18:51:18 xine kernel:  [devinet_ioctl+1317/1501] 
devinet_ioctl+0x525/0x5dd
Dec  7 18:51:18 xine kernel:  [inet_ioctl+187/197] inet_ioctl+0xbb/0xc5
Dec  7 18:51:18 xine kernel:  [sock_ioctl+399/572] sock_ioctl+0x18f/0x23c
Dec  7 18:51:18 xine kernel:  [sys_ioctl+353/596] sys_ioctl+0x161/0x254
Dec  7 18:51:18 xine kernel:  [sysenter_past_esp+82/113] 
sysenter_past_esp+0x52/0x71

-- robin
