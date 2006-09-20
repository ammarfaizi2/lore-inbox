Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751537AbWITOLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbWITOLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 10:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWITOLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 10:11:38 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:46363 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751537AbWITOLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 10:11:37 -0400
Date: Wed, 20 Sep 2006 16:11:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060920141136.GA31900@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 MAINTAINERS                          |    2 
 arch/s390/Kconfig                    |   17 
 arch/s390/appldata/appldata.h        |   16 
 arch/s390/appldata/appldata_base.c   |   81 
 arch/s390/appldata/appldata_os.c     |    1 
 arch/s390/defconfig                  |    1 
 arch/s390/hypfs/hypfs.h              |    2 
 arch/s390/hypfs/hypfs_diag.c         |   16 
 arch/s390/hypfs/hypfs_diag.h         |    2 
 arch/s390/hypfs/inode.c              |   12 
 arch/s390/kernel/Makefile            |    3 
 arch/s390/kernel/entry.S             |   12 
 arch/s390/kernel/entry64.S           |   16 
 arch/s390/kernel/head.S              |   69 
 arch/s390/kernel/head31.S            |   48 
 arch/s390/kernel/head64.S            |   59 
 arch/s390/kernel/ipl.c               |  942 +++++++++
 arch/s390/kernel/kprobes.c           |  657 ++++++
 arch/s390/kernel/reipl.S             |   33 
 arch/s390/kernel/reipl64.S           |   34 
 arch/s390/kernel/reipl_diag.c        |   39 
 arch/s390/kernel/s390_ksyms.c        |    6 
 arch/s390/kernel/setup.c             |  272 --
 arch/s390/kernel/signal.c            |   40 
 arch/s390/kernel/smp.c               |   10 
 arch/s390/kernel/traps.c             |   31 
 arch/s390/kernel/vmlinux.lds.S       |    3 
 arch/s390/lib/Makefile               |    4 
 arch/s390/lib/uaccess.S              |  211 --
 arch/s390/lib/uaccess64.S            |  207 --
 arch/s390/lib/uaccess_mvcos.c        |  156 +
 arch/s390/lib/uaccess_std.c          |  340 +++
 arch/s390/mm/cmm.c                   |   30 
 arch/s390/mm/fault.c                 |   40 
 arch/s390/mm/init.c                  |   36 
 drivers/base/hypervisor.c            |    3 
 drivers/s390/Kconfig                 |   30 
 drivers/s390/block/dasd.c            |    8 
 drivers/s390/block/dasd_devmap.c     |   82 
 drivers/s390/block/dasd_eer.c        |    2 
 drivers/s390/block/dasd_int.h        |    1 
 drivers/s390/block/xpram.c           |    2 
 drivers/s390/char/Makefile           |    1 
 drivers/s390/char/monwriter.c        |  292 +++
 drivers/s390/char/vmcp.c             |    2 
 drivers/s390/char/vmcp.h             |    2 
 drivers/s390/cio/chsc.c              |    5 
 drivers/s390/cio/cio.c               |   95 
 drivers/s390/cio/css.c               |  203 +-
 drivers/s390/cio/device.c            |  109 -
 drivers/s390/cio/device_fsm.c        |   40 
 drivers/s390/cio/device_ops.c        |   17 
 drivers/s390/cio/device_pgid.c       |   81 
 drivers/s390/cio/qdio.c              |    4 
 drivers/s390/cio/qdio.h              |   16 
 drivers/s390/crypto/Makefile         |   15 
 drivers/s390/crypto/ap_bus.c         | 1221 ++++++++++++
 drivers/s390/crypto/ap_bus.h         |  158 +
 drivers/s390/crypto/z90common.h      |  166 -
 drivers/s390/crypto/z90crypt.h       |   71 
 drivers/s390/crypto/z90hardware.c    | 2531 --------------------------
 drivers/s390/crypto/z90main.c        | 3379 -----------------------------------
 drivers/s390/crypto/zcrypt_api.c     | 1091 +++++++++++
 drivers/s390/crypto/zcrypt_api.h     |  141 +
 drivers/s390/crypto/zcrypt_cca_key.h |  350 +++
 drivers/s390/crypto/zcrypt_cex2a.c   |  435 ++++
 drivers/s390/crypto/zcrypt_cex2a.h   |  126 +
 drivers/s390/crypto/zcrypt_error.h   |  133 +
 drivers/s390/crypto/zcrypt_mono.c    |  100 +
 drivers/s390/crypto/zcrypt_pcica.c   |  418 ++++
 drivers/s390/crypto/zcrypt_pcica.h   |  117 +
 drivers/s390/crypto/zcrypt_pcicc.c   |  630 ++++++
 drivers/s390/crypto/zcrypt_pcicc.h   |  176 +
 drivers/s390/crypto/zcrypt_pcixcc.c  |  951 +++++++++
 drivers/s390/crypto/zcrypt_pcixcc.h  |   79 
 drivers/s390/s390mach.c              |   17 
 drivers/s390/scsi/zfcp_def.h         |    8 
 drivers/s390/sysinfo.c               |  455 ++--
 include/asm-s390/Kbuild              |    2 
 include/asm-s390/appldata.h          |   90 
 include/asm-s390/cio.h               |    7 
 include/asm-s390/dma.h               |    2 
 include/asm-s390/futex.h             |   87 
 include/asm-s390/io.h                |    2 
 include/asm-s390/kdebug.h            |   59 
 include/asm-s390/kprobes.h           |  114 +
 include/asm-s390/lowcore.h           |   14 
 include/asm-s390/monwriter.h         |   33 
 include/asm-s390/pgalloc.h           |   67 
 include/asm-s390/pgtable.h           |  124 -
 include/asm-s390/processor.h         |   17 
 include/asm-s390/setup.h             |   66 
 include/asm-s390/smp.h               |    2 
 include/asm-s390/uaccess.h           |  172 -
 include/asm-s390/unistd.h            |  170 -
 include/asm-s390/z90crypt.h          |  212 --
 include/asm-s390/zcrypt.h            |  285 ++
 include/linux/mod_devicetable.h      |   11 
 scripts/mod/file2alias.c             |   12 
 99 files changed, 10478 insertions(+), 8281 deletions(-)

