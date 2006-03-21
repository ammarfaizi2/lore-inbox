Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWCURLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWCURLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWCURLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:11:32 -0500
Received: from pat.uio.no ([129.240.130.16]:54421 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751214AbWCURLa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:11:30 -0500
Subject: [GIT] NFS client update for 2.6.16
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Mar 2006 12:11:16 -0500
Message-Id: <1142961077.7987.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.96, required 12,
	autolearn=disabled, AWL 0.94, EXCUSE_3 0.10,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/Kconfig                             |    1 
 fs/lockd/clntlock.c                    |  112 +---
 fs/lockd/clntproc.c                    |  319 ++++-------
 fs/lockd/host.c                        |   12 
 fs/lockd/mon.c                         |   11 
 fs/lockd/svc4proc.c                    |  157 ++---
 fs/lockd/svclock.c                     |  349 +++++++-----
 fs/lockd/svcproc.c                     |  151 ++---
 fs/lockd/svcshare.c                    |    4 
 fs/lockd/svcsubs.c                     |    7 
 fs/lockd/xdr.c                         |   17 -
 fs/lockd/xdr4.c                        |   21 -
 fs/locks.c                             |  106 ++--
 fs/namespace.c                         |   38 +
 fs/nfs/callback.c                      |   20 -
 fs/nfs/callback_xdr.c                  |   28 +
 fs/nfs/delegation.c                    |   19 +
 fs/nfs/delegation.h                    |    1 
 fs/nfs/dir.c                           |  114 +++-
 fs/nfs/direct.c                        |  955 ++++++++++++++++++--------------
 fs/nfs/file.c                          |   49 +-
 fs/nfs/idmap.c                         |   47 +-
 fs/nfs/inode.c                         |  229 ++++++--
 fs/nfs/iostat.h                        |  164 +++++
 fs/nfs/mount_clnt.c                    |   17 -
 fs/nfs/nfs2xdr.c                       |    4 
 fs/nfs/nfs3acl.c                       |   16 -
 fs/nfs/nfs3proc.c                      |  246 ++++----
 fs/nfs/nfs3xdr.c                       |    6 
 fs/nfs/nfs4proc.c                      |  180 +++---
 fs/nfs/nfs4state.c                     |    1 
 fs/nfs/nfs4xdr.c                       |    2 
 fs/nfs/pagelist.c                      |   16 -
 fs/nfs/proc.c                          |  156 +++--
 fs/nfs/read.c                          |  102 +++
 fs/nfs/unlink.c                        |    3 
 fs/nfs/write.c                         |  288 +++++++---
 fs/nfsd/nfs4callback.c                 |    2 
 fs/nfsd/nfs4state.c                    |   13 
 fs/proc/base.c                         |   39 +
 include/linux/fs.h                     |    7 
 include/linux/lockd/lockd.h            |   27 +
 include/linux/lockd/share.h            |    2 
 include/linux/lockd/xdr.h              |    1 
 include/linux/nfs_fs.h                 |  102 +--
 include/linux/nfs_fs_i.h               |    8 
 include/linux/nfs_fs_sb.h              |    6 
 include/linux/nfs_xdr.h                |    5 
 include/linux/sunrpc/clnt.h            |   20 -
 include/linux/sunrpc/gss_krb5.h        |    2 
 include/linux/sunrpc/metrics.h         |   77 +++
 include/linux/sunrpc/rpc_pipe_fs.h     |    2 
 include/linux/sunrpc/sched.h           |    9 
 include/linux/sunrpc/xprt.h            |   13 
 net/sunrpc/auth.c                      |   16 -
 net/sunrpc/auth_gss/auth_gss.c         |    2 
 net/sunrpc/auth_gss/gss_krb5_seal.c    |   15 -
 net/sunrpc/auth_gss/gss_krb5_unseal.c  |    4 
 net/sunrpc/auth_gss/gss_krb5_wrap.c    |   17 -
 net/sunrpc/auth_gss/gss_spkm3_mech.c   |    6 
 net/sunrpc/auth_gss/gss_spkm3_seal.c   |    5 
 net/sunrpc/auth_gss/gss_spkm3_unseal.c |    4 
 net/sunrpc/clnt.c                      |   53 +-
 net/sunrpc/pmap_clnt.c                 |   41 +
 net/sunrpc/rpc_pipe.c                  |   31 +
 net/sunrpc/sched.c                     |   12 
 net/sunrpc/stats.c                     |  115 ++++
 net/sunrpc/xprt.c                      |   29 +
 net/sunrpc/xprtsock.c                  |   49 ++
 69 files changed, 2829 insertions(+), 1873 deletions(-)

commit df6db302cb236ac3a683d535a3e2073d9f4b2833
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:25:10 2006 -0500

    SUNRPC,RPCSEC_GSS: spkm3--fix config dependencies
    
    Add default selection of CRYPTO_CAST5 when selecting RPCSEC_GSS_SPKM3.
    
    Signed-off-by: Kevin Coffman <kwc@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 0e19c1ea2fa57f0612c80595f534b4ddcf69ad8f
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:24:40 2006 -0500

    SUNRPC,RPCSEC_GSS: spkm3: import contexts using NID_cast5_cbc
    
    Import the NID_cast5_cbc from the userland context. Not used.
    
    Signed-off-by: Andy Adamson <andros@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5f12191bc000ea31970339a5f54c11087506711c
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:24:25 2006 -0500

    LOCKD: Make nlmsvc_traverse_shares return void
    
    The nlmsvc_traverse_shares return value is always zero, hence useless.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f3ee439f43381e45b191cf721b4a51d41f33301f
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:24:13 2006 -0500

    LOCKD: nlmsvc_traverse_blocks return is unused
    
    Note that we never return non-zero.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit eaa82edf20d738a7ae31f4b0a5f72f64c14a58df
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:24:04 2006 -0500

    SUNRPC,RPCSEC_GSS: fix krb5 sequence numbers.
    
    Use a spinlock to ensure unique sequence numbers when creating krb5 gss tokens.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 096455a22acac06fb6d0d75f276170ab72d55ba6
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:23:42 2006 -0500

    NFSv4: Dont list system.nfs4_acl for filesystems that don't support it.
    
    Thanks to Frank Filz for pointing out that we list system.nfs4_acl extended
    attribute even on filesystems where we don't actually support nfs4_acl.
    This is inconsistent with the e.g. ext3 POSIX ACL behaviour, and seems to
    annoy cp.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9e57b302cf0f27063184196def620f39ca7a5fc6
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 23:23:11 2006 -0500

    SUNRPC,RPCSEC_GSS: remove unnecessary kmalloc of a checksum
    
    Remove unnecessary kmalloc of temporary space to hold the md5 result; it's
    small enough to just put on the stack.
    
    This code may be called to process rpc's necessary to perform writes, so
    there's a potential deadlock whenever we kmalloc() here.  After this a
    couple kmalloc()'s still remain, to be removed soon.
    
    This also fixes a rare double-free on error noticed by coverity.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7a1218a277c45cba1fb8d7089407a1769c645c43
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 18:11:10 2006 -0500

    SUNRPC: Ensure rpc_call_async() always calls tk_ops->rpc_release()
    
    Currently this will not happen if we exit before rpc_new_task() was called.
    Also fix up rpc_run_task() to do the same (for consistency).
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 43ac3f2961b8616da26114ec6dc76ac2a61f76ad
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:51 2006 -0500

    SUNRPC: Fix memory barriers for req->rq_received
    
    We need to ensure that all writes to the XDR buffers are done before
    req->rq_received is visible to other processors.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c42de9dd67250fe984e0e31c9b542d721af6454b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:51 2006 -0500

    NFS: Fix a race in nfs_sync_inode()
    
    Kudos to Neil Brown for spotting the problem:
    
    "in nfs_sync_inode, there is effectively the sequence:
    
       nfs_wait_on_requests
       nfs_flush_inode
       nfs_commit_inode
    
     This seems a bit racy to me as if the only requests are on the
     ->commit list, and nfs_commit_inode is called separately after
     nfs_wait_on_requests completes, and before nfs_commit_inode start
     (say: by nfs_write_inode) then none of these function will return
     >0, yet there will be some pending request that aren't waited for."
    
    The solution is to search for requests to wait upon, search for dirty
    requests, and search for uncommitted requests while holding the
    nfsi->req_lock
    
    The patch also cleans up nfs_sync_inode(), getting rid of the redundant
    FLUSH_WAIT flag. It turns out that we were always setting it.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7d46a49f512e8d10b23353781a8ba85edd4fa640
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:50 2006 -0500

    NFS: Clean up nfs_flush_list()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit deb7d638262019cbac5d15ab74ffd1c29242c7cb
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:50 2006 -0500

    NFS: Fix a race with PG_private and nfs_release_page()
    
    We don't need to set PG_private for readahead pages, since they never get
    unlocked while I/O is in progress. However there is a small race in
    nfs_readpage_release() whereby the page may be unlocked, and have
    PG_private set.
    
    Fix is to have PG_private set only for the case of writes...
    
    Also fix a bug in nfs_clear_page_writeback(): Don't attempt to clear the
    radix_tree tag if we've already deleted the radix tree entry.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1dd761e9070aa2e543df3db41bd75ed4b8f2fab9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:49 2006 -0500

    NFSv4: Ensure the callback daemon flushes signals
    
    If the callback daemon is signalled, but is unable to exit because it still
    has users, then we need to flush signals. If not, then svc_recv() can
    never sleep, and so we hang.
    If we flush signals, then we also have to be prepared to resend them when
    we want the thread to exit.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5428154827c2bf7cfdc9dab60db1e0eaa57c027a
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:49 2006 -0500

    SUNRPC: Fix a 'Busy inodes' error in rpc_pipefs
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a9a801787a761616589a6526d7a29c13f4deb3d8
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:48 2006 -0500

    NFS, NLM: Allow blocking locks to respect signals
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 03f28e3a2059fc466761d872122f30acb7be61ae
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:48 2006 -0500

    NFS: Make nfs_fhget() return appropriate error values
    
    Currently it returns NULL, which usually gets interpreted as ENOMEM. In
    fact it can mean a host of issues.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 01d0ae8beaee75d954900109619b700fe68707d9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:48 2006 -0500

    NFSv4: Fix an oops in nfs4_fill_super
    
    The mount statistics patches introduced a call to nfs_free_iostats that is
    not only redundant, but actually causes an oops.
    
    Also fix a memory leak due to the lack of a call to nfs_free_iostats on
    unmount.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit d9f6eb75d4900782a095b98470decfe98971f920
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:47 2006 -0500

    lockd: blocks should hold a reference to the nlm_file
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 51581f3bf922512880f52a7777923fd6dcfc792b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:47 2006 -0500

    NFSv4: SETCLIENTID_CONFIRM should handle NFS4ERR_DELAY/NFS4ERR_RESOURCE
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 3e4f6290ca4df7464ee066123f2bca4298c2dab4
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:46 2006 -0500

    NFSv4: Send the delegation stateid for SETATTR calls
    
    In the case where we hold a delegation stateid, use that in for inside
    SETATTR calls.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f25bc34967d76610d17bc70769d7c220976eeeb1
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:46 2006 -0500

    NFSv4: Ensure nfs_callback_down() calls svc_destroy()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 6041b79192bdf0e7ab18ea6859effa5d8311391b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:45 2006 -0500

    lockd: Fix a typo in nlmsvc_grant_release()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit d47166244860eb5dfdb12ee4703968beef8a0db2
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:45 2006 -0500

    lockd: Add helper for *_RES callbacks
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 92737230dd3f1478033819d4bc20339f8da852da
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:45 2006 -0500

    NLM: Add nlmclnt_release_call
    
    Add a helper function to simplify the freeing of NLM client requests.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e4cd038a45a46ffbe06a1a72f3f15246e5b041ca
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:44 2006 -0500

    NLM: Fix nlmclnt_test to not copy private part of locks
    
    The struct file_lock does not carry a properly initialised lock,
    so don't copy it as if it were.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 3a649b884637c4fdff50a6beebc3dc0e6082e048
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:44 2006 -0500

    NLM: Simplify client locks
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit d72b7a6b26b9009b7a05117fe2e04b3a73ae4a5c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:43 2006 -0500

    NFS: O_DIRECT needs to use a completion
    
    Now that we have aio writes, it is possible for dreq->outstanding to be
    zero, but for the I/O not to have completed. Convert struct nfs_direct_req
    to use a completion to signal when the I/O is done.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 6b45d858ed6821dd687efd3b68929de2e4954fec
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:43 2006 -0500

    NFS: Clean up nfs_get_user_pages
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 606bbba06b11ebcbdf3a4fcd8cce4507c5bd7a4b
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:42 2006 -0500

    NFS: fix compiler warnings on 64-bit platforms
    
    Introduced by NFS aio+dio patches.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled on 64-bit hardware.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5eb53f41d11c04aa4ddb9f168b6bbb27b9790348
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:42 2006 -0500

    SUNRPC: fix compile warnings on 64-bit platforms
    
    Introduced by NFS metrics patch.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled on a 64-bit platform.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 35576cba57f1c042b87d6586b3229d13067264c6
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:41 2006 -0500

    NLM: nlmclnt_cancel_callback should accept NLM_LCK_DENIED errors
    
    NLM_LCK_DENIED is a valid error return for an NLM_CANCEL call by the
    client.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 4c060b531006e0711db32a132d6ac7661594b280
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:41 2006 -0500

    lockd: Fix Oopses due to list manipulation errors.
    
    The patch "stop abusing file_lock_list introduces a couple of bugs since
    the locks may be copied and need to be removed from the lists when they are
    destroyed.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 26bcbf965f857c710adafd16cf424f043006b5dd
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Mar 20 13:44:40 2006 -0500

    lockd: stop abusing file_lock_list
    
    Currently lockd directly access the file_lock_list from fs/locks.c.
    It does so to mark locks granted or reclaimable.  This is very
    suboptimal, because a) lockd needs to poke into locks.c internals, and
    b) it needs to iterate over all locks in the system for marking locks
    granted or reclaimable.
    
    This patch adds lists for granted and reclaimable locks to the nlm_host
    structure instead, and adds locks to those.
    
    nlmclnt_lock:
    	now adds the lock to h_granted instead of setting the
    	NFS_LCK_GRANTED, still O(1)
    
    nlmclnt_mark_reclaim:
    	goes away completely, replaced by a list_splice_init.
    	Complexity reduced from O(locks in the system) to O(1)
    
    reclaimer:
    	iterates over h_reclaim now, complexity reduced from
    	O(locks in the system) to O(locks per nlm_host)
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 04266473ecf5cdca242201d9f1ed890afe070fb6
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:40 2006 -0500

    lockd: Make lockd use rpc_new_client() instead of rpc_create_client
    
    When doing NLM_GRANTED requests, lockd may end up blocking if we use
    rpc_create_client() due to the synchronous call to rpc_ping(). Instead, use
    rpc_new_client().
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 686517f1ad1630c11964d668b556aab79b8c942e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:39 2006 -0500

    lockd: Make nlmsvc_create_block() use nlmsvc_lookup_host()
    
    Currently it uses nlmclnt_lookup_host(), which puts the resulting host
    structure on a different list.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5e1abf8cb713a0b94f5a400c7b9b797990cd9dec
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:39 2006 -0500

    lockd: Clean up of the server-side GRANTED code
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 6849c0cab69f5d1a0fc7b05fa5bfb3dec53f86df
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:39 2006 -0500

    lockd: Add refcounting to struct nlm_block
    
    Otherwise, the block may disappear from underneath us when in
    nlmsvc_retry_blocked.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 09c7938c5640a6f22bef074ca6b803dccfdb93e3
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:38 2006 -0500

    lockd: Fix server-side lock blocking code
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 0996905f9301c2ff4c021982c42a15b35e74bf1c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:38 2006 -0500

    lockd: posix_test_lock() should not call locks_copy_lock()
    
    The caller of posix_test_lock() should never need to look at the lock
    private data, so do not copy that information. This also means that there
    is no need to call the fl_release_private methods.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 3feb2d49394b7874348a6e43c076b780c1d222c5
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:37 2006 -0500

    NFS: Uninline nfs_writedata_(alloc|free) and nfs_readdata_(alloc|free)
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5db3a7b2cabe8f0957683f798c4f8fa8605f9ebb
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:37 2006 -0500

    NFS: Debugging code for nfs_direct_(read|write)_schedule()
    
    Make sure that we're doing our list accounting correctly.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a8881f5a5c723f82da84b786d3ca83a0df9e0c33
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:36 2006 -0500

    NFS: O_DIRECT async IO may lose context
    
    The struct nfs_direct_req currently keeps a pointer to the file descriptor
    without referencing it. This may cause problems if the parent process is
    killed.
    
    The nfs_open_context should normally have all the information that we're
    currently using the filp for, and unlike fput(), is safe to release from
    an rpciod process context.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fad61490419b3e494f300e9b2579810ef3bcda31
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:36 2006 -0500

    nfs: Use UNSTABLE + COMMIT for NFS O_DIRECT writes
    
    Currently NFS O_DIRECT writes use FILE_SYNC so that a COMMIT is not
    necessary.  This simplifies the internal logic, but this could be a
    difficult workload for some servers.
    
    Instead, let's send UNSTABLE writes, and after they all complete, send a
    COMMIT for the dirty range.  After the COMMIT returns successfully, then do
    the wake_up or fire off aio_complete().
    
    Test plan:
    Async direct I/O tests against Solaris (or any server that requires
    committed unstable writes).  Reboot server during test.
    
    Based on an earlier patch by Chuck Lever <cel@netapp.com>
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e17b1fc4b35399935f00a635206e183d9292fe4f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:35 2006 -0500

    NFS: Make nfs_commit_alloc() extern
    
    We need to use nfs_commit_alloc() in fs/nfs/direct.c.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a37ec012d7fd352648c8455d3396ea24001efcd3
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:35 2006 -0500

    NFS: fix data_update accounting in NFS direct I/O path
    
    ^C against "iozone -I" is hitting the assertion in nfs_clear_inode().
    
    Test plan:
    "iozone -i0 -I -a -c" against a slow server, then control C.  This should
    not cause an oops.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 15ce4a0c1ce0d5e288398cb9e5493fd4e55e2025
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:34 2006 -0500

    NFS: Replace atomic_t variables in nfs_direct_req with a single spin lock
    
    Three atomic_t variables cause a lot of bus locking.  Because they are all
    used in the same places in the code, just use a single spin lock.
    
    Now that the atomic_t variables are gone, we can remove the request size
    limitation since the code no longer depends on the limited width of atomic_t
    on some platforms.
    
    Test plan:
    Compile with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.  Millions of fsx
    operations, iozone, OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 88467055f7654302c12df74e5fe4d12516656a39
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:34 2006 -0500

    NFS: clean up comments and tab damage in direct.c
    
    Clean up tab damage and comments.  Replace "file_offset" with more commonly
    used "pos".
    
    Test plan:
    Compile with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9eafa8cc521b489f205bf7b0634c99e34e046606
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:33 2006 -0500

    NFS: support EIOCBQUEUED return in direct write path
    
    For async iocb's, the NFS direct write path now returns EIOCBQUEUED,
    and calls aio_complete when all the requested writes are finished.  The
    synchronous part of the NFS direct write path behaves exactly as it
    was before.
    
    Shared mapped NFS files will have some coherency difficulties when
    accessed concurrently with aio+dio.  Will need to explore how this
    is handled in the local file system case.
    
    Test plan:
    aio-stress with "-O". OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c89f2ee5f9223b864725f7344f24a037dfa76568
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:33 2006 -0500

    NFS: make iocb available everywhere in direct write path
    
    Pass the iocb argument all the way down to the direct write request
    scheduler, and make it available in nfs_direct_write_result.
    
    Test plan:
    Compile the kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    Millions of fsx-odirect ops.  OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 47989d7454398827500d0e73766270986a3b488f
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:32 2006 -0500

    NFS: remove support for multi-segment iovs in the direct write path
    
    Eliminate the persistent use of automatic storage in all parts of the
    NFS client's direct write path to pave the way for introducing support
    for aio against files opened with the O_DIRECT flag.
    
    Test plan:
    Compile the kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    Millions of fsx-odirect ops.  OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 462d5b3296b56289efec426499a83faad4c08d9e
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:32 2006 -0500

    NFS: make direct write path generate write requests concurrently
    
    Duplicate infrastructure from direct read path that will allow write
    path to generate multiple write requests concurrently.  This will
    enable us to add support for aio in this path.
    
    Temporarily we will lose the ability to do UNSTABLE writes followed by
    a COMMIT in the direct write path.  However, all applications I am
    aware of that use NFS O_DIRECT currently write in relatively small
    chunks, so this should not be inconvenient in any way.
    
    Test plan:
    Millions of fsx-odirect ops. OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 63ab46abc70b01cb0711301f5ddb08c1c0bb9b1c
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:31 2006 -0500

    NFS: create common routine for handling direct I/O completion
    
    Factor out the common piece of completing an NFS direct I/O request.
    
    Test plan:
    Compile kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 93619e5989173614bef0013b0bb8a3fe3dbd5a95
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:31 2006 -0500

    NFS: create common routine for allocating nfs_direct_req
    
    Factor out a small common piece of the path that allocate nfs_direct_req
    structures.
    
    Test plan:
    Compile kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit bc0fb201b34b12e2d16e8cbd5bb078c1db936304
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:31 2006 -0500

    NFS: create common routine for waiting for direct I/O to complete
    
    We're about to add asynchrony to the NFS direct write path.  Begin by
    abstracting out the common pieces in the read path.
    
    The first piece is nfs_direct_read_wait, which works the same whether the
    process is waiting for a read or a write.
    
    Test plan:
    Compile kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 487b83723ed4d4eaafd5109f36560da4f15c6578
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:30 2006 -0500

    NFS: support EIOCBQUEUED return in direct read path
    
    For async iocb's, the NFS direct read path should return EIOCBQUEUED and
    call aio_complete when all the requested reads are finished.  The
    synchronous part of the NFS direct read path behaves exactly as it was
    before.
    
    Test plan:
    aio-stress with "-O".  OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 99514f8fdda2beef1ca922b7f9d89c1a2c57fec0
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:30 2006 -0500

    NFS: make iocb available everywhere in direct read path
    
    Pass the iocb argument all the way down to the direct read request
    scheduler, and make it available in nfs_direct_read_result.
    
    Test plan:
    Compile the kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    Millions of fsx-odirect ops.  OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 0cdd80d07fb0f558dfdb30f6e0b9905f5e5475f1
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:29 2006 -0500

    NFS: remove support for multi-segment iovs in the direct read path
    
    Eliminate the persistent use of automatic storage in all parts of the NFS
    client's direct read path to pave the way for introducing support for aio
    against files opened with the O_DIRECT flag.
    
    Test plan:
    Compile the kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.
    Millions of fsx-odirect ops.  OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5dd602f20688e08c85ac91e0451c4e6321ed25d7
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:29 2006 -0500

    NFS: use size_t type for holding rsize bytes in NFS O_DIRECT read path
    
    size_t is used for holding byte counts, so use it for variables storing rsize.
    Note that the write path will be updated as we add support for async
    O_DIRECT writes.
    
    Test plan:
    Need to verify that existing comparisons against new size_t variables behave
    correctly.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit d4cc948ba97980c55a308eab167a695109796456
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:28 2006 -0500

    NFS: update comments and function definitions in fs/nfs/direct.c
    
    Update to latest coding style standards.  Remove block comments on
    statically defined functions, and place function definitions all on
    one line.
    
    Test plan:
    Compile kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit b8a32e2b8b7fefff994c89d398b6ac920a195b43
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:28 2006 -0500

    NFS: clean up NFS client's a_ops->direct_IO method
    
    The NFS client's a_ops->direct_IO method, nfs_direct_IO, is required to
    be present to allow NFS files to be opened with O_DIRECT, but is never
    called because the NFS client shunts reads and writes to files opened
    with O_DIRECT directly to its own routines.
    
    Gut the nfs_direct_IO function.  This eliminates the only part of the
    NFS client's direct I/O path that requires support for multi-segment
    iovs, allowing further simplification in subsequent patches.
    
    Test plan:
    Compile the kernel with CONFIG_NFS and CONFIG_NFS_DIRECTIO enabled.  Millions
    of fsx-odirect ops.  OraSim.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ec06c096edec0755534c7126f4caded69de131c2
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:27 2006 -0500

    NFS: Cleanup of NFS read code
    
    Same callback hierarchy inversion as for the NFS write calls. This patch is
    not strictly speaking needed by the O_DIRECT code, but avoids confusing
    differences between the asynchronous read and write code.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 788e7a89a03e364855583c0ab4649b94925efbb9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:27 2006 -0500

    NFS: Cleanup of NFS write code in preparation for asynchronous o_direct
    
    This patch inverts the callback hierarchy for NFS write calls.
    
    Instead of having the NFSv2/v3/v4-specific code set up the RPC callback
    ops, we allow the original caller to do so. This allows for more
    flexibility w.r.t. how to set up and tear down the nfs_write_data
    structure while still allowing the NFSv3/v4 code to perform error
    handling.
    
    The greater flexibility is needed by the asynchronous O_DIRECT code, which
    wants to be able to hold on to the original nfs_write_data structures after
    the WRITE RPC call has completed in order to be able to replay them if the
    COMMIT call determines that the server has rebooted.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7117bf3dfb10b534a017260d9fc643bc1d0afd2a
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Mar 20 13:44:26 2006 -0500

    lockd: Remove FL_LOCKD flag
    
    Currently lockd identifies its own locks using the FL_LOCKD flag.  This
    doesn't scale well to multiple lock managers--if we did this in nfsv4 too,
    for example, we'd be left with only one free flag bit.
    
    Instead, we just check whether the file manager ops (fl_lmops) set on this
    lock are our own.
    
    The only use for this is in nlm_traverse_locks, which uses it to find locks
    that need cleaning up when freeing a host or a file.
    
    In the long run it might be nice to do reference counting instead of
    traversing all the locks like this....
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 8dc7c3115b611c00006eac3ee5b108296432aab7
Author: Andy Adamson <andros@citi.umich.edu>
Date:   Mon Mar 20 13:44:26 2006 -0500

    locks,lockd: fix race in nlmsvc_testlock
    
    posix_test_lock() returns a pointer to a struct file_lock which is unprotected
    and can be removed while in use by the caller.  Move the conflicting lock from
    the return to a parameter, and copy the conflicting lock.
    
    In most cases the caller ends up putting the copy of the conflicting lock on
    the stack.  On i386, sizeof(struct file_lock) appears to be about 100 bytes.
    We're assuming that's reasonable.
    
    Signed-off-by: Andy Adamson <andros@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 2e0af86f618c697b44e2d67dff151256c58201c4
