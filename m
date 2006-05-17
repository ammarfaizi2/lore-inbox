Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWEQANY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWEQANY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWEQANY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:13:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42939 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750981AbWEQANY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:13:24 -0400
Date: Wed, 17 May 2006 02:13:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 00/50] genirq: -V3
Message-ID: <20060517001310.GA12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 3 of the genirq patch-queue, against 2.6.17-rc4. This 
patch-queue improves the generic IRQ layer to be truly generic, by 
adding various abstractions and features to it, without impacting 
existing functionality. It was written by Thomas Gleixner (who has done 
most of the heavy-lifting) and me. We reused many bits of code and many 
concepts from Russell King's ARM IRQ layer.

The ARM architecture has been updated to make use of this improved 
generic IRQ layer. The new code also enables a cleaner and simpler 
implementation of lowlevel irq-chip details, chained handlers and other 
highlevel irq-flow handlers.

The patch-queue consists of 50 individual patches. The queue begins with 
a handful of cleanups, to make sure we are adding features to a cleaned 
up codebase. Then come the features that dont need the irq-chip 
abstractions but are necessary extensions, then comes the core irq-chip 
abstraction (genirq-core), features that rely on it, and finally, the 
conversion of the ARM architecture to the new generic IRQ layer.

The full patch-queue can also be downloaded from:

  http://redhat.com/~mingo/generic-irq-subsystem/

It has been build-tested with allyesconfig, and booted on x86, x86_64 
and various ARM platforms. It has been build-tested on all the 50 ARM 
platforms. Current ARM testing results are at:

  http://www.linutronix.de/index.php?page=46

Many thanks to the ARM developers who ran the initial patches on their 
ARM boards and helped tracking down initial migration bugs.

Review suggestions for past iterations of this code from Andrew Morton, 
Benjamin Herrenschmidt and Christoph Hellwig were incorporated in this 
version.

Comments, suggestions welcome,

	Ingo, Thomas
