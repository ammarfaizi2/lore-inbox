Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRIATSO>; Sat, 1 Sep 2001 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRIATSF>; Sat, 1 Sep 2001 15:18:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271278AbRIATRs>; Sat, 1 Sep 2001 15:17:48 -0400
Date: Sat, 1 Sep 2001 12:14:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.10-pre3
Message-ID: <Pine.LNX.4.33.0109011212380.922-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there's been a number of small merges, and VM cleanups etc. This
should avoid kswapd spending any more CPU time than before, and fixes a
number of annoying bugs. ChangeLog appended,

		Linus

----

pre3:
 - Johannes Erdfelt, Oliver Neukum: USB printer driver race fix
 - John Byrne: fix stupid i386-SMP irq stack layout bug
 - Andreas Bombe, me: yenta IO window fix
 - Neil Brown: raid1 buffer state fix
 - David Miller, Paul Mackerras: fix up sparc and ppc respectively for kmap/kbd_rate
 - Matija Nalis: umsdos fixes, and make it possible to boot up with umsdos
 - Francois Romieu: fix bugs in dscc4 driver
 - Andy Grover: new PCI config space access functions (eventually for ACPI)
 - Albert Cranford: fix incorrect e2fsprog data from ver_linux script
 - Dave Jones: re-sync x86 setup code, fix macsonic kmalloc use
 - Johannes Erdfelt: remove obsolete plusb USB driver
 - Andries Brouwer: fix USB compact flash version info, add blksize ioctls

pre2:
 - Al Viro: block device cleanups
 - Marcelo Tosatti: make bounce buffer allocations more robust (it's ok
   for them to do IO, just not cause recursive bounce IO. So allow them)
 - Anton Altaparmakov: NTFS update (1.1.17)
 - Paul Mackerras: PPC update (big re-org)
 - Petko Manolov: USB pegasus driver fixes
 - David Miller: networking and sparc updates
 - Trond Myklebust: Export atomic_dec_and_lock
 - OGAWA Hirofumi: find and fix umsdos "filldir" users that were broken
   by the 64-bit-cleanups. Fix msdos warnings.
 - Al Viro: superblock handling cleanups and race fixes
 - Johannes Erdfelt++: USB updates

pre1:
 - Jeff Hartmann: DRM AGP/alpha cleanups
 - Ben LaHaise: highmem user pagecopy/clear optimization
 - Vojtech Pavlik: VIA IDE driver update
 - Herbert Xu: make cramfs work with HIGHMEM pages
 - David Fennell: awe32 ram size detection improvement
 - Istvan Varadi: umsdos EMD filename bug fix
 - Keith Owens: make min/max work for pointers too
 - Jan Kara: quota initialization fix
 - Brad Hards: Kaweth USB driver update (enable, and fix endianness)
 - Ralf Baechle: MIPS updates
 - David Gibson: airport driver update
 - Rogier Wolff: firestream ATM driver multi-phy support
 - Daniel Phillips: swap read page referenced set - avoid swap thrashing

