Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbUCTVCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbUCTVCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:02:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11738
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263542AbUCTVCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:02:17 -0500
Date: Sat, 20 Mar 2004 22:03:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-aa3
Message-ID: <20040320210306.GA11680@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the sigbus in nopage and improved the page_t layout per Hugh's
suggestion. BUG() with discontigmem disabled if somebody returns non-ram
via do_no_page, that cannot work right on numa anyways.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa3/

Diff between 2.6.5-rc1-aa2 and 2.6.5-rc1-aa3.

Only in 2.6.5-rc1-aa2: 00000_extraversion-2
Only in 2.6.5-rc1-aa3: extraversion
Only in 2.6.5-rc1-aa2: 00100_objrmap-core-1.gz
Only in 2.6.5-rc1-aa3: objrmap-core.gz

	Rediffed.

Only in 2.6.5-rc1-aa2: 00000_twofish-2.6.gz
Only in 2.6.5-rc1-aa3: twofish-2.6.gz
Only in 2.6.5-rc1-aa2: 00200_kgdb-ga-1.gz
Only in 2.6.5-rc1-aa2: 00201_kgdb-ga-recent-gcc-fix-1.gz
Only in 2.6.5-rc1-aa2: 00201_kgdb-THREAD_SIZE-fixes-1.gz
Only in 2.6.5-rc1-aa2: 00201_kgdb-x86_64-support-1.gz
Only in 2.6.5-rc1-aa3: kgdb-ga.gz
Only in 2.6.5-rc1-aa3: kgdb-ga-recent-gcc-fix.gz
Only in 2.6.5-rc1-aa3: kgdb-THREAD_SIZE-fixes.gz
Only in 2.6.5-rc1-aa3: kgdb-x86_64-support.gz

	Renamed.

Only in 2.6.5-rc1-aa2: 00101_anon_vma-2.gz
Only in 2.6.5-rc1-aa3: anon_vma.gz

	Change mapcount to an unsigned int, and move it near
	the atomic_t to save 8 bytes per page on 64bit archs,
	from Hugh Dickins.

	Fixed a bug in do_no_page that was crashing if
	->nopage returned a sigbus or oom error.

Only in 2.6.5-rc1-aa3: linus.patch.gz

	Linus's patch from 2.6.5-rc1-mm2.

Only in 2.6.5-rc1-aa3: laptop-mode-2.patch.gz

	laptop mode from 2.6.5-rc1-mm2.

Only in 2.6.5-rc1-aa3: clear_page_dirty_for_io.patch.gz
Only in 2.6.5-rc1-aa3: compound-pages-stop-using-lru.patch.gz
Only in 2.6.5-rc1-aa3: hugetlb-stop-using-page-list.patch.gz
Only in 2.6.5-rc1-aa3: irq-safe-pagecache-lock.patch.gz
Only in 2.6.5-rc1-aa3: page_alloc-stop-using-page-list.patch.gz
Only in 2.6.5-rc1-aa3: pageattr-stop-using-page-list.patch.gz
Only in 2.6.5-rc1-aa3: radix-tree-tagging.patch.gz
Only in 2.6.5-rc1-aa3: readahead-stop-using-page-list.patch.gz
Only in 2.6.5-rc1-aa3: remove-page-list.patch.gz
Only in 2.6.5-rc1-aa3: slab-stop-using-page-list.patch.gz
Only in 2.6.5-rc1-aa3: stop-using-clean-pages.patch.gz
Only in 2.6.5-rc1-aa3: stop-using-dirty-pages.patch.gz
Only in 2.6.5-rc1-aa3: stop-using-io-pages.patch.gz
Only in 2.6.5-rc1-aa3: stop-using-locked-pages-fix-2.patch.gz
Only in 2.6.5-rc1-aa3: stop-using-locked-pages-fix.patch.gz
Only in 2.6.5-rc1-aa3: stop-using-locked-pages.patch.gz
Only in 2.6.5-rc1-aa3: tag-dirty-pages.patch.gz
Only in 2.6.5-rc1-aa3: tag-writeback-pages-fix.patch.gz
Only in 2.6.5-rc1-aa3: tag-writeback-pages-missing-filesystems.patch.gz
Only in 2.6.5-rc1-aa3: tag-writeback-pages.patch.gz
Only in 2.6.5-rc1-aa3: unslabify-pgds-and-pmds.patch.gz

	Writeback changes from 2.6.5-rc1-mm2 to reduce the difference
	with other trees, and to avoid having to maintain significantly
	different versions of anon_vma.
