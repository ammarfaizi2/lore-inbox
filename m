Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTEATKt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 15:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbTEATKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 15:10:48 -0400
Received: from mtvwca1-smrly1.gtei.net ([128.11.176.196]:13251 "HELO
	mtvwca1-smrly1.gtei.net") by vger.kernel.org with SMTP
	id S262188AbTEATKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 15:10:48 -0400
Message-ID: <6AF24836F3EB074BA5C922466F9E92E10791B52F@prince.pc.cognex.com>
From: "Lee, Shuyu" <SLee@cognex.com>
To: linux-kernel@vger.kernel.org
Subject: How to notify a user process from within a driver
Date: Thu, 1 May 2003 15:23:04 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, All.

I am working on a device driver. One of the features of the hardware is
multi-channel I/O control. In order for a user process to communicate with
the hardware, my design is for the user process to call the driver's ioctl
to register a semaphore for each I/O channel, then wait on them. When the
hardware detects an input, the ISR then BH will wake up the user process.
This sounds straightforward in principle. Because there are two types of
semaphores in Linux (one for kernel, and one for user), I am not sure how
this can be accomplished. Any help would be greatly appreciated.  

My development environment is:
1) OS:  RedHat 7.2 (Linux 2.4.7),
2) gcc: 3.2.1,
3) PC:  one P-III (HP kayak) with 128Mbyte of memory,
4) Bus: PCI.

Shuyu

