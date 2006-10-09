Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWJIMsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWJIMsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWJIMsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:48:37 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:10839 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751872AbWJIMsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:48:36 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19-rc1 00/10] Kernel memory leak detector 0.11
Date: Mon, 09 Oct 2006 13:48:13 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20061009124813.2695.8123.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.11) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the whole patch or the
broken-out series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.19-rc1-kmemleak-0.11.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/broken-out/patches-kmemleak-0.11.tar.bz2

What's new in this version:

- updated to Linux 2.6.19-rc1
- kmemleak now uses the common API for getting stack traces, making it
  easier to support other architectures
- fixed bug in calculating the page order for the hash allocation

To do:

- testing on a wider range of platforms and configurations
- support for ioremap tracking
- eliminate the task stacks scanning (if possible, by marking the
  allocated blocks as temporary until the return to user-space -
  Ingo's suggestion)
- precise type identification (after first assessing the efficiency of
  the current method as it requires changes to the kernel API)

-- 
Catalin