Author: Andy Adamson <andros@citi.umich.edu>
Date:   Mon Mar 20 13:44:26 2006 -0500

    locks: remove unused posix_block_lock
    
    posix_lock_file() is used to add a blocked lock to Lockd's block, so
    posix_block_lock() is no longer needed.
    
    Signed-off-by: Andy Adamson <andros@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a85f193e2fb7d53e48ae6a9d9ea990bfb4cea555
Author: Andy Adamson <andros@citi.umich.edu>
Date:   Mon Mar 20 13:44:25 2006 -0500

    lockd: make nlmsvc_lock use only posix_lock_file
    
    Reorganize nlmsvc_lock() to make full use of posix_lock_file(), which does
    eveything nlmsvc_lock() needs - no need to call posix_test_lock(),
    posix_locks_deadlock(), or posix_block_lock() separately.
    
    Signed-off-by: Andy Adamson <andros@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5de0e5024a4e21251fd80dbfdb83316ce97086bc
Author: Andy Adamson <andros@citi.umich.edu>
Date:   Mon Mar 20 13:44:25 2006 -0500

    lockd: simplify nlmsvc_grant_blocked
    
    Reorganize nlmsvc_grant_blocked() to make full use of posix_lock_file().  Note
    that there's no need for separate calls to posix_test_lock(),
    posix_locks_deadlock(), or posix_block_lock().
    
    Signed-off-by: Andy Adamson <andros@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 15dadef9460ad8d3b1d5ede1c1697dc79af44a72
