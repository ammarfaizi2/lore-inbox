Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSEaFSd>; Fri, 31 May 2002 01:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSEaFSd>; Fri, 31 May 2002 01:18:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24660 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314938AbSEaFSc>; Fri, 31 May 2002 01:18:32 -0400
Date: Fri, 31 May 2002 07:18:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre9aa2
Message-ID: <20020531051841.GA1172@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This in particular includes a fix from Denis Lunev to cure the
instability in 2.4.19pre9aa1 introduced by the first revision of the
inode-highmem fix (I also changed invalidate_inode_pages so that it runs
try_to_release_page for ext3 as suggested by Andrew a few days ago).  So
everybody running 2.4.19pre9aa1 is recommended to upgrade to
2.4.19pre9aa2 ASAP.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9aa2/

Full changlog follows:

Only in 2.4.19pre9aa2: 00_fix-stat-irq-1

	avoid showing those 10000... numbers in /proc/stat. From -ac.

Only in 2.4.19pre9aa2: 00_flock-posix-2001-1

	Update to posix 2001 semantics for negative length. From -ac.

Only in 2.4.19pre9aa2: 00_ipc-sem-set-pid-during-setval-1

	Set the sempid during serval operation, so getpid
	operation will see it. From -ac.

Only in 2.4.19pre9aa2: 00_loop-handling-pages-in-cache-1

	If the pagecache was preallocated it could be in highmem.
	From -ac.

Only in 2.4.19pre9aa2: 00_mmap-TASK_SIZE-len-1

	Avoid returning -EINVAL for length <= TASK_SIZE. From -ac,
	Spotted by DervishD.

Only in 2.4.19pre9aa2: 00_scsi-error-thread-reparent-1

	Reparent to init scsi-error kernel thread so it's not left
	zombie floating around when it exists. From -ac.

Only in 2.4.19pre9aa2: 00_sig_ign-discard-sigurg-1

	Update semantics while setting sigurg as sig_ign, the
	pending sigurg will be flushed. From -ac.

Only in 2.4.19pre9aa2: 00_vm86-drop-v86mode-dead-thread-var-1

	Drop dead variable in vm86 part of the thread struct. From -ac.

Only in 2.4.19pre9aa2: 00_wmem-default-lowmem-machines-1

	Typo fix from -ac.

Only in 2.4.19pre9aa2: 00_x86-optimize-apic-irq-and-cacheline-1

	cachelin-optimize the apic irq stats and cacheline align
	the irq_stat array. From -ac.

Only in 2.4.19pre9aa2: 03_sched-pipe-bandwidth-1

	If the pipe-writer fills the pipe reschedule the reader
	in the same cpu of the writer to maximaze memory copy
	bandwith in the local cpu over the pipe page. From Mike Kravetz.

Only in 2.4.19pre9aa1: 05_vm_10_read_write_tweaks-2
Only in 2.4.19pre9aa2: 05_vm_10_read_write_tweaks-3

	Updated comments per Christoph's suggestion.

Only in 2.4.19pre9aa1: 10_inode-highmem-1
Only in 2.4.19pre9aa2: 10_inode-highmem-2

	Fix showstopper bug that was corrupting the inode unused_list
	if the number of unused inodes was < vm_vfs_scan_ratio.
	Spotted and fixed by Denis Lunev.

Only in 2.4.19pre9aa1: 00_gcc-3_1-compile-2
Only in 2.4.19pre9aa2: 61_tux-exports-gcc-3_1-compile-1

	Moved later in the patch stage for clarity (suggested by
	Christoph Hellwig).

Andrea
