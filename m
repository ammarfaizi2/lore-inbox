Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUA3AwR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbUA3AwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:52:17 -0500
Received: from netmail8.mail.umd.edu ([128.8.30.201]:28879 "EHLO mail.umd.edu")
	by vger.kernel.org with ESMTP id S266263AbUA3AwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:52:16 -0500
Subject: orinoco_cs IRQ problem with 2.6.0
From: Dan Lenski <lenski@umd.edu>
To: linux-kernel@vger.kernel.org
X-Auth-OK: lenski@mail.umd.edu
X-NIMS-Flags: 513
Content-Type: text/plain
Message-Id: <1075423670.1212.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 19:50:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new to the list.  My D-Link cardbus wireless card worked fine under
2.4.22 using the orinoco_cs drivers, and the pcmcia-cs-3.2.5 package.

Under 2.6.0, with the orinoco_cs driver, I get the following errors in
my syslog:

Jan 29 19:29:07 localhost cardmgr[684]: initializing socket 0
Jan 29 19:29:07 localhost cardmgr[684]: socket 0: D-Link DWL-650
Jan 29 19:29:07 localhost cardmgr[684]:   product info: "D", "Link DWL-650 11Mbps WLAN Card", "Version 01.02", ""
Jan 29 19:29:07 localhost cardmgr[684]:   manfid: 0x0156, 0x0002  function: 6 (network)
Jan 29 19:29:07 localhost cardmgr[684]: executing: 'modprobe orinoco_cs'
Jan 29 19:29:07 localhost kernel: orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Jan 29 19:29:07 localhost kernel: orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Jan 29 19:29:07 localhost kernel: orinoco_cs: RequestIRQ: Unsupported mode
Jan 29 19:29:08 localhost cardmgr[684]: get dev info on socket 0 failed: Resource temporarily unavailable

With 2.4.22, the card was assigned irq 3.  With 2.6.0, that irq is not
listed in my /proc/interrupts.

Dan Lenski
lenski@physics.umd.edu

