Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263659AbUCUOy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbUCUOy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:54:57 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25474
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263659AbUCUOy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:54:56 -0500
Date: Sun, 21 Mar 2004 15:55:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-aa1
Message-ID: <20040321145547.GA3649@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes MAP_SHARED|MAP_ANONYMOUS spotted by Jens and Martin, plus it
avoids vmware to crash (but it only warns about the missing VM_RESERVED
bitflag).

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa1/

Changelog diff between 2.6.5-rc1-aa3 and 2.6.5-rc2-aa1:

Binary files 2.6.5-rc1-aa3/anon_vma.gz and 2.6.5-rc2-aa1/anon_vma.gz differ

	Fixed silly bug in mmap(MAP_SHARED|MAP_ANONYMOUS) and converted a
	BUG_ON to a WARN_ON if some device driver passes non-pageable pages
	to the VM via ->nopage. VM_RESERVED it's not required with current
	VM, so even if the WARN_ON triggers the machine remains completely
	stable.

Only in 2.6.5-rc1-aa3: linus.patch.gz

	Updated to 2.6.5-rc2 so not needed anymore.
