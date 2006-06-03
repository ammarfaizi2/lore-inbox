Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWFCILX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWFCILX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWFCILW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:11:22 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:5067 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1030261AbWFCILV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:11:21 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.4
Date: Sat, 03 Jun 2006 09:10:54 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060603081054.31915.4038.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 03 Jun 2006 08:11:17.0437 (UTC) FILETIME=[4A08EED0:01C686E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.4) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the bundled patch or
the full series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.17-rc5-kmemleak-0.4.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.4.tar.bz2

What's new in this version:

- full kernel modules support
- kmemleak now depends on DEBUG_SLAB. The detection is improved by the
  objects poisoning caused by this configuration option
- freeing orphan pointers is no longer reported since these can be
  false positives
- replaced some _rcu list traversal loops with their normal or _safe
  form

To do:

- better testing
- test Ingo's suggestion on task stacks scanning
- NUMA support
- (support for ioremap)

-- 
Catalin
