Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311480AbSCNC0x>; Wed, 13 Mar 2002 21:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311479AbSCNC0n>; Wed, 13 Mar 2002 21:26:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24949 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311469AbSCNC01>; Wed, 13 Mar 2002 21:26:27 -0500
Date: Thu, 14 Mar 2002 03:28:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre3aa2
Message-ID: <20020314032801.C1273@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre3aa2/

VM alone:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre3/vm-32

Changelog:

Only in 2.4.19pre3aa1: 00_lcall_trace-1

	Obsoleted by mainline (thanks to Christoph Hellwig for
	the reminder).

Only in 2.4.19pre3aa2: 00_loop-IV-API-hvr-1

	Make the IV API not to be in function of the blkdev
	of the underlying fs, so you can copy your cryptoloop
	around without risking to lose data. This breaks the
	on-disk format of some encrypted transfer module though,
	if you don't like it please discuss it here in CC with
	Herbert Valerio Riedel <hvr@hvrlab.org>, the patch
	is from him. I think writing a converter in place of
	the loop data would be the preferred solution if needed. It could
	be done in a way to link transparently with the source of
	the kernel modules.

Only in 2.4.19pre3aa2: 00_multipath-routing-smp-1

	SMP race fix.

Only in 2.4.19pre3aa2: 00_zlib-1

	the zlib fix.

Only in 2.4.19pre3aa1: 10_nfs-o_direct-4
Only in 2.4.19pre3aa2: 10_nfs-o_direct-5
Only in 2.4.19pre3aa1: 10_reiserfs-o_direct-1

	Merged together for consistency, suggested by
	Christoph Hellwig.

Only in 2.4.19pre3aa1: 10_vm-31
Only in 2.4.19pre3aa2: 10_vm-32

	Fixed ext3 deadlock and "theorical" mainline SMP race for
	some arch.

Only in 2.4.19pre3aa2: 21_pte-highmem-f00f-1

	vmalloc called before smp_init was an hack, right way
	is to use fixmap. CONFIG_M686 doesn't mean much these
	days, but it's ok and probably most vendors will use it
	for the smp kernels, so it will save 4096 of the vmalloc space.
	I just didn't wanted to clobber the code with || CONFIG_K7 ||
	CONFIG_... | ... given all the other f00f stuff is also
	conditional only to M686 and probably nobody bothered to compile
	it out for my same reason (if somebody worries about the few
	kbytes of bytecode and the 4096 bytes of vmalloc virtual address
	space feel free to send me a patch :).

	This allows booting P5 SMP with pte-highmem.

Only in 2.4.19pre3aa1: 70_xfs-6.gz
Only in 2.4.19pre3aa2: 70_xfs-7.gz

	Rediffed for the vm deadlock fix, also clear PG_Launder _before_
	unlocking the buffer in write_buffer_locked().

Andrea
