Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUFUUiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUFUUiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUFUUiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:38:54 -0400
Received: from smtp07.web.de ([217.72.192.225]:48264 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S266457AbUFUUiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:38:51 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 error message (oops)
Date: Mon, 21 Jun 2004 22:38:47 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406212238.49959.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I just booted 2.6.7 on one of our systems and see this oops from dmesg:

eth11: network connection down
Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:119
in_atomic():0, irqs_disabled():1
 [<c01072ae>] dump_stack+0x1e/0x20
 [<c0121690>] __might_sleep+0xb0/0xe0
 [<c0433ecb>] netdev_run_todo+0x2b/0x290
 [<c04338e9>] dev_ioctl+0x269/0x300
 [<c0476e0c>] inet_ioctl+0x8c/0xa0
 [<c04292c8>] sock_ioctl+0x138/0x350
 [<c017e2b4>] sys_ioctl+0x144/0x2d0
 [<c01063bf>] syscall_call+0x7/0xb

eth11: network connection up using port A
    speed:           1000
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    role:            slave
    irq moderation:  disabled
    scatter-gather:  enabled


The device eth11 is the (ifrename) mapped eth1:

sk98lin: Network Device Driver v6.23
(C)Copyright 1999-2004 Marvell(R).
eth1: SK-9821 V2.0 Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
netconsole: not configured, aborting


Any ideas if this oops is critical? If more information are required, please 
tell me.


Thanks,	
	Bernd