Christian Borntraeger:
      [S390] fix typo in vmcp.
      [S390] xpram off by one error.

Cornelia Huck:
      [S390] Get rid of DBG macro.

Frank Pavlic:
      [S390] qdio_get_micros return value.
      [S390] qdio slsb processing state.

Gerald Schaefer:
      [S390] cleanup appldata.
      [S390] Cleanup in page table related code.
      [S390] Cleanup in signal handling code.
      [S390] Make user-copy operations run-time configurable.
      [S390] Use alternative user-copy operations for new hardware.

Heiko Carstens:
      [S390] initrd vs. bootmem bitmap.
      [S390] empty function defines.
      [S390] fix syscall restart handling.
      [S390] Use simple_strtoul instead of own cmm_strtoul wrapper.
      [S390] __exit cleanup.
      [S390] convert some assembler to C.
      [S390] Missing initialization in common i/o layer.
      [S390] Kernel stack overflow handling.
      [S390] Remove kexec experimental flag.

Horst Hummel:
      [S390] dasd default debug level.

Martin Schwidefsky:
      [S390] EX_TABLE macro.
      [S390] remove old z90crypt driver.
      [S390] zcrypt adjunct processor bus.
      [S390] zcrypt user space interface.
      [S390] zcrypt CEX2A, CEX2C, PCICA accelerator card ap bus drivers.
      [S390] zcrypt PCICC, PCIXCC coprocessor card ap bus drivers.
      [S390] zcrypt driver Makefile, Kconfig and monolithic build.
      [S390] #undef in unistd.h
      [S390] architecture co-maintainer.
      [S390] dasd deadlock after state change pending interrupt.
      [S390] cleanup sysinfo and add system z9 specific extensions.

Melissa Howland:
      [S390] Linux API for writing z/VM APPLDATA Monitor records.

Michael Grundy:
      [S390] add kprobes support.

Michael Holzheu:
      [S390] hypfs comment cleanup.
      [S390] hypfs compiler warnings.
      [S390] ipl/dump on panic.
      [S390] hypfs crashes with invalid mount option.

Peter Oberparleiter:
      [S390] set modalias for ccw bus uevents.
      [S390] Replace nopav-message on VM.
      [S390] cio: subchannels in no-path state.
      [S390] cio: update path groups on logical CHPID changes.
      [S390] cio: always query all paths on path verification.
      [S390] cio: subchannel evaluation function operates without lock

Ralph Wuerthner:
      [S390] zcrypt secure key cryptography extension.

No diff this time since it has over 20000 lines/600 KB.