Author: Andy Adamson <andros@citi.umich.edu>
Date:   Mon Mar 20 13:44:24 2006 -0500

    lockd: clean up nlmsvc_lock
    
    Slightly more consistent dprintk error reporting, consolidate some up()'s.
    
    Signed-off-by: Andy Adamson <andros@citi.umich.edu>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1e7cb3dc12dbbac690d78c84f9c7cb11132ed121
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:24 2006 -0500

    NFS: directory trace messages
    
    Reuse NFSDBG_DIRCACHE and NFSDBG_LOOKUPCACHE to provide additional
    diagnostic messages that trace the operation of the NFS client's
    directory behavior.  A few new messages are now generated when NFSDBG_VFS
    is active, as well, to trace normal VFS activity.  This compromise
    provides better trace debugging for those who use pre-built kernels,
    without adding a lot of extra noise to the standard debug settings.
    
    Test-plan:
    Enable NFS trace debugging with flags 1, 2, or 4.  You should be able to
    see different types of trace messages with each flag setting.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e95b85ec9d8c8ad4667f746aa4c9d22c281efc44
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:23 2006 -0500

    SUNRPC: minor cleanup
    
    RPC_DEBUG_DATA no longer needed in net/sunrpc/xprt.c.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit dead28da8e3fb32601d38fb32b7021122e0a3d21
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:23 2006 -0500

    SUNRPC: eliminate rpc_call()
    
    Clean-up: replace rpc_call() helper with direct call to rpc_call_sync.
    
    This makes NFSv2 and NFSv3 synchronous calls more computationally
    efficient, and reduces stack consumption in functions that used to
    invoke rpc_call more than once.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled.  Connectathon on NFS version 2,
    version 3, and version 4 mount points.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cc0175c1dc1de8f6af0eb0631dcc5b999a6fcc42
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:22 2006 -0500

    SUNRPC: display human-readable procedure name in rpc_iostats output
    
    Add fields to the rpc_procinfo struct that allow the display of a
    human-readable name for each procedure in the rpc_iostats output.
    
    Also fix it so that the NFSv4 stats are broken up correctly by
    sub-procedure number.  NFSv4 uses only two real RPC procedures:
    NULL, and COMPOUND.
    
    Test plan:
    Mount with NFSv2, NFSv3, and NFSv4, and do "cat /proc/self/mountstats".
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 4ece3a2d18fd7fe1d4972284a8c98c569020093f
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:22 2006 -0500

    NFS: add RPC I/O statistics to /proc/self/mountstats
    
    NFS client now shows various RPC I/O metrics in /proc/self/mountstats.
    
    Test plan:
    Mount/umount while doing "cat /proc/self/mountstats", multiple iterations
    of connectathon locking suite.  Test with NFS version 2, 3, and 4.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 11c556b3d8d481829ab5f9933a25d29b00913b5a
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:22 2006 -0500

    SUNRPC: provide a mechanism for collecting stats in the RPC client
    
    Add a simple mechanism for collecting stats in the RPC client.  Stats are
    tabulated during xprt_release.  Note that per_cpu shenanigans are not
    required here because the RPC client already serializes on the transport
    write lock.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled.  Basic performance regression
    testing with high-speed networking and high performance server.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ef759a2e54ed434b2f72b52a14edecd6d4eadf74
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:17 2006 -0500

    SUNRPC: introduce per-task RPC iostats
    
    Account for various things that occur while an RPC task is executed.
    Separate timers for RPC round trip and RPC execution time show how
    long RPC requests wait in queue before being sent.  Eventually these
    will be accumulated at xprt_release time in one place where they can
    be viewed from userland.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 262ca07de4d7f1bff20361c1353bb14b3607afb2
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:16 2006 -0500

    SUNRPC: add a handful of per-xprt counters
    
    Monitor generic transport events.  Add a transport switch callout to
    format transport counters for export to user-land.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e19b63dafdf7d615b0d36b90990a07e7792b9d3a
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:15 2006 -0500

    SUNRPC: track length of RPC wait queues
    
    RPC wait queue length will eventually be exported to userland via the RPC
    iostats interface.
    
    Test plan:
    Compile kernel with CONFIG_NFS enabled.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 67ec9f46b889bfb1ab0a4e307d53929d5f0692bf
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:15 2006 -0500

    NFS: report how long an NFS file system has been mounted
    
    Add a field in nfs_server to record a timestamp when a mount succeeds.
    Report the number of seconds the file system has been mounted via
    nfs_show_stats().
    
    Test plan:
    Mount an NFS file system, watch the mountstats reports and compare with
    clock time.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 006ea73e5fa82915d0ac7a3f15ee7c688433236d
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:14 2006 -0500

    NFS: add hooks to account for NFSERR_JUKEBOX errors
    
    Make an inode or an nfs_server struct available in the logic that handles
    JUKEBOX/DELAY type errors so the NFS client can account for them.
    
    This patch is split out from the main nfs iostat patch to highlight minor
    architectural changes required to support this statistic.
    
    Test plan:
    None.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 91d5b47023b608227d605d1e916b29dd0215bff7
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:14 2006 -0500

    NFS: add I/O performance counters
    
    Invoke the byte and event counter macros where we want to count bytes and
    events.
    
    Clean-up: fix a possible NULL dereference in nfs_lock, and simplify
    nfs_file_open.
    
    Test-plan:
    fsx and iozone on UP and SMP systems, with and without pre-emption.  Watch
    for memory overwrite bugs, and performance loss (significantly more CPU
    required per op).
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit d9ef5a8c26aab09762afce43df64736720b4860e
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:13 2006 -0500

    NFS: introduce mechanism for tracking NFS client metrics
    
    Add a per-superblock performance counter facility to the NFS client.  This
    facility mimics the counters available for block devices and for
    networking.  Expose these new counters via the new /proc/self/mountstats
    interface.
    
    Thanks to Andrew Morton and Trond Myklebust for their review and comments.
    
    Test plan:
    fsx and iozone on UP and SMP systems, with and without pre-emption.  Watch
    for memory overwrite bugs, and performance loss (significantly more CPU
    required per op).
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c8bded96aa8735823e53c95a26177987ebb19a90
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:13 2006 -0500

    NFS: clean up some mount options
    
    Get rid of "lock" and "posix", and spell out "vers=".
    
    Test plan:
    None.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7a480e250c7ca9187275d8574ae9e48a6b602cb9
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:12 2006 -0500

    NFS: show retransmit settings when displaying mount options
    
    Sometimes it's important to know the exact RPC retransmit settings the
    kernel is using for an NFS mount point.  Add this facility to the NFS
    client's show_options method.
    
    Test plan:
    Set various retransmit settings via the mount command, and check that the
    settings are reflected in /proc/mounts.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit b4629fe2f094b719847f31be1ee5ab38300038b2
