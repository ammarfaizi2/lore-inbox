Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWI1Pzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWI1Pzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWI1Pzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:55:31 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12655 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751328AbWI1Pzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:55:31 -0400
Date: Thu, 28 Sep 2006 17:55:29 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060928155529.GA21310@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/Kconfig                    |   12 +
 arch/s390/Makefile                   |    1 
 arch/s390/appldata/appldata_base.c   |    4 
 arch/s390/crypto/crypt_s390.h        |  204 ++++-------
 arch/s390/hypfs/hypfs_diag.c         |   26 -
 arch/s390/kernel/compat_linux.c      |    5 
 arch/s390/kernel/compat_wrapper.S    |  442 ++++++++++++------------
 arch/s390/kernel/cpcmd.c             |   83 ++---
 arch/s390/kernel/entry.S             |  469 +++++++++++++------------
 arch/s390/kernel/entry64.S           |  443 ++++++++++++------------
 arch/s390/kernel/head.S              |  624 +++++++++++++++++-----------------
 arch/s390/kernel/head64.S            |  432 ++++++++++++-----------
 arch/s390/kernel/ipl.c               |   21 -
 arch/s390/kernel/process.c           |    5 
 arch/s390/kernel/reipl.S             |   75 ++--
 arch/s390/kernel/reipl64.S           |   93 ++---
 arch/s390/kernel/relocate_kernel.S   |   74 ++--
 arch/s390/kernel/relocate_kernel64.S |   82 ++--
 arch/s390/kernel/semaphore.c         |   22 +
 arch/s390/kernel/setup.c             |    2 
 arch/s390/kernel/smp.c               |   73 +---
 arch/s390/kernel/time.c              |   10 -
 arch/s390/kernel/traps.c             |    3 
 arch/s390/lib/Makefile               |    1 
 arch/s390/lib/delay.c                |   11 -
 arch/s390/lib/div64.c                |  151 ++++++++
 arch/s390/lib/uaccess_mvcos.c        |   22 +
 arch/s390/lib/uaccess_std.c          |   36 +-
 arch/s390/math-emu/math.c            |  126 +++----
 arch/s390/math-emu/sfp-util.h        |   73 ++--
 arch/s390/mm/extmem.c                |   16 -
 arch/s390/mm/fault.c                 |   35 +-
 arch/s390/mm/init.c                  |   41 +-
 drivers/s390/block/dasd_diag.c       |   34 --
 drivers/s390/block/xpram.c           |   54 +--
 drivers/s390/char/fs3270.c           |    1 
 drivers/s390/char/sclp.c             |   31 --
 drivers/s390/char/tty3270.c          |    1 
 drivers/s390/char/vmwatchdog.c       |   52 +--
 drivers/s390/cio/device_id.c         |   38 +-
 drivers/s390/cio/ioasm.h             |  220 ++++--------
 drivers/s390/cio/qdio.h              |  192 +++-------
 drivers/s390/net/iucv.c              |   39 +-
 drivers/s390/s390mach.c              |   93 +++--
 include/asm-s390/appldata.h          |    2 
 include/asm-s390/atomic.h            |  120 +++++--
 include/asm-s390/bitops.h            |  626 ++++++++++++++++------------------
 include/asm-s390/byteorder.h         |   50 +--
 include/asm-s390/checksum.h          |  176 +++-------
 include/asm-s390/div64.h             |   48 ---
 include/asm-s390/ebcdic.h            |   20 +
 include/asm-s390/io.h                |   14 -
 include/asm-s390/irqflags.h          |  110 ++++--
 include/asm-s390/lowcore.h           |    2 
 include/asm-s390/page.h              |  111 ++----
 include/asm-s390/pgtable.h           |   28 +-
 include/asm-s390/processor.h         |  130 ++++---
 include/asm-s390/ptrace.h            |    2 
 include/asm-s390/rwsem.h             |  238 ++++++-------
 include/asm-s390/semaphore.h         |   16 -
 include/asm-s390/sfp-machine.h       |   64 ++-
 include/asm-s390/sigp.h              |   65 ++--
 include/asm-s390/smp.h               |    2 
 include/asm-s390/spinlock.h          |   27 +
 include/asm-s390/string.h            |   56 ++-
 include/asm-s390/system.h            |  342 +++++++------------
 include/asm-s390/timex.h             |   19 +
 include/asm-s390/tlbflush.h          |   32 +-
 include/asm-s390/uaccess.h           |   13 -
 include/asm-s390/unistd.h            |  258 +++++++-------
 70 files changed, 3335 insertions(+), 3708 deletions(-)
 create mode 100644 arch/s390/lib/div64.c

Akinobu Mita:
      [S390] init task memory faults.

Christian Borntraeger:
      [S390] remove unnecessary includes.
      [S390] config option for z9-109 code generation.

Gerald Schaefer:
      [S390] Avoid static struct initializations in appldata.

Heiko Carstens:
      [S390] Whitespace cleanup.

Jan Glauber:
      [S390] init_timer in tty3270.

Martin Schwidefsky:
      [S390] __div64_32 for 31 bit.
      [S390] user readable uninitialised kernel memory.
      [S390] Inline assembly cleanup.

Michael Holzheu:
      [S390] hypfs sparse warnings.

Again no diff, this time it has 11000 lines ..
