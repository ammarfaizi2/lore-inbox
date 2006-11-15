Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030636AbWKOQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbWKOQJj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbWKOQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:09:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030636AbWKOQJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:09:37 -0500
Date: Wed, 15 Nov 2006 17:09:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.32
Message-ID: <20061115160936.GF5824@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.31:
- CVE-2006-4538: ia64/sparc: fix local DoS with corrupted ELFs


Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.31:

Adrian Bunk (6):
      remove Documentation/feature-removal-schedule.txt
      drivers/md/md.c: update START_ARRAY printk
      drivers/telephony/ixj: fix an array overrun
      [AGPGART] remove unused variable
      Linux 2.6.16.32-rc1
      Linux 2.6.16.32

Antonino Daplas (1):
      nvidiafb: Add support for Geforce 6100 and related chipsets

Christoph Lameter (1):
      Fix longstanding load balancing bug in the scheduler

Dave Jones (2):
      [CPUFREQ] Make powernow-k7 work on SMP kernels.
      [AGPGART] Suspend/Resume support for nVidia nForce AGP.

Dmitriy Monakhov (1):
       fix D-cache aliasing issue in cow_user_page

Geert Uytterhoeven (1):
      fbdev: correct buffer size limit in fbmem_read_proc()

Herbert Xu (3):
      [NET]: Add missing UFO initialisations
      [NET]: Set truesize in pskb_copy
      [NET]: Update frag_list in pskb_trim

Jean Delvare (1):
      scx200_acb: Fix the block transactions

Jeff Mahoney (1):
      [DISKLABEL] SUN: Fix signed int usage for sector count

John Heffner (1):
      [TCP]: Don't use highmem in tcp hash size calculation.

Kirill Korotaev (2):
      [IPV4]: Limit rt cache size properly.
      ia64/sparc: fix local DoS with corrupted ELFs (CVE-2006-4538)

Larry Woodman (1):
      [NET]: __alloc_pages() failures reported due to fragmentation

Marcel Holtmann (1):
      Don't allow chmod() on the /proc/<pid>/ files

Neil Brown (1):
      md: Make sure bi_max_vecs is set properly in bio_split

Paul Mackerras (2):
      [POWERPC] Fix return value from memcpy
      nvidia fbdev: fix powerpc xmon scribbles

Pavel Roskin (1):
      drivers/video/nvidia/nvidia.c: Add ID for Quadro NVS280

Randy Dunlap (1):
      [CPUFREQ] Fix powernow-k8 SMP kernel on UP hardware bug.

Stephen Hemminger (1):
      [MAINTAINERS]: Add proper entry for TC classifier

Tejun Heo (1):
      sata_sil24: add a new PCI ID for SiI 3124

Thomas Andrews (1):
      Fix the scx200_acb state machine:

Thomas Graf (4):
      PKT_SCHED: Fix error handling while dumping actions
      PKT_SCHED: Fix illegal memory dereferences when dumping actions
      PKT_SCHED: Return ENOENT if action module is unavailable
      [PKT_SCHED]: act_api: Fix module leak while flushing actions


 Documentation/feature-removal-schedule.txt |  191 ---------------------
 MAINTAINERS                                |    6 
 Makefile                                   |    2 
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |    5 
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    2 
 arch/ia64/kernel/sys_ia64.c                |   28 +--
 arch/powerpc/lib/memcpy_64.S               |   11 -
 arch/sparc/kernel/sys_sparc.c              |   27 +-
 arch/sparc64/kernel/sys_sparc.c            |   30 +--
 drivers/char/agp/nvidia-agp.c              |   27 ++
 drivers/i2c/busses/scx200_acb.c            |   20 +-
 drivers/md/md.c                            |    2 
 drivers/scsi/sata_sil24.c                  |    1 
 drivers/telephony/ixj.h                    |    2 
 drivers/video/fbmem.c                      |    3 
 drivers/video/nvidia/nv_hw.c               |   10 -
 drivers/video/nvidia/nvidia.c              |   13 +
 fs/bio.c                                   |    3 
 fs/partitions/sun.c                        |    2 
 fs/proc/base.c                             |   33 +++
 include/asm-ia64/mman.h                    |    8 
 include/asm-sparc/mman.h                   |    8 
 include/asm-sparc64/mman.h                 |    8 
 include/linux/pci_ids.h                    |    1 
 include/linux/skbuff.h                     |   24 +-
 kernel/sched.c                             |   38 +++-
 mm/memory.c                                |    1 
 mm/mmap.c                                  |   17 +
 net/core/dev.c                             |    1 
 net/core/skbuff.c                          |  109 ++++++++---
 net/core/sock.c                            |    2 
 net/ipv4/route.c                           |    2 
 net/ipv4/tcp.c                             |    4 
 net/sched/act_api.c                        |   22 +-
 34 files changed, 342 insertions(+), 321 deletions(-)