Author: Chuck Lever <cel@netapp.com>
Date:   Mon Mar 20 13:44:12 2006 -0500

    VFS: New /proc file /proc/self/mountstats
    
    Create a new file under /proc/self, called mountstats, where mounted file
    systems can export information (configuration options, performance counters,
    and so on).  Use a mechanism similar to /proc/mounts and s_ops->show_options.
    
    This mechanism does not violate namespace security, and is safe to use while
    other processes are unmounting file systems.
    
    Thanks to Mike Waychison for his review and comments.
    
    Test-plan:
    Test concurrent mount/unmount operations while cat'ing /proc/self/mountstats.
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1356b8c28d67cafd74f7e7dcfb39bf53681790a5
Author: Levent Serinol <lserinol@gmail.com>
Date:   Mon Mar 20 13:44:11 2006 -0500

    SUNRPC: more verbose output for rpc auth weak error
    
    This patch adds server ip address to be printed out when "server
    requires stronger authentication" error occured.
    
    Signed-off-by: Levent Serinol <lserinol@gmail.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 24bd68f46b1ad08d69bf32779f860df867780a7a
Author: Goldwyn Rodrigues <rgoldwyn@gmail.com>
Date:   Mon Mar 20 13:44:11 2006 -0500

    NFS: Code comments update in NFS
    
    read_cache_mtime is no longer used in nfs_inode. This patch removes
    references of read_cache_mtime in the code comments.
    
    Signed-off-by: Goldwyn Rodrigues <rgoldwyn@gmail.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c9d5128a10a4974f72674ff3463da4db439e8b04
