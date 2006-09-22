Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbWIVWh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbWIVWh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWIVWh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:37:29 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:60454 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965240AbWIVWh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:37:27 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [GIT PULL] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 22 Sep 2006 15:37:22 -0700
Message-ID: <adapsdnfrz1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Sep 2006 22:37:26.0490 (UTC) FILETIME=[ADDB5BA0:01C6DE97]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree has:
 - Add support for iWARP (RDMA over IP)
 - Add amso1100 driver for Ammasso 1100 iWARP adapters
 - Add ehca driver for IBM GX InfiniBand adapters
 - ipath fixes
 - lots of other smaller stuff

Bryan O'Sullivan:
      IB/ipath: More changes to support InfiniPath on PowerPC 970 systems
      IB/ipath: lock resource limit counters correctly
      IB/ipath: fix for crash on module unload, if cfgports < portcnt
      IB/ipath: fix handling of kpiobufs
      IB/ipath: drop requirement that PIO buffers be mmaped write-only
      IB/ipath: merge ipath_core and ib_ipath drivers
      IB/ipath: simplify layering code
      IB/ipath: simplify debugging code after ipath_core and ib_ipath merger
      IB/ipath: remove stale references to userspace SMA
      IB/ipath: trivial cleanups
      IB/ipath: add new minor device to allow sending of diag packets
      IB/ipath: do not allow use of CQ entries with invalid counts
      IB/ipath: account for attached QPs correctly
      IB/ipath: support new QLogic product naming scheme
      IB/ipath: add serial number to hardware freeze error message
      IB/ipath: be more strict about testing the modify QP verb
      IB/ipath: validate path_mig_state properly
      IB/ipath: put a limit on the number of QPs that can be created
      IB/ipath: handle sq_sig_all field correctly
      IB/ipath: allow SMA to be disabled
      IB/ipath: fix return value from ipath_poll
      IB/ipath: control receive polarity inversion

Dotan Barak:
      IPoIB: Remove unused include of vmalloc.h

Eli Cohen:
      IPoIB: Rejoin all multicast groups after a port event
      IPoIB: Add some likely/unlikely annotations in hot path

Erez Zilber:
      IB/iser: fix a check of SG alignment for RDMA
      IB/iser: Limit the max size of a scsi command
      IB/iser: make FMR "page size" be 4K and not PAGE_SIZE
      IB/iser: fix some debug prints
      IB/iser: Do not use FMR for a single dma entry sg

Heiko J Schick:
      IB/ehca: Add driver for IBM eHCA InfiniBand adapters

Ishai Rabinovitz:
      IB/srp: Add port/device attributes

Jack Morgenstein:
      IB/mthca: Fix lid used for sending traps
      IB/mthca: Fix default static rate returned for Tavor in AV
      IB/mthca: Return port number for unconnected QPs in query_qp
      IB/mthca: Return correct number of bits for static rate in query_qp
      IB/mthca: Recover from catastrophic errors

James Lentini:
      IB/mthca: Include the header we really want
      IB/mad: Remove unused includes

Krishna Kumar:
      IB: Fix typo in kerneldoc for ib_set_client_data()

Michael S. Tsirkin:
      IB/mthca: Don't use privileged UAR for kernel access
      IB/ipoib: Fix flush/start xmit race (from code review)
      IB/sa: Require SA registration
      IB/cm: Do not track remote QPN in timewait state
      IB/sa: fix ib_sa_selector names

Or Gerlitz:
      RDMA/cma: Document rdma_destroy_id() function
      RDMA/cma: Document rdma_accept() error handling

Ralph Campbell:
      IB/uverbs: Allow resize CQ operation to return driver-specific data
      IB/uverbs: Pass userspace data to modify_srq and modify_qp methods
      IB/ipath: Performance improvements via mmap of queues

Roland Dreier:
      IB/uverbs: Use idr_read_cq() where appropriate
      IB/uverbs: Fix lockdep warning when QP is created with 2 CQs
      IB: Whitespace fixes
      IPoIB: Refactor completion handling
      IB/mthca: Simplify calls to mthca_cq_clean()
      IB/iser: INFINIBAND_ISER depends on INET
      IPoIB: Create MCGs with all attributes required by RFC

Sean Hefty:
      IB/cm: Enable atomics along with RDMA reads
      IB/cm: Use correct reject code for invalid GID
      IB/mad: Add support for dual-sided RMPP transfers.
      IB/cm: Randomize starting comm ID
      RDMA/cma: Protect against adding device during destruction

