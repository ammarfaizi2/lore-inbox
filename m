Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWFKLVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWFKLVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWFKLVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 07:21:04 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:7791 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751034AbWFKLVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 07:21:03 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc6 0/9] Kernel memory leak detector 0.7
Date: Sun, 11 Jun 2006 12:18:15 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060611111815.8641.7879.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.7) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the bundled patch or
the series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.17-rc6-kmemleak-0.7.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.7.tar.bz2

What's new in this version:

- different configuration options added for tweaking kmemleak
- reduced the length of time running with interrupts disabled (the
  interrupts are now only disabled for individual memory block
  scanning rather than for the whole memory)
- fixed bug in the memleak_seq_* functions (pointer structure accessed
  after freeing)
- more false positives ignored

To do:

- more testing
- more investigation into the task stacks scanning
- NUMA support
- (support for ioremap tracking)

Many thanks to Michal Piotrowski for stress-testing kmemleak and
reporting various issues.

-- 
Catalin