Author: Ingo Molnar <mingo@elte.hu>
Date:   Mon Mar 20 13:44:11 2006 -0500

    NFS: sem2mutex idmap.c
    
    semaphore to mutex conversion.
    
    the conversion was generated via scripts, and the result was validated
    automatically via a script as well.
    
    build and boot tested.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit bd6475454c774bd9dbe6078d94bbf72b1d3b65f4
Author: Eric Sesterhenn <snakebyte@gmx.de>
Date:   Mon Mar 20 13:44:10 2006 -0500

    NFS: kzalloc conversion in fs/nfs
    
    this converts fs/nfs to kzalloc() usage.
    compile tested with make allyesconfig
    
    Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a162a6b804b48c605d1fd35e1861a5d32d00ad3f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:10 2006 -0500

    NFSv4: Kill braindead gcc warnings
    
    nfs4_open_revalidate: 'res' may be used uninitialized
    nfs4_callback_compound: ‘hdr_res.nops’ may be used uninitialized
    			'op_nr’ may be used uninitialized
    encode_getattr_res: ‘savep’ may be used uninitialized
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 967b9281361481aecf323563886ef972ee88c681
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:09 2006 -0500

    NFSv4: Do not call rpciod_down() before call to destroy_nfsv4_state()
    
    The reason is that the idmapper cleanup may call flush_workqueue() on
    rpciod_workqueue.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 12de3b35ea549c5819f287508d7afab0bf3ac44d
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:09 2006 -0500

    SUNRPC: Ensure that rpc_mkpipe returns a refcounted dentry
    
    If not, we cannot guarantee that idmap->idmap_dentry, gss_auth->dentry and
    clnt->cl_dentry are valid dentries.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 24c5d9d7ea5a64fb5f157d17aa2c67a3300f8a08
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:08 2006 -0500

    SUNRPC: Run rpci->queue_timeout on the rpciod workqueue instead of generic
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f344f6df4b2baa3e5c553c461735dfaf92f44be7
Author: Olaf Kirch <okir@suse.de>
Date:   Mon Mar 20 13:44:08 2006 -0500

    SUNRPC: Auto-load RPC authentication kernel modules
    
    This patch adds a request_module call to rpcauth_create which will try
    to auto-load the kernel module for the requested authentication flavor.
    For kernels with modular sunrpc, this reduces the admin overhead for
    the user.
    
    Signed-off-by: Olaf Kirch <okir@suse.de>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fb374d24f225f38f13dbffb65dd7ec72daf08dba
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:08 2006 -0500

    NFS: reduce the number of false cache invalidations.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c8d149f3dbd582a101aa7da7bdd6c3316efd11b4
