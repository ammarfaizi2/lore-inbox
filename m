Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932268AbWFDV7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWFDV7x (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWFDV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:59:53 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:11414 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932268AbWFDV7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:59:53 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc5 0/8] Kernel memory leak detector 0.5
Date: Sun, 04 Jun 2006 22:56:36 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060604215636.16277.15454.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.5) of the kernel memory leak detector. It is
mainly a bug-fix release after testing it with a wider range of kernel
modules. See the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the bundled patch or
the series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.17-rc5-kmemleak-0.5.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.5.tar.bz2

What's new in this version:

- fixed panic caused by some secondary offsets in modules
- removed the panic when not all aliases are found for freed pointers
  as the aliases list can be modified by modules insertion
- following Pavel's suggestion, shortened the function names by
  removing "_debug"

To do:

- more testing
- test Ingo's suggestion on task stacks scanning
- NUMA support
- (support for ioremap tracking)

Note that gcc4 cannot compile the kernels with this patch because of a
bug with __builtin_constant_p (always returning true).

Any bug reports or suggestions are more than welcome as I can only
test it with a limited number of kernel configurations.

Thanks.

-- 
Catalin
