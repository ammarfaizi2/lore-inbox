Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUDBEbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 23:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUDBEbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 23:31:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51846
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263142AbUDBEbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 23:31:33 -0500
Date: Fri, 2 Apr 2004 06:31:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3-aa2
Message-ID: <20040402043132.GB2251@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc3-aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc3-aa2/

Changelog diff between 2.6.5-rc3-aa1 and 2.6.5-rc3-aa2:

Only in 2.6.5-rc3-aa2: aic7xxx-suspend

	Fix aic7xxx swap suspend (from Pavel).

Files 2.6.5-rc3-aa1/anon-vma.gz and 2.6.5-rc3-aa2/anon-vma.gz differ

	Added hardness check for PageCompound in rw_swap_page_sync
	(it's a slow path and decoding the asm once is more than enough ;).

Only in 2.6.5-rc3-aa2: disable-cap-mlock

	Andrew's version of the original disable-cap-mlock implemented
	by Ken Chen. Long term userspace should learn to drop all
	capabilities but CAP_IPC_LOCK as Andrew suggested.

Files 2.6.5-rc3-aa1/extraversion and 2.6.5-rc3-aa2/extraversion differ

	Rediffed.

Only in 2.6.5-rc3-aa2: gfp-no-compound

	By default always generate compound pages for order > 0, and give the
	ability to drivers to allocate non-compound-multipages with
	__GFP_NO_COMP, and last but not the least always initialize
	all the page->counts if compound isn't selected. This also
	fixes the collision on page->private of swap-suspend and anon-vma.
	Swapsuspend now works.

Files 2.6.5-rc3-aa1/prio-tree.gz and 2.6.5-rc3-aa2/prio-tree.gz differ

	Added EXPORT_SYMBOL for prev/next prio-tree operations needed
	by xfs dmapi (not in this tree though).

Files 2.6.5-rc3-aa1/tag-writeback-pages-fix.patch.gz and 2.6.5-rc3-aa2/tag-writeback-pages-fix.patch.gz differ

	Fix -mm writeback crashes on rw_swap_page_sync.