Author: Jesper Juhl <jesper.juhl@gmail.com>
Date:   Mon Mar 20 13:44:07 2006 -0500

    NFS: "const static" vs "static const" in nfs4
    
    My previous "const static" vs "static const" cleanup missed a single case,
    patch below takes care of it.
    
    Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ca62b9c3f7b8679ada4de94d2ab7098c6860c3d7
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:07 2006 -0500

    NFSv4: Don't invalidate cached attributes if change attribute is unchanged
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 755c1e20cd2ad56e5c567fa05769eb98a3eef72b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:06 2006 -0500

    NFS: writes should not clobber utimes() calls
    
    Ensure that we flush out writes in the case when someone calls utimes() in
    order to set the file times.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7bab377fcb495ee2e5a1cd69d235f8d84c76e3af
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:06 2006 -0500

    lockd: Don't expose the process pid to the NLM server
    
    Instead we use the nlm_lockowner->pid.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 36943fa4b2701b9ef2d60084c85ecbe634aec252
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:05 2006 -0500

    NLM: nlm_alloc_call should not immediately fail on signal
    
    Currently, nlm_alloc_call tests for a signal before it even tries to
    allocate memory.
    Fix it so that it tries at least once.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 47831f35b83e43c804215712dd0c834c92e8a441
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:05 2006 -0500

    VFS: Fix __posix_lock_file() copy of private lock area
    
    The struct file_lock->fl_u area must be copied using the fl_copy_lock()
    operation.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1dd594b21b2d98e56f2b1fe92bb222276b28de41
