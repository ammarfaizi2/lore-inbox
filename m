Return-Path: <linux-kernel-owner+w=401wt.eu-S1161222AbXAMD1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbXAMD1u (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbXAMD1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:27:49 -0500
Received: from mx1.suse.de ([195.135.220.2]:49698 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161222AbXAMD1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:27:46 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, thomas@tungstengraphics.com
Message-Id: <20070113011526.9479.79596.sendpatchset@linux.site>
Subject: [patch 0/7] fault vs truncate/invalidate race fix
Date: Sat, 13 Jan 2007 04:27:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches fix the fault vs invalidate and fault
vs truncate_range race for filemap_nopage mappings, plus those and
fault vs truncate race for nonlinear mappings.

Hasn't changed since I last submitted it, when it was rejected because
it made one of the buffered write deadlocks easier to hit. I'll try
again.

Patches based on 2.6.20-rc4. Comments?

Thanks,
Nick

--
SuSE Labs

