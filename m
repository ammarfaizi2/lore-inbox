Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWGAO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWGAO4u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWGAO4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:56:50 -0400
Received: from www.osadl.org ([213.239.205.134]:17316 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751366AbWGAO4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:56:50 -0400
Message-Id: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:54:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 00/44] Consolidate irq_action flags
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent interrupt rework introduced bit value conflicts with sparc.
Instead of introducing new architecture flags mess, move the interrupt
SA_ flags out of the signal namespace and replace them by interrupt
related flags.

This allows to remove the obsolete SA_INTERRUPT flag and clean up
the bit field values.

The patch was mostly created by a script, manually fixed up and reviewed.
Compile tested on various platforms. Boot tested on i386/x86_64

	tglx
--

