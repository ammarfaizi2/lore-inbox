Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWDTRGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWDTRGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDTRGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:06:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45537 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751165AbWDTRGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:06:13 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060228202202.14172.60409.sendpatchset@linux.site>
Subject: [patch 0/5] mm: improve remapping of vmalloc regions
Date: Thu, 20 Apr 2006 19:06:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like some feedback about this patchset -- whether it is the right
design, and the implementation (e.g. people might dislike patch 4).

vm_insert_page and remap_pfn_range loops are really clever, bit
probably asking a bit too much of most drivers. I was able to get
rid of most of them without too much trouble.

Not tested, because I don't have any of the hardware, but it seems
compiles OK.

Nick
