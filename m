Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWBIUBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWBIUBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWBIUBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:01:51 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:29066 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750746AbWBIUBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:01:51 -0500
X-ME-UUID: 20060209200143667.A2E101C0015B@mwinf0612.wanadoo.fr
From: Vincent ETIENNE <ve@vetienne.net>
To: linux-kernel@vger.kernel.org
Subject: BUG at drivers/net/dl2k.c
Date: Thu, 9 Feb 2006 21:01:41 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602092101.41970.ve@vetienne.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using 2.6.14-mm2 kernel (x86_64) on a Bi-Opteron 246 board with a   PCI-64 
card ( DLINK 550 GT ) plug  on PCI-X interface. This card use the DL2000 
driver which seems to cause this problem logged during boot time  : 

BUG: warning at drivers/net/dl2k.c:1481/mii_wait_link()

Call Trace: <IRQ> <ffffffff802a9c0a>{rio_interrupt+1709}
       <ffffffff8013f3ef>{hrtimer_run_queues+197} 
<ffffffff801465ac>{handle_IRQ_event+41}
       <ffffffff80146678>{__do_IRQ+155} <ffffffff8010d69e>{do_IRQ+57}
       <ffffffff80108ce5>{default_idle+0} <ffffffff8010afa8>{ret_from_intr+0} 
<EOI>
       <ffffffff803a6d03>{thread_return+87} 
<ffffffff80108d10>{default_idle+43}
       <ffffffff80108f47>{cpu_idle+98} 
<ffffffff8052d114>{start_secondary+1271}
eth0: Link up
Auto 1000 Mbps, Full duplex
Enable Tx Flow Control
Enable Rx Flow Control

This is a new ethernet card so i don't have old bootlog to see if it happens 
before. I just test it with 2.6.15-mm4 where i don't see this problem  and 
2.6.16.rc1-mm4 ( where i see it)

Except this message everything is running fine (even the ethernet card)  so 
it's probably not so important. But in case it could be useful....

If you would like more information or would like me to test something don't 
hesitate.

Sorry for poor english,  it's not my mother tongue language

Vincent ETIENNE