Tom Tucker:
      RDMA: iWARP Connection Manager.
      RDMA: iWARP Core Changes.
      RDMA/amso1100: Add driver for Ammasso 1100 RNIC

 MAINTAINERS                                       |   16 
 drivers/infiniband/Kconfig                        |    4 
 drivers/infiniband/Makefile                       |    4 
 drivers/infiniband/core/Makefile                  |    4 
 drivers/infiniband/core/addr.c                    |   22 
 drivers/infiniband/core/cache.c                   |    5 
 drivers/infiniband/core/cm.c                      |   66 -
 drivers/infiniband/core/cma.c                     |  403 +++-
 drivers/infiniband/core/device.c                  |    6 
 drivers/infiniband/core/iwcm.c                    | 1019 +++++++++
 drivers/infiniband/core/iwcm.h                    |   62 +
 drivers/infiniband/core/mad.c                     |   19 
 drivers/infiniband/core/mad_priv.h                |    1 
 drivers/infiniband/core/mad_rmpp.c                |   94 +
 drivers/infiniband/core/sa_query.c                |   67 +
 drivers/infiniband/core/smi.c                     |   16 
 drivers/infiniband/core/sysfs.c                   |   13 
 drivers/infiniband/core/ucm.c                     |    9 
 drivers/infiniband/core/user_mad.c                |    7 
 drivers/infiniband/core/uverbs_cmd.c              |   64 -
 drivers/infiniband/core/verbs.c                   |   21 
 drivers/infiniband/hw/amso1100/Kbuild             |    8 
 drivers/infiniband/hw/amso1100/Kconfig            |   15 
 drivers/infiniband/hw/amso1100/c2.c               | 1255 ++++++++++++
 drivers/infiniband/hw/amso1100/c2.h               |  551 +++++
 drivers/infiniband/hw/amso1100/c2_ae.c            |  321 +++
 drivers/infiniband/hw/amso1100/c2_ae.h            |  108 +
 drivers/infiniband/hw/amso1100/c2_alloc.c         |  144 +
 drivers/infiniband/hw/amso1100/c2_cm.c            |  452 ++++
 drivers/infiniband/hw/amso1100/c2_cq.c            |  433 ++++
 drivers/infiniband/hw/amso1100/c2_intr.c          |  209 ++
 drivers/infiniband/hw/amso1100/c2_mm.c            |  375 +++
 drivers/infiniband/hw/amso1100/c2_mq.c            |  174 ++
 drivers/infiniband/hw/amso1100/c2_mq.h            |  106 +
 drivers/infiniband/hw/amso1100/c2_pd.c            |   89 +
 drivers/infiniband/hw/amso1100/c2_provider.c      |  869 ++++++++
 drivers/infiniband/hw/amso1100/c2_provider.h      |  181 ++
 drivers/infiniband/hw/amso1100/c2_qp.c            |  975 +++++++++
 drivers/infiniband/hw/amso1100/c2_rnic.c          |  663 ++++++
 drivers/infiniband/hw/amso1100/c2_status.h        |  158 +
 drivers/infiniband/hw/amso1100/c2_user.h          |   82 +
 drivers/infiniband/hw/amso1100/c2_vq.c            |  260 ++
 drivers/infiniband/hw/amso1100/c2_vq.h            |   63 +
 drivers/infiniband/hw/amso1100/c2_wr.h            | 1520 ++++++++++++++
 drivers/infiniband/hw/ehca/Kconfig                |   16 
 drivers/infiniband/hw/ehca/Makefile               |   16 
 drivers/infiniband/hw/ehca/ehca_av.c              |  271 +++
 drivers/infiniband/hw/ehca/ehca_classes.h         |  346 +++
 drivers/infiniband/hw/ehca/ehca_classes_pSeries.h |  236 ++
 drivers/infiniband/hw/ehca/ehca_cq.c              |  427 ++++
 drivers/infiniband/hw/ehca/ehca_eq.c              |  185 ++
 drivers/infiniband/hw/ehca/ehca_hca.c             |  241 ++
 drivers/infiniband/hw/ehca/ehca_irq.c             |  762 +++++++
 drivers/infiniband/hw/ehca/ehca_irq.h             |   77 +
 drivers/infiniband/hw/ehca/ehca_iverbs.h          |  182 ++
 drivers/infiniband/hw/ehca/ehca_main.c            |  818 ++++++++
 drivers/infiniband/hw/ehca/ehca_mcast.c           |  131 +
 drivers/infiniband/hw/ehca/ehca_mrmw.c            | 2261 +++++++++++++++++++++
 drivers/infiniband/hw/ehca/ehca_mrmw.h            |  140 +
 drivers/infiniband/hw/ehca/ehca_pd.c              |  114 +
 drivers/infiniband/hw/ehca/ehca_qes.h             |  259 ++
 drivers/infiniband/hw/ehca/ehca_qp.c              | 1507 ++++++++++++++
 drivers/infiniband/hw/ehca/ehca_reqs.c            |  653 ++++++
 drivers/infiniband/hw/ehca/ehca_sqp.c             |  111 +
 drivers/infiniband/hw/ehca/ehca_tools.h           |  172 ++
 drivers/infiniband/hw/ehca/ehca_uverbs.c          |  392 ++++
 drivers/infiniband/hw/ehca/hcp_if.c               |  874 ++++++++
 drivers/infiniband/hw/ehca/hcp_if.h               |  261 ++
 drivers/infiniband/hw/ehca/hcp_phyp.c             |   80 +
 drivers/infiniband/hw/ehca/hcp_phyp.h             |   90 +
 drivers/infiniband/hw/ehca/hipz_fns.h             |   68 +
 drivers/infiniband/hw/ehca/hipz_fns_core.h        |  100 +
 drivers/infiniband/hw/ehca/hipz_hw.h              |  388 ++++
 drivers/infiniband/hw/ehca/ipz_pt_fn.c            |  149 +
 drivers/infiniband/hw/ehca/ipz_pt_fn.h            |  247 ++
 drivers/infiniband/hw/ipath/Kconfig               |   21 
 drivers/infiniband/hw/ipath/Makefile              |   29 
 drivers/infiniband/hw/ipath/ipath_common.h        |   19 
 drivers/infiniband/hw/ipath/ipath_cq.c            |  183 +-
 drivers/infiniband/hw/ipath/ipath_debug.h         |    2 
 drivers/infiniband/hw/ipath/ipath_diag.c          |  154 +
 drivers/infiniband/hw/ipath/ipath_driver.c        |  349 ++-
 drivers/infiniband/hw/ipath/ipath_file_ops.c      |   35 
 drivers/infiniband/hw/ipath/ipath_fs.c            |    4 
 drivers/infiniband/hw/ipath/ipath_ht400.c         | 1603 ---------------
 drivers/infiniband/hw/ipath/ipath_iba6110.c       | 1612 +++++++++++++++
 drivers/infiniband/hw/ipath/ipath_iba6120.c       | 1264 ++++++++++++
 drivers/infiniband/hw/ipath/ipath_init_chip.c     |   21 
 drivers/infiniband/hw/ipath/ipath_intr.c          |   24 
 drivers/infiniband/hw/ipath/ipath_kernel.h        |   57 -
 drivers/infiniband/hw/ipath/ipath_keys.c          |    3 
 drivers/infiniband/hw/ipath/ipath_layer.c         | 1179 -----------
 drivers/infiniband/hw/ipath/ipath_layer.h         |  115 -
 drivers/infiniband/hw/ipath/ipath_mad.c           |  339 +++
 drivers/infiniband/hw/ipath/ipath_mmap.c          |  122 +
 drivers/infiniband/hw/ipath/ipath_mr.c            |   12 
 drivers/infiniband/hw/ipath/ipath_pe800.c         | 1254 ------------
 drivers/infiniband/hw/ipath/ipath_qp.c            |  242 ++
 drivers/infiniband/hw/ipath/ipath_rc.c            |    9 
 drivers/infiniband/hw/ipath/ipath_registers.h     |    7 
 drivers/infiniband/hw/ipath/ipath_ruc.c           |  160 +
 drivers/infiniband/hw/ipath/ipath_srq.c           |  244 +-
 drivers/infiniband/hw/ipath/ipath_stats.c         |   27 
 drivers/infiniband/hw/ipath/ipath_sysfs.c         |   41 
 drivers/infiniband/hw/ipath/ipath_uc.c            |    5 
 drivers/infiniband/hw/ipath/ipath_ud.c            |  182 +-
 drivers/infiniband/hw/ipath/ipath_verbs.c         |  687 +++++-
 drivers/infiniband/hw/ipath/ipath_verbs.h         |  252 ++
 drivers/infiniband/hw/ipath/ipath_verbs_mcast.c   |    7 
 drivers/infiniband/hw/ipath/ipath_wc_ppc64.c      |   52 
 drivers/infiniband/hw/ipath/verbs_debug.h         |  108 -
 drivers/infiniband/hw/mthca/mthca_av.c            |    2 
 drivers/infiniband/hw/mthca/mthca_catas.c         |   62 +
 drivers/infiniband/hw/mthca/mthca_cmd.c           |    2 
 drivers/infiniband/hw/mthca/mthca_cq.c            |   10 
 drivers/infiniband/hw/mthca/mthca_dev.h           |   12 
 drivers/infiniband/hw/mthca/mthca_mad.c           |    2 
 drivers/infiniband/hw/mthca/mthca_main.c          |   88 +
 drivers/infiniband/hw/mthca/mthca_provider.c      |    2 
 drivers/infiniband/hw/mthca/mthca_qp.c            |   20 
 drivers/infiniband/hw/mthca/mthca_srq.c           |    2 
 drivers/infiniband/hw/mthca/mthca_uar.c           |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h              |    2 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c           |  194 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c         |   37 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c    |   34 
 drivers/infiniband/ulp/iser/Kconfig               |    2 
 drivers/infiniband/ulp/iser/iscsi_iser.c          |    1 
 drivers/infiniband/ulp/iser/iscsi_iser.h          |    7 
 drivers/infiniband/ulp/iser/iser_memory.c         |   80 +
 drivers/infiniband/ulp/iser/iser_verbs.c          |   10 
 drivers/infiniband/ulp/srp/ib_srp.c               |   43 
 include/rdma/ib_addr.h                            |   17 
 include/rdma/ib_sa.h                              |   45 
 include/rdma/ib_user_verbs.h                      |    2 
 include/rdma/ib_verbs.h                           |   31 
 include/rdma/iw_cm.h                              |  258 ++
 include/rdma/rdma_cm.h                            |   12 
 138 files changed, 28416 insertions(+), 5494 deletions(-)
 create mode 100644 drivers/infiniband/core/iwcm.c
 create mode 100644 drivers/infiniband/core/iwcm.h
 create mode 100644 drivers/infiniband/hw/amso1100/Kbuild
 create mode 100644 drivers/infiniband/hw/amso1100/Kconfig
 create mode 100644 drivers/infiniband/hw/amso1100/c2.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_ae.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_ae.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_alloc.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_cm.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_cq.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_intr.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_mm.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_mq.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_mq.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_pd.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_provider.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_provider.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_qp.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_rnic.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_status.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_user.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_vq.c
 create mode 100644 drivers/infiniband/hw/amso1100/c2_vq.h
 create mode 100644 drivers/infiniband/hw/amso1100/c2_wr.h
 create mode 100644 drivers/infiniband/hw/ehca/Kconfig
 create mode 100644 drivers/infiniband/hw/ehca/Makefile
 create mode 100644 drivers/infiniband/hw/ehca/ehca_av.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_classes.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_classes_pSeries.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_cq.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_eq.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_hca.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_irq.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_irq.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_iverbs.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_main.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_mcast.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_mrmw.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_mrmw.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_pd.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_qes.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_qp.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_reqs.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_sqp.c
 create mode 100644 drivers/infiniband/hw/ehca/ehca_tools.h
 create mode 100644 drivers/infiniband/hw/ehca/ehca_uverbs.c
 create mode 100644 drivers/infiniband/hw/ehca/hcp_if.c
 create mode 100644 drivers/infiniband/hw/ehca/hcp_if.h
 create mode 100644 drivers/infiniband/hw/ehca/hcp_phyp.c
 create mode 100644 drivers/infiniband/hw/ehca/hcp_phyp.h
 create mode 100644 drivers/infiniband/hw/ehca/hipz_fns.h
 create mode 100644 drivers/infiniband/hw/ehca/hipz_fns_core.h
 create mode 100644 drivers/infiniband/hw/ehca/hipz_hw.h
 create mode 100644 drivers/infiniband/hw/ehca/ipz_pt_fn.c
 create mode 100644 drivers/infiniband/hw/ehca/ipz_pt_fn.h
 delete mode 100644 drivers/infiniband/hw/ipath/ipath_ht400.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_iba6110.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_iba6120.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_mmap.c
 delete mode 100644 drivers/infiniband/hw/ipath/ipath_pe800.c
 create mode 100644 drivers/infiniband/hw/ipath/ipath_wc_ppc64.c
 delete mode 100644 drivers/infiniband/hw/ipath/verbs_debug.h
 create mode 100644 include/rdma/iw_cm.h
