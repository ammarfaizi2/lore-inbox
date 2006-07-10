Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWGJWJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWGJWJc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWGJWJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:09:32 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:18191 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965044AbWGJWJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:09:31 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 00/10] Kernel memory leak detector 0.8
Date: Mon, 10 Jul 2006 23:09:01 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710220901.5191.66488.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.8) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the whole patch or the
broken-out series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc1-kmemleak-0.8.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.8.tar.bz2

What's new in this version:

- reviewers comments implemented
- added support for type ids (currently approximated by sizeof)
- NUMA support
- reduced the memory allocation/freeing overhead by adding the
  pointer aliases to the radix tree only when scanning the memory
- improved documentation and in-code comments

To do:

- more testing
- more investigation into the task stacks scanning
- precise type identification (after first assessing the efficiency of
  the current method as it requires changes to the kernel API)
- (support for ioremap tracking)

-- 
Catalin
