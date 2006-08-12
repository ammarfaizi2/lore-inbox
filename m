Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWHLV7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWHLV7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWHLV7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:59:44 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:2101 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751135AbWHLV7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:59:43 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Date: Sat, 12 Aug 2006 22:58:57 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812215857.17709.79502.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.9) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the whole patch or the
broken-out series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc4-kmemleak-0.9.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/broken-out/patches-kmemleak-0.9.tar.bz2

What's new in this version:

- updated for 2.6.18-rc4
- reviewers comments implemented
- the number of reports are limited to avoid soft-lockups in case of a
  serious memory leak
- some bug-fixes (including one that was preventing the page-aligned
  blocks from being reported)

To do:

- testing on a wider range of platforms and configurations
- support for ioremap tracking (once the generic ioremap patches are
  merged)
- eliminate the task stacks scanning (if possible, by marking the
  allocated blocks as temporary until the return to user-space -
  Ingo's suggestion)
- precise type identification (after first assessing the efficiency of
  the current method as it requires changes to the kernel API)

-- 
Catalin
