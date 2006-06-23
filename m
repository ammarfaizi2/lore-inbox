Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWFWJUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWFWJUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWFWJUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:20:46 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:3997 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750891AbWFWJUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:20:45 -0400
Date: Fri, 23 Jun 2006 02:12:57 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230912.k5N9CvQV032279@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/17] 2.6.17.1 perfmon2 patch for review: introduction
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series of patches includes the generic perfmon2
subsystem and the support for i386, x86_64, and powerpc. The perfmon2
subsystem also works on MIPS and all Itanium processors. The Itanium support
is not posted because it does not easily accomodate the 100k message
limit of lkml. The powerpc support is still very preliminary.

The patches are relative to 2.6.17.1

I have already posted on the list about this subsystem. I am submitting 
today to get reviews and make progress towards getting the subsystem
merged into the mainline kernel.

The patches are split up between common and arch-specific. Each part
is further decomposed into new files and modified files. The generic
code is now split up by functionality to make reading easier.

This patch includes (compared to previous patch for 2.6.17-rc6):
	- support for 32-bit mode AMD64 processors (Chuck Ebbert)
	- mini-argument buffers on stack optimization for read/write of PMU registers
	- fix user group permission checking which were ignored
	- fix a missing irqsave in perfmon_kapi.c

For the stack buffers there are per-arch constants that can be adjusted based
on stack size limitations. Look for PFM_ARCH_PM*_ARG.

Thanks.
