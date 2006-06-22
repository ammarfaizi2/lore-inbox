Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWFVUS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWFVUS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbWFVUS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:18:27 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:18049 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030381AbWFVUS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:18:27 -0400
Date: Thu, 22 Jun 2006 13:17:57 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Linux 2.6.16.22
Message-ID: <20060622201757.GZ22737@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.16.22 kernel.
The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.16.21 and 2.6.16.22, as it is small enough to do so.

The updated 2.6.16.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,
-chris

--------

 Makefile                            |    2 
 arch/sparc64/kernel/pci_iommu.c     |    4 -
 arch/sparc64/kernel/sparc64_ksyms.c |    2 
 arch/sparc64/lib/checksum.S         |    5 -
 arch/sparc64/lib/csum_copy.S        |    5 -
 drivers/acpi/processor_perflib.c    |    5 +
 drivers/message/i2o/exec-osm.c      |   72 +++++++++---------
 drivers/message/i2o/iop.c           |    4 -
 drivers/parport/Kconfig             |    2 
 drivers/scsi/scsi_lib.c             |    2 
 drivers/usb/serial/whiteheat.c      |    4 -
 fs/jfs/jfs_metapage.c               |   20 +----
 fs/namei.c                          |   25 ++++--
 fs/ntfs/file.c                      |   13 +--
 include/asm-generic/pgtable.h       |   11 --
 include/asm-mips/pgtable.h          |   10 ++
 include/asm-sparc64/dma-mapping.h   |  141 +++++++++++++++++++++++++++++++++++-
 include/asm-sparc64/pci.h           |    4 -
 include/asm-sparc64/pgtable.h       |   17 ++++
 include/linux/i2o.h                 |    5 +
 mm/shmem.c                          |    1 
 21 files changed, 259 insertions(+), 95 deletions(-)

Summary of changes from v2.6.16.21 to v2.6.16.22
================================================

Andrew Morton:
      powernow-k8 crash workaround

Anton Altaparmakov:
      NTFS: Critical bug fix (affects MIPS and possibly others)

Chris Wright:
      Linux 2.6.16.22

Dave Kleikamp:
      JFS: Fix multiple errors in metapage_releasepage

David Miller:
      SPARC64: Fix D-cache corruption in mremap
      SPARC64: Respect gfp_t argument to dma_alloc_coherent().
      SPARC64: Fix missing fold at end of checksums.

James Bottomley:
      scsi_lib.c: properly count the number of pages in scsi_req_map_sg()

Markus Lidel:
      I2O: Bugfixes to get I2O working again

Oleg Drokin:
      Missed error checking for intent's filp in open_namei().

Robin H. Johnson:
      tmpfs: time granularity fix for [acm]time going backwards

Stuart MacDonald:
      USB: Whiteheat: fix firmware spurious errors

Trond Myklebust:
      fs/namei.c: Call to file_permission() under a spinlock in do_lookup_path()

