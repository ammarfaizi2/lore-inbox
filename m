Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755322AbWKSD5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbWKSD5i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 22:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755943AbWKSD5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 22:57:38 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43917 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1755322AbWKSD5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 22:57:37 -0500
Date: Sat, 18 Nov 2006 20:00:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.18.3
Message-ID: <20061119040000.GS1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.18.3 kernel.

The diffstat and short summary of the fixes are below.

I'll also be replying to this message with a copy of the patch between
2.6.18.2 and 2.6.18.3, as it is small enough to do so.
                                                                                
The updated 2.6.18.y git tree can be found at:                                  
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git 
and can be browsed at the normal kernel.org git web browser:                    
        www.kernel.org/git/                                                     

thanks,
-chris

--------

 Makefile                                    |    2 +-
 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c |    3 +--
 arch/i386/pci/irq.c                         |    4 ++--
 arch/powerpc/kernel/traps.c                 |   18 ++++++++++--------
 arch/ppc/kernel/traps.c                     |   18 ++++++++++--------
 arch/s390/lib/uaccess.S                     |   10 +++++-----
 arch/s390/lib/uaccess64.S                   |    2 +-
 arch/sparc/kernel/entry.S                   |    3 +--
 arch/sparc64/kernel/entry.S                 |    3 +--
 arch/x86_64/kernel/process.c                |    7 +++----
 block/scsi_ioctl.c                          |    2 +-
 drivers/block/cciss.c                       |    6 ++++++
 drivers/block/cpqarray.c                    |   15 +++++++++++----
 drivers/char/ipmi/ipmi_si_intf.c            |    2 +-
 drivers/char/isicom.c                       |    3 ++-
 drivers/input/mouse/psmouse-base.c          |    8 +++++---
 drivers/net/e1000/e1000_main.c              |    7 +++++++
 drivers/pci/pci-sysfs.c                     |    3 +++
 drivers/usb/class/usblp.c                   |    1 +
 drivers/usb/input/hid-core.c                |    4 ++--
 drivers/usb/input/hid-input.c               |   17 +++++++++++++++++
 drivers/usb/input/hid.h                     |    1 +
 drivers/usb/input/usbtouchscreen.c          |    2 +-
 drivers/video/nvidia/nv_hw.c                |   12 +++++++++---
 drivers/video/nvidia/nv_setup.c             |   18 +++++++++++++++++-
 drivers/video/nvidia/nv_type.h              |    1 +
 drivers/video/nvidia/nvidia.c               |   24 ++++++++++++------------
 fs/cifs/CHANGES                             |    6 +++++-
 fs/cifs/file.c                              |    3 ++-
 fs/cifs/inode.c                             |   14 +++++++++-----
 include/asm-sparc/unistd.h                  |    2 ++
 include/asm-sparc64/futex.h                 |   18 ++++++++----------
 include/asm-sparc64/unistd.h                |    2 ++
 include/linux/ufs_fs.h                      |    2 +-
 mm/migrate.c                                |    3 ++-
 mm/slab.c                                   |    2 +-
 net/core/skbuff.c                           |    1 +
 net/core/sock.c                             |    2 +-
 net/ipv4/tcp.c                              |    4 ++--
 security/seclvl.c                           |    2 ++
 40 files changed, 170 insertions(+), 87 deletions(-)

Summary of changes from v2.6.18.2 to v2.6.18.3
============================================

Adrian Bunk:
      security/seclvl.c: fix time wrap (CVE-2005-4352)

Andi Kleen:
      x86_64: Fix FPU corruption

Auke Kok:
      e1000: Fix regression: garbled stats and irq allocation during swsusp

Benjamin Herrenschmidt:
      POWERPC: Make alignment exception always check exception table

Chris Wright:
      Linux 2.6.18.3

Daniel Ritz:
      usbtouchscreen: use endpoint address from endpoint descriptor
      fix via586 irq routing for pirq 5

Daniel Yeisley:
      init_reap_node() initialization fix

Dave Jones:
      CPUFREQ: Make acpi-cpufreq unsticky again.

David Miller:
      SPARC64: Fix futex_atomic_cmpxchg_inatomic implementation.
      SPARC: Fix missed bump of NR_SYSCALLS.
      NET: __alloc_pages() failures reported due to fragmentation
      pci: don't try to remove sysfs files before they are setup.

Eric Sandeen:
      fix UFS superblock alignment issues

Herbert Xu:
      NET: Set truesize in pskb_copy

Jens Axboe:
      block: Fix bad data direction in SG_IO
      cpqarray: fix iostat
      cciss: fix iostat

Jiri Slaby:
      Char: isicom, fix close bug

John Heffner:
      TCP: Don't use highmem in tcp hash size calculation.

Martin Schwidefsky:
      S390: user readable uninitialised kernel memory, take 2.

Olaf Hering:
      correct keymapping on Powerbook built-in USB ISO keyboards

Oliver Neukum:
      USB: failure in usblp's error path

Sergey Vlasov:
      Input: psmouse - fix attribute access on 64-bit systems

Stephen Rothwell:
      Fix sys_move_pages when a NULL node list is passed.

Steve French:
      CIFS: report rename failure when target file is locked by Windows
      CIFS: New POSIX locking code not setting rc properly to zero on successful

Wink Saville:
      Patch for nvidia divide by zero error for 7600 pci-express card

Yvan Seth:
      ipmi_si_intf.c sets bad class_mask with PCI_DEVICE_CLASS

