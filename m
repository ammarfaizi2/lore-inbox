Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWFOJPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWFOJPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWFOJPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:15:01 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:2537 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932090AbWFOJPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:15:01 -0400
Date: Thu, 15 Jun 2006 02:07:30 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606150907.k5F97UkF008084@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/16] 2.6.17-rc6 perfmon2 patch for review: introduction
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series of patches includes the generic perfmon2
subsystem and the support for i386, x86_64, and powerpc. The perfmon2
subsystem also works on MIPS and all Itanium processors. The Itanium support
is not posted because it does not easily accomodate the 100k message
limit of lkml. The powerpc support is still very preliminary.

The patches are relative to 2.6.17-rc6.

I have already posted on the list about this subsystem. I am submitting 
today to get reviews and make progress towards getting the subsystem
merged into the mainline kernel.

The patches are split up between common and arch-specific. Each part
is further decomposed into new files and modified files. The generic
code is now split up by functionality to make reading easier.

This patch includes (compared to previous patch for 2.6.17-rc5):
	- moved all set/multiplexing related code into a dedicated file,
	  name perfmon_sets.c.

	- cleaned a lot of code (for style, dead code)

	- switch all lists to use list.h 

	- fix locking bugs in perfmon_syscalls.c

	- simplified PMU description tables with macros to improve
	  readability and extensibility

	- updated Kconfig structure as per Roman's feedback

	- changed the pfarg_setinfo structure to include 2 new
	  bitfields to report list of available PMU registers

Thanks.
