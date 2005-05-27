Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVE0OQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVE0OQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVE0OQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:16:21 -0400
Received: from odin2.bull.net ([192.90.70.84]:5884 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261676AbVE0OQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:16:17 -0400
Subject: Large transfert with 2.6.12rc5 +
	realtime-preempt-2.6.12-rc5-V0.7.47-10
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: BTS
Message-Id: <1117202758.15786.30.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Fri, 27 May 2005 16:05:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem with rc4+47-07
I reproduce this problem with a tg3 driver and with e1000 driver.
So I think it's not a driver problem.

I try to copy an iso image from this machine to another one by scp.
after 35 to 45MB, the copy become stalled with no more transfert.
We can ping the target machine, all apparently is OK except the scp
which finish with timeout.
With ftp, the stalled state is about 100MB.
If I reboot with a standard kernel ( without RT ), no problem.

I have the following config :
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT_DESKTOP is not set
CONFIG_PREEMPT_RT=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_BKL=y

Do you need my complete .config ?

I tried this on two different machines with the same effects.

