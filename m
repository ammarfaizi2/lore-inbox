Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVH2QfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVH2QfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVH2QfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:35:04 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37154 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751084AbVH2QfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:35:01 -0400
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] InfiniBand updates for 2.6.14
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 29 Aug 2005 09:34:54 -0700
Message-ID: <52y86kn1ld.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 29 Aug 2005 16:34:56.0060 (UTC) FILETIME=[96E65FC0:01C5ACB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    rsync://rsync.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git

The only thing slightly noteworthy in this tree is the commit that
moves the InfiniBand midlayer includes from drivers/infiniband/include
to include/rdma.  However, this was discussed in the thread starting
with <http://lkml.org/lkml/2005/8/4/191> and no objections were raised.

Pulling will update the following files:

 drivers/infiniband/core/Makefile               |    2 
 drivers/infiniband/core/agent.c                |   13 
 drivers/infiniband/core/agent_priv.h           |   10 
 drivers/infiniband/core/cache.c                |    6 
 drivers/infiniband/core/cm.c                   |  125 ++---
 drivers/infiniband/core/cm_msgs.h              |  194 ++++----
 drivers/infiniband/core/core_priv.h            |    2 
 drivers/infiniband/core/device.c               |    1 
 drivers/infiniband/core/fmr_pool.c             |    8 
 drivers/infiniband/core/mad.c                  |   15 
 drivers/infiniband/core/mad_priv.h             |   10 
 drivers/infiniband/core/mad_rmpp.c             |  311 ++++++++++---
 drivers/infiniband/core/packer.c               |    3 
 drivers/infiniband/core/sa_query.c             |    6 
 drivers/infiniband/core/smi.c                  |   13 
 drivers/infiniband/core/sysfs.c                |   40 -
 drivers/infiniband/core/ucm.c                  |  464 ++++++-------------
 drivers/infiniband/core/ucm.h                  |   13 
 drivers/infiniband/core/ud_header.c            |   11 
 drivers/infiniband/core/user_mad.c             |   10 
 drivers/infiniband/core/uverbs.h               |   11 
 drivers/infiniband/core/uverbs_cmd.c           |  182 +++++++
 drivers/infiniband/core/uverbs_main.c          |   22 
 drivers/infiniband/core/uverbs_mem.c           |    1 
 drivers/infiniband/core/verbs.c                |   65 ++
 drivers/infiniband/hw/mthca/Makefile           |    4 
 drivers/infiniband/hw/mthca/mthca_allocator.c  |  116 ++++
 drivers/infiniband/hw/mthca/mthca_av.c         |   28 -
 drivers/infiniband/hw/mthca/mthca_cmd.c        |  106 +++-
 drivers/infiniband/hw/mthca/mthca_cmd.h        |   20 
 drivers/infiniband/hw/mthca/mthca_config_reg.h |    1 
 drivers/infiniband/hw/mthca/mthca_cq.c         |  256 +++-------
 drivers/infiniband/hw/mthca/mthca_dev.h        |   52 +-
 drivers/infiniband/hw/mthca/mthca_doorbell.h   |   13 
 drivers/infiniband/hw/mthca/mthca_eq.c         |   63 +-
 drivers/infiniband/hw/mthca/mthca_mad.c        |   10 
 drivers/infiniband/hw/mthca/mthca_main.c       |  179 ++++---
 drivers/infiniband/hw/mthca/mthca_mcg.c        |   36 -
 drivers/infiniband/hw/mthca/mthca_memfree.c    |   12 
 drivers/infiniband/hw/mthca/mthca_memfree.h    |    5 
 drivers/infiniband/hw/mthca/mthca_mr.c         |   35 -
 drivers/infiniband/hw/mthca/mthca_pd.c         |    1 
 drivers/infiniband/hw/mthca/mthca_profile.c    |    2 
 drivers/infiniband/hw/mthca/mthca_profile.h    |    2 
 drivers/infiniband/hw/mthca/mthca_provider.c   |  115 ++++
 drivers/infiniband/hw/mthca/mthca_provider.h   |   54 +-
 drivers/infiniband/hw/mthca/mthca_qp.c         |  362 ++++-----------
 drivers/infiniband/hw/mthca/mthca_srq.c        |  591 +++++++++++++++++++++++++
 drivers/infiniband/hw/mthca/mthca_user.h       |   11 
 drivers/infiniband/hw/mthca/mthca_wqe.h        |  114 ++++
 drivers/infiniband/ulp/ipoib/Makefile          |    2 
 drivers/infiniband/ulp/ipoib/ipoib.h           |   12 
 drivers/infiniband/ulp/ipoib/ipoib_fs.c        |    2 
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    5 
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   33 -
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    8 
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    3 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    1 
 include/rdma/ib_cache.h                        |    4 
 include/rdma/ib_cm.h                           |   93 +--
 include/rdma/ib_fmr_pool.h                     |    2 
 include/rdma/ib_mad.h                          |   26 -
 include/rdma/ib_pack.h                         |    2 
 include/rdma/ib_sa.h                           |   22 
 include/rdma/ib_smi.h                          |   20 
 include/rdma/ib_user_cm.h                      |   28 -
 include/rdma/ib_user_mad.h                     |   10 
 include/rdma/ib_user_verbs.h                   |   39 +
 include/rdma/ib_verbs.h                        |  118 ++++
 69 files changed, 2732 insertions(+), 1424 deletions(-)

through the following changes:

commit a4d61e84804f3b14cc35c5e2af768a07c0f64ef6
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Thu Aug 25 13:40:04 2005 -0700

    [PATCH] IB: move include files to include/rdma
    
    Move the InfiniBand headers from drivers/infiniband/include to include/rdma.
    This allows InfiniBand-using code to live elsewhere, and lets us remove the
    ugly EXTRA_CFLAGS include path from the InfiniBand Makefiles.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 1ad62a19f177e61d4dde111ba35fb4badd0c2106
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Wed Aug 24 14:41:51 2005 -0700

    [PATCH] IPoIB: Fix device removal race
    
    Currently we may have work scheduled in default kernel workqueue when
    the device is going down.  The device could get freed before this
    workqueue gets serviced.  I am actually seeing this causing system
    hangs.
    
    The following patch fixes this by using ipoib_workqueue which gets
    flushed when the device is going down.
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit fe9e08e17af414a5fd8f3141b0fd88677f81a883
Author: Sean Hefty <sean.hefty@intel.com>
Date:   Fri Aug 19 13:50:33 2005 -0700

    [PATCH] IB: Add handling for ABORT and STOP RMPP MADs.
    
    Add handling for ABORT / STOP RMPP MADs.
    
    Signed-off-by: Sean Hefty <sean.hefty@intel.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit b9ef520f9caf20aba8ac7cb2bbba45b52ff19d53
Author: Sean Hefty <sean.hefty@intel.com>
Date:   Fri Aug 19 13:46:34 2005 -0700

    [PATCH] IB: fix userspace CM deadlock
    
    Fix deadlock condition resulting from trying to destroy a cm_id
    from the context of a CM thread.  The synchronization around the
    ucm context structure is simplified as a result, and some simple
    code cleanup is included.
    
    Signed-off-by: Sean Hefty <sean.hefty@intel.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 4ce059378c04b40c2e9f658b1c6a2e9078b85c7c
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Aug 19 12:03:17 2005 -0700

    [PATCH] IPoIB: Set full membership bit in P_Keys
    
    Always make sure that the full membership bit is set in the P_Keys
    that IPoIB uses.  This makes sure that all hosts join the correct
    multicast groups so that hosts that are partial partition members
    can talk to the rest of the network.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit ec34a922d243c3401a694450734e9effb2bafbfe
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Aug 19 10:59:31 2005 -0700

    [PATCH] IB/mthca: Add SRQ implementation
    
    Add mthca support for shared receive queues (SRQs),
    including userspace SRQs.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit d20a40192868082eff6fec729b311cb8463b4a21
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Aug 19 10:36:11 2005 -0700

    [PATCH] IB/mthca: Handle context tables smaller than our chunk size
    
    When creating a table in context memory where the table is smaller
    than our chunk size, we don't want to allocate and map a full chunk.
    Instead, allocate just enough memory to cover the table.
    
    This can be pretty simple because all tables are a power-of-2 size, so
    either the table is a multiple of the chunk size, or it's smaller than
    one chunk.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit c04bc3d1f417a8a90eef9ab46523dfd44858b28d
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Aug 19 10:33:35 2005 -0700

    [PATCH] IB/mthca: Move WQE structures into their own header
    
    Move the definitions of the WQE structures from mthca_qp.c into
    mthca_wqe.h, so that we'll be able to share them when we add the
    SRQ code in mthca_srq.c.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 288bdeb4bc5b89befd7ee2f0f0183604034ff6c5
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Fri Aug 19 09:19:05 2005 -0700

    [PATCH] IB/mthca: Simplify handling of completions with error
    
    Mem-free HCAs never generate error CQEs that complete multiple WQEs,
    so just skip the call to mthca_free_err_wqe() for them rather than
    having logic to handle the mem-free case in mthca_free_err_wqe().
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 87b816706bb2b79fbaff8e0b8e279e783273383e
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Thu Aug 18 13:39:31 2005 -0700

    [PATCH] IB/mthca: Factor out common queue alloc code
    
    Clean up the allocation of memory for queues by factoring out the
    common code into mthca_buf_alloc() and mthca_buf_free().  Now CQs and
    QPs share the same queue allocation code, which we'll also use for SRQs.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit f520ba5aa48e2891c3fb3e364eeaaab4212c7c45
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Thu Aug 18 12:24:13 2005 -0700

    [PATCH] IB: userspace SRQ support
    
    Add SRQ support to userspace verbs module.  This adds several commands
    and associated structures, but it's OK to do this without bumping the
    ABI version because the commands are added at the end of the list so
    they don't change the existing numbering.  There are two cases to
    worry about:
    
    1. New kernel, old userspace.  This is OK because old userspace simply
       won't try to use the new SRQ commands.  None of the old commands are
       changed.
    
    2. Old kernel, new userspace.  This works perfectly as long as
       userspace doesn't try to use SRQ commands.  If userspace tries to
       use SRQ commands, it will get EINVAL, which is perfectly
       reasonable: the kernel doesn't support SRQs, so we couldn't do any
       better.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit d41fcc6705eddd04f7218c985b6da35435ed73cc
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Thu Aug 18 12:23:08 2005 -0700

    [PATCH] IB: Add SRQ support to midlayer
    
    Make the required core API additions and changes for
    shared receive queues (SRQs).
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit d1887ec2125988adccbd8bf0de638c41440bf80e
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Thu Aug 18 12:14:11 2005 -0700

    [PATCH] IB/mthca: Report correct max_msg_sz
    
    Set the max_msg_sz port property correctly in mthca's port_query
    function.  Also zero out the attr struct so that we don't leave
    any other members uninitialized.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit da6561c285a6e28a075b97fd5a1560a2b0ce843e
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Wed Aug 17 07:39:10 2005 -0700

    [PATCH] IB/mthca: Use correct port width capability value
    
    When we call the INIT_IB firmware command to bring up a port, use
    the actual port width capability returned by the QUERY_DEV_LIM
    command instead of always trying to enable both 1X and 4X.  This
    fixes breakage seen when the firmware is build to allow 4X only.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2aeba9a03b0d249fc710b9939fc089ce53d8cd30
Author: Olaf Hering <olh@suse.de>
Date:   Mon Aug 15 14:29:03 2005 -0700

    [PATCH] IB: Remove unnecessary includes of <linux/version.h>
    
    changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
    Remove unneeded includes of <linux/version.h>.
    
    Signed-off-by: Olaf Hering <olh@suse.de>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 5dd2ce1200f4b12687d74de89a527f99e16c344e
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Mon Aug 15 14:16:36 2005 -0700

    [PATCH] IB: Fix ib_mad_thread_completion_handler declaration
    
    Change ib_mad_thread_completion_handler to conform to ib_comp_handler
    declaration.
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 7f9f2dba729cee6ea10596ccb07447d467705b08
Author: Guy German <guyg@voltaire.com>
Date:   Mon Aug 15 07:38:50 2005 -0700

    [PATCH] IB/mthca: use generic function instead of arbel_ version in mthca_free_region()
    
    Use the generic key_to_hw_index() function instead of the Arbel-specific
    version in mthca_free_region().
    
    Signed-off-by: Guy German <guyg@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit ffbf4c34f1916fa1e0554269c94c57da4a21a348
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Mon Aug 15 07:35:16 2005 -0700

    [PATCH] IB: unmap FMRs when destroying FMR pool
    
    Make sure that all FMRs are unmapped before we deallocate them so that
    we don't leak references to our protection domain when destroying an
    FMR pool.  (Bug reported by Guy German <guyg@voltaire.com>)
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2e8b981c5d5c6fe5479ad47c44e3e76ebb5408ef
Author: Michael S. Tsirkin <mst@mellanox.co.il>
Date:   Sat Aug 13 21:19:38 2005 -0700

    [PATCH] IB/mthca: add HCA board ID to sysfs info
    
    Add support for reporting HCA board ID returned from QUERY_ADAPTER
    firmware command through sysfs.
    
    Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 97f52eb438be7caebe026421545619d8a0c1398a
Author: Sean Hefty <sean.hefty@intel.com>
Date:   Sat Aug 13 21:05:57 2005 -0700

    [PATCH] IB: sparse endianness cleanup
    
    Fix sparse warnings.  Use __be* where appropriate.
    
    Signed-off-by: Sean Hefty <sean.hefty@intel.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 92a6b34bf4d0d11c54b2a6bdd6240f98cb326200
Author: Hal Rosenstock <halr@voltaire.com>
Date:   Sat Aug 13 20:50:27 2005 -0700

    [PATCH] IB: Eliminate redundant NULL checks
    
    IPoIB: Eliminate NULL checks prior to calling kfree
    
    Signed-off-by: Hal Rosenstock <halr@voltaire.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 2a1d9b7f09aaaacf235656cb32a40ba2c79590b3
Author: Roland Dreier <roland@eddore.topspincom.com>
Date:   Wed Aug 10 23:03:10 2005 -0700

    [PATCH] IB: Add copyright notices
    
    Make some lawyers happy and add copyright notices for people who
    forgot to include them when they actually touched the code.
    
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

commit 49f6a7fbe123dde25ca4193a7d60705784e18317
Author: Tziporet Koren <tziporet@mellanox.co.il>
Date:   Wed Aug 10 23:00:50 2005 -0700

    [PATCH] IB: Update current firmware versions in mthca driver
    
    Update FW versions in mthca according to July 05 Mellanox release
    
    Signed-off-by: Tziporet Koren <tziporet@mellanox.co.il>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>
