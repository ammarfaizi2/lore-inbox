Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967282AbWK3W7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967282AbWK3W7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967945AbWK3W7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:59:40 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:54418 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S967282AbWK3W7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:59:39 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19 00/10] Kernel memory leak detector 0.12
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2006 22:59:35 +0000
Message-ID: <20061130225219.5469.2453.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches represent version 0.12 of the kernel memory
leak detector. See the Documentation/kmemleak.txt file for a more
detailed description. The patches are downloadable from (the whole
patch or the broken-out series) http://www.procode.org/kmemleak/

What's new in this version:

- updated to Linux 2.6.19
- fixed a series of false positives caused but not scanning all the
  data sections in modules (like .data.read_mostly)
- reduced the transient false positives by imposing a configurable
  threshold on the number of times an object needs to be detected as
  leak before being reported

-- 
Catalin
