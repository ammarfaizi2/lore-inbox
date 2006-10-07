Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWJGNFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWJGNFo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbWJGNFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:05:44 -0400
Received: from ns.suse.de ([195.135.220.2]:19600 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751548AbWJGNFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:05:43 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061007105758.14024.70048.sendpatchset@linux.site>
Subject: [rfc] 2.6.19-rc1: vm stuff
Date: Sat,  7 Oct 2006 15:05:37 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first 3 patches are some minor fixes and rearrangements for the
page allocator and are probably fit to go into -mm.

The next set of 3 patches is another attempt at solving the invalidate
vs pagefault race (this got reintroduced after invalidate_complete_page2
was added, and has always been present for nonlinear mappings). These
are booted and have had some stress testing, but are still at the RFC
stage. Comments?

Nick

