Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWFJKcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWFJKcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWFJKcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:32:05 -0400
Received: from www.osadl.org ([213.239.205.134]:56211 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751481AbWFJKcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:32:04 -0400
Message-Id: <20060610085428.366868000@cruncher.tec.linutronix.de>
Date: Sat, 10 Jun 2006 10:15:10 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 0/2] genirq updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

the dust has settled. Please add the following updates to genirq.

The simple one is to allow the usage of no_irq_chip for real dumb
PICs.

The deadlock problems seen by Russell on neponset and also by Kevin 
on omap turned out to be reentrancy problems. The original ARM 
implementation had no reentrancy check in the simple_irq handler 
and the network driver magically did not break when the interrupt 
handler was reentered. ARM related fixups are seperate.

	tglx

--

