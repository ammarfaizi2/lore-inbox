Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWE3OHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWE3OHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWE3OHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:07:21 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:65174 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932273AbWE3OHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:07:20 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Reply-To: catalin.marinas@gmail.com
Subject: [PATCH 2.6.17-rc5 0/7] Kernel memory leak detector 0.3
Date: Tue, 30 May 2006 14:50:16 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060530135016.21491.34817.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 30 May 2006 14:07:10.0854 (UTC) FILETIME=[5802CA60:01C683F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.3) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are also available from
http://homepage.ntlworld.com/cmarinas/kmemleak/ (to be uploaded
shortly).

What's new in this version:

- more clean-up
- initial kernel modules support. It scans the data sections in a
  module while ignoring the text areas
- minor optimisation to avoid radix-tree lookup when updating
  the pointer information
- DEBUG_FS selected automatically (until/if a different method of
  triggering the memory scanning is implemented)

To do:

- better testing
- support for pointer aliases in kernel modules (i.e. container_of
  usage in modules)
- test Ingo's suggestion on task stacks scanning
- NUMA support

-- 
Catalin