Author: Neil Brown <neilb@suse.de>
Date:   Mon Mar 20 13:44:04 2006 -0500

    NFS: Fix buglet in fs/nfs/write.c
    
    I've been reading through fs/nfs/write.c trying to track down a bug
    that seems to be related to pages loosing a refcount and getting
    freed too early (you interested in detail??) and I spotted a little
    bug which the following patch should fix.
    
    Signed-off-by: Neil Brown <neilb@suse.de>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cd52ed35535ef443f08bf5cd3331d350272885b8
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:04 2006 -0500

    NFS: Avoid races between writebacks and truncation
    
    Currently, there is no serialisation between NFS asynchronous writebacks
    and truncation at the page level due to the fact that nfs_sync_inode()
    cannot lock the pages that it is about to write out.
    
    This means that it is possible to be flushing out data (and calling something
    like set_page_writeback()) while the page cache is busy evicting the page.
    Oops...
    
    Use the hooks provided in try_to_release_page() to ensure that dirty pages
    are always written back to storage before we evict them.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit b92dccf65bab3b6b7deb79ff3321dc256eb0f53b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Mar 20 13:44:03 2006 -0500

    NFS: Fix a busy inodes issue...
    
    The nfs_open_context may live longer than the file descriptor that spawned
    it, so it needs to carry a reference to the vfsmount. If not, then
    generic_shutdown_super() may end up being called before reads and writes
    have been flushed out.
    
    Make a couple of functions static while we're at it...
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>



