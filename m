Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270642AbRHJUtu>; Fri, 10 Aug 2001 16:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270658AbRHJUtm>; Fri, 10 Aug 2001 16:49:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16144 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270642AbRHJUtd>; Fri, 10 Aug 2001 16:49:33 -0400
Date: Fri, 10 Aug 2001 22:49:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8pre8aa1
Message-ID: <20010810224931.C832@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.8pre8aa1: 00_alpha-iommu_fixup-1

	Really reserve the last mbytes of 32bit pci space for cypress magics.

Only in 2.4.8pre8aa1: 00_alpha-sg_fill-1

	When splitting one virtual consecutive sg slot into many physically
	consecutive slots update the dma_length of ex-leader and ex-mergers
	correctly.

Only in 2.4.8pre8aa1: 00_debug-vm-lru-mm-corruption-1

	Add debugging code, during heavy load a BUG() triggered in DEBUG_ADD_PAGE
	in page_launder while removing a buffer from the inactive_dirty,
	despite we cleared the inactive_dirty bitflag from the page->flags
	some other bitflag was still set, this could be random memory corruption
	but it could also be a race condition in the vm. Unfortunately the
	printk in BUG() clobbered %eax so I couldn't see the contents of page->flags
	from the bugreport so now I'm printing page->flags explicitly before
	BUG() so next time we'll see if page->flags was just random or in which
	other list the page was supposed to be too.

Only in 2.4.8pre8aa1: 00_drm_vm-1

	Never use page->virtual directly, always use page_address(page)
	to get that information, so we keep saving ram when highmem is
	not selected and on 64bit archs in general.

Only in 2.4.8pre8aa1: 00_module-oops-1

	Andi extracted the module_oops code from -ac, ready to be applied
	to mainline.

Only in 2.4.8pre6aa1: 40_blkdev-pagecache-10
Only in 2.4.8pre8aa1: 40_blkdev-pagecache-11

	Fixed trivial rejects, fsync_no_super lines.

Only in 2.4.8pre6aa1: 50_uml-2.4.7-3.bz2
Only in 2.4.8pre8aa1: 50_uml-2.4.7-5.bz2

	Picked new -5 revision from sourceforge.

Andrea
