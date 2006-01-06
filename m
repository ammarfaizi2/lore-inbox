Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752553AbWAFUh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbWAFUh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbWAFUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:37:25 -0500
Received: from pat.uio.no ([129.240.130.16]:46828 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1752553AbWAFUhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:37:23 -0500
Subject: [GIT] NFS client updates against 2.6.15 available
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 06 Jan 2006 15:37:14 -0500
Message-Id: <1136579834.7843.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.929, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will change the following files through the appended changesets.

  Cheers,
    Trond

----
 net/sunrpc/auth_gss/gss_krb5_mech.c    |   10 +
 net/sunrpc/auth_gss/gss_spkm3_mech.c   |   10 +
 include/linux/sunrpc/gss_spkm3.h       |    2 
 net/sunrpc/auth_gss/gss_spkm3_seal.c   |   11 +
 net/sunrpc/auth_gss/gss_spkm3_token.c  |    3 
 net/sunrpc/auth_gss/gss_spkm3_unseal.c |    2 
 fs/nfs/delegation.c                    |    6 -
 Documentation/kernel-parameters.txt    |    4 
 fs/nfs/idmap.c                         |    9 +
 fs/nfs/inode.c                         |   14 ++
 fs/nfs/sysctl.c                        |   10 +
 include/linux/nfs_idmap.h              |    2 
 net/sunrpc/xprt.c                      |   30 +--
 include/linux/sunrpc/xprt.h            |    1 
 net/sunrpc/xprt.c                      |   33 ++--
 net/sunrpc/xprtsock.c                  |   12 +
 fs/nfs/nfs2xdr.c                       |   21 +-
 fs/nfs/nfs3xdr.c                       |    2 
 fs/nfs/nfs4xdr.c                       |    2 
 fs/nfs/proc.c                          |    3 
 fs/lockd/clntproc.c                    |    3 
 fs/lockd/mon.c                         |    1 
 fs/nfs/inode.c                         |    2 
 fs/nfs/mount_clnt.c                    |    1 
 fs/nfsd/nfs4callback.c                 |    1 
 include/linux/sunrpc/clnt.h            |    1 
 net/sunrpc/clnt.c                      |   10 -
 net/sunrpc/pmap_clnt.c                 |    1 
 include/linux/sunrpc/xprt.h            |    1 
 net/sunrpc/pmap_clnt.c                 |    8 +
 net/sunrpc/xprtsock.c                  |   14 ++
 fs/lockd/host.c                        |    4 
 include/linux/sunrpc/clnt.h            |    1 
 net/sunrpc/clnt.c                      |   21 ++
 include/linux/sunrpc/sched.h           |    3 
 include/linux/sunrpc/xprt.h            |   10 +
 net/sunrpc/clnt.c                      |   14 +-
 net/sunrpc/sched.c                     |   50 +++---
 net/sunrpc/xprt.c                      |    3 
 net/sunrpc/xprtsock.c                  |    5 +
 fs/nfs/nfs3proc.c                      |   26 ++-
 fs/lockd/xdr4.c                        |    4 
 fs/lockd/svclock.c                     |   15 +-
 fs/locks.c                             |    7 +
 include/linux/fs.h                     |    2 
 fs/lockd/svclock.c                     |    3 
 fs/lockd/svclock.c                     |    5 -
 fs/locks.c                             |   13 --
 fs/lockd/svclock.c                     |    7 -
 include/linux/sunrpc/xdr.h             |    1 
 net/sunrpc/xdr.c                       |   21 --
 Documentation/kernel-parameters.txt    |    4 
 fs/nfs/Makefile                        |    1 
 fs/nfs/callback.c                      |    3 
 fs/nfs/callback.h                      |    1 
 fs/nfs/inode.c                         |   37 ++++
 fs/nfs/sysctl.c                        |   74 +++++++++
 include/linux/nfs_fs.h                 |   11 +
 fs/nfs/inode.c                         |   60 +++++--
 fs/nfs/delegation.c                    |    2 
 fs/nfs/nfs4proc.c                      |   17 ++
 fs/nfs/nfs4xdr.c                       |   33 +++-
 include/linux/nfs_xdr.h                |    6 +
 fs/nfs/callback_proc.c                 |    4 
 fs/nfs/delegation.c                    |    1 
 fs/nfs/delegation.h                    |    1 
 net/sunrpc/rpc_pipe.c                  |    9 +
 fs/nfs/direct.c                        |    7 -
 fs/nfs/inode.c                         |    2 
 fs/nfs/write.c                         |   23 +--
 include/linux/nfs_fs.h                 |    1 
 fs/nfs/dir.c                           |    4 
 fs/nfs/direct.c                        |    5 -
 fs/nfs/inode.c                         |   25 +--
 fs/nfs/nfsroot.c                       |    4 
 fs/nfs/read.c                          |    6 -
 fs/nfs/write.c                         |   29 +++
 include/linux/nfs_fs.h                 |   41 ++++-
 include/linux/nfs_xdr.h                |   29 ++-
 include/linux/sunrpc/xdr.h             |    5 -
 fs/nfs/inode.c                         |   17 +-
 fs/nfs/inode.c                         |    3 
 include/linux/nfs_page.h               |   12 -
 fs/nfs/inode.c                         |    4 
 fs/nfs/direct.c                        |   43 ++---
 fs/nfs/inode.c                         |   14 --
 fs/nfs/nfs4_fs.h                       |    6 -
 fs/nfs/nfs4proc.c                      |   10 +
 fs/nfs/nfs4state.c                     |   71 +++++---
 fs/nfs/nfs4_fs.h                       |    5 -
 fs/nfs/nfs4proc.c                      |   38 ++--
 fs/nfs/nfs4renewd.c                    |    7 +
 fs/nfs/nfs4state.c                     |   16 ++
 fs/nfs/delegation.c                    |   46 +++++
 fs/nfs/delegation.h                    |    1 
 fs/nfs/nfs4_fs.h                       |    1 
 fs/nfs/nfs4proc.c                      |   20 ++
 fs/nfs/nfs4renewd.c                    |    9 +
 fs/nfs/nfs4state.c                     |   46 ++---
 fs/nfs/nfs4_fs.h                       |    3 
 fs/nfs/nfs4proc.c                      |   27 ++-
 fs/nfs/nfs4state.c                     |   23 ++-
 fs/nfs/nfs4proc.c                      |   34 ++++
 fs/lockd/svc.c                         |    4 
 net/sunrpc/clnt.c                      |    4 
 fs/nfs/nfs4proc.c                      |   68 +++++++-
 fs/nfs/nfs4proc.c                      |  244 ++++++++++++++++++++--------
 fs/nfs/nfs4xdr.c                       |    6 -
 fs/nfs/nfs4proc.c                      |  192 +++++++++-------------
 fs/nfs/nfs4xdr.c                       |  131 +++++++++------
 include/linux/nfs_xdr.h                |   52 +++---
 fs/nfs/nfs4proc.c                      |  276 +++++++++++++++++---------------
 fs/nfs/nfs4xdr.c                       |   11 +
 fs/nfs/nfs4_fs.h                       |    5 -
 fs/nfs/nfs4proc.c                      |   34 +++-
 fs/nfs/nfs4state.c                     |   31 ++--
 fs/nfs/nfs4proc.c                      |  101 +++++++++---
 fs/nfs/nfs4xdr.c                       |    7 -
 include/linux/nfs_xdr.h                |    2 
 fs/nfs/nfs4proc.c                      |  193 +++++++++++++++-------
 fs/nfs/nfs4xdr.c                       |    3 
 net/sunrpc/clnt.c                      |   11 +
 net/sunrpc/sched.c                     |    4 
 net/sunrpc/sunrpc_syms.c               |    4 
 fs/nfs/nfs4proc.c                      |  213 ++++++++++++++-----------
 fs/nfs/nfs4proc.c                      |   65 ++++----
 fs/nfs/direct.c                        |    1 
 include/linux/sunrpc/sched.h           |   21 ++
 net/sunrpc/sched.c                     |   78 +++++++--
 fs/nfs/nfs4proc.c                      |   21 +-
 fs/nfs/unlink.c                        |   13 +-
 include/linux/sunrpc/sched.h           |    1 
 net/sunrpc/sched.c                     |   10 +
 fs/lockd/clntproc.c                    |   38 ++--
 fs/lockd/svc4proc.c                    |   15 +-
 fs/lockd/svclock.c                     |   14 +-
 fs/lockd/svcproc.c                     |   14 +-
 fs/nfs/direct.c                        |    1 
 fs/nfs/nfs3proc.c                      |   44 +++--
 fs/nfs/nfs4proc.c                      |  107 +++++++-----
 fs/nfs/proc.c                          |   28 ++-
 fs/nfs/read.c                          |   10 -
 fs/nfs/unlink.c                        |   19 +-
 fs/nfs/write.c                         |   21 +-
 fs/nfsd/nfs4callback.c                 |   10 +
 include/linux/lockd/lockd.h            |    2 
 include/linux/nfs_fs.h                 |   12 +
 include/linux/sunrpc/clnt.h            |    3 
 include/linux/sunrpc/sched.h           |   20 ++
 net/sunrpc/clnt.c                      |   15 +-
 net/sunrpc/sched.c                     |   53 +++---
 include/linux/sunrpc/sched.h           |    3 
 net/sunrpc/clnt.c                      |   32 ++--
 net/sunrpc/pmap_clnt.c                 |    8 -
 net/sunrpc/sched.c                     |   31 +---
 fs/nfs/write.c                         |   16 +-
 include/linux/writeback.h              |    9 +
 mm/page-writeback.c                    |   10 +
 158 files changed, 2244 insertions(+), 1443 deletions(-)

commit 9e56904e41e242169007e69d9916059dab995d90
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:56:01 2006 +0100

    SUNRPC: Make krb5 report unsupported encryption types
    
     Print messages when an unsupported encrytion algorthm is requested or
     there is an error locating a supported algorthm.
    
     Signed-off-by: Kevin Coffman <kwc@citi.umich.edu>
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 42181d4bafe9047d0cd7f92fc11d79496bd95034
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:56:01 2006 +0100

    SUNRPC: Make spkm3 report unsupported encryption types
    
     Print messages when an unsupported encrytion algorthm is requested or
     there is an error locating a supported algorthm.
    
     Signed-off-by: Kevin Coffman <kwc@citi.umich.edu>
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9eed129bbde80cbd7ffeacaa1555ba1e0c9a0997
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:56:00 2006 +0100

    SUNRPC: Update the spkm3 code to use the make_checksum interface
    
     Also update the tokenlen calculations to accomodate g_token_size().
    
     Signed-off-by: Andy Adamson <andros@citi.umich.edu>
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 26c78e156b1d1b2387ec33b5f2fb62d6e0a186a3
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:58 2006 +0100

    NFSv4: Fix an Oops in nfs_do_expire_all_delegations
    
     If the loop errors, we need to exit.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 58df095b732529ade8f4051b41d7c29731afecd6
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:57 2006 +0100

    NFSv4: Allow entries in the idmap cache to expire
    
     If someone changes the uid/gid mapping in userland, then we do eventually
     want those changes to be propagated to the kernel. Currently the kernel
     assumes that it may cache entries forever.
    
     Add an expiration time + garbage collector for idmap entries.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 0065db328533c390fbfb0fe0c46bcf9a278fb99e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:56 2006 +0100

    SUNRPC: Clean up xprt_destroy()
    
     We ought never to be calling xprt_destroy() if there are still active
     rpc_tasks. Optimise away the broken code that attempts to "fix" that case.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 632e3bdc5006334cea894d078660b691685e1075
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:55 2006 +0100

    SUNRPC: Ensure client closes the socket when server initiates a close
    
     If the server decides to close the RPC socket, we currently don't actually
     respond until either another RPC call is scheduled, or until xprt_autoclose()
     gets called by the socket expiry timer (which may be up to 5 minutes
     later).
    
     This patch ensures that xprt_autoclose() is called much sooner if the
     server closes the socket.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit eadb8c147154bff982f02accf31b847a1f142ace
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:54 2006 +0100

    NFS: get rid of some needless code obfuscation in xdr_encode_sattr().
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cf3fff54a46e1f8fa4cc1deb783172a392077eb0
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:53 2006 +0100

    NFS: Send valid mode bits to the server
    
     inode->i_mode contains a lot more than just the mode bits. Make sure that
     we mask away this extra stuff in SETATTR calls to the server.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f518e35aec984036903c1003e867f833747a9d79
Author: Chuck Lever <cel@netapp.com>
Date:   Tue Jan 3 09:55:52 2006 +0100

    SUNRPC: get rid of cl_chatty
    
     Clean up: Every ULP that uses the in-kernel RPC client, except the NLM
     client, sets cl_chatty.  There's no reason why NLM shouldn't set it, so
     just get rid of cl_chatty and always be verbose.
    
     Test-plan:
     Compile with CONFIG_NFS enabled.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 922004120b10dcb0ce04b55014168e8a7a8c1a0e
Author: Chuck Lever <cel@netapp.com>
Date:   Tue Jan 3 09:55:51 2006 +0100

    SUNRPC: transport switch API for setting port number
    
     At some point, transport endpoint addresses will no longer be IPv4.  To hide
     the structure of the rpc_xprt's address field from ULPs and port mappers,
     add an API for setting the port number during an RPC bind operation.
    
     Test-plan:
     Destructive testing (unplugging the network temporarily).  Connectathon
     with UDP and TCP.  NFSv2/3 and NFSv4 mounting should be carefully checked.
     Probably need to rig a server where certain services aren't running, or
     that returns an error for some typical operation.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 35f5a422ce1af836007f811b613c440d0e348e06
Author: Chuck Lever <cel@netapp.com>
Date:   Tue Jan 3 09:55:50 2006 +0100

    SUNRPC: new interface to force an RPC rebind
    
     We'd like to hide fields in rpc_xprt and rpc_clnt from upper layer protocols.
     Start by creating an API to force RPC rebind, replacing logic that simply
     sets cl_port to zero.
    
     Test-plan:
     Destructive testing (unplugging the network temporarily).  Connectathon
     with UDP and TCP.  NFSv2/3 and NFSv4 mounting should be carefully checked.
     Probably need to rig a server where certain services aren't running, or
     that returns an error for some typical operation.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 02107148349f31eee7c0fb06fd7a880df73dbd20
Author: Chuck Lever <cel@netapp.com>
Date:   Tue Jan 3 09:55:49 2006 +0100

    SUNRPC: switchable buffer allocation
    
     Add RPC client transport switch support for replacing buffer management
     on a per-transport basis.
    
     In the current IPv4 socket transport implementation, RPC buffers are
     allocated as needed for each RPC message that is sent.  Some transport
     implementations may choose to use pre-allocated buffers for encoding,
     sending, receiving, and unmarshalling RPC messages, however.  For
     transports capable of direct data placement, the buffers can be carved
     out of a pre-registered area of memory rather than from a slab cache.
    
     Test-plan:
     Millions of fsx operations.  Performance characterization with "sio" and
     "iozone".  Use oprofile and other tools to look for significant regression
     in CPU utilization.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 03c21733938aad0758f5f88e1cc7ede69fc3c910
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:55:48 2006 +0100

    NFSv3: try get_root user-supplied security_flavor
    
     Thanks to Ed Keizer for bug and root cause.  He says: "... we could only mount
     the top-level Solaris share. We could not mount deeper into the tree.
     Investigation showed that Solaris allows UNIX authenticated FSINFO only on the
     top level of the share. This is a problem because we share/export our home
     directories one level higher than we mount them. I.e. we share the partition
     and not the individual home directories. This prevented access to home
     directories."
    
     We still may need to try auth_sys for the case where the client doesn't have
     appropriate credentials.
    
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a659753ecc66945e9c69823fcbbe222b446c66d7
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:55:46 2006 +0100

    NLM: fix parsing of sm notify procedure
    
     The procedure that decodes statd sm_notify call seems to be skipping a
     few arguments.  How did this ever work?
    
     >From folks at Polyserve.
    
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 64a318ee2af9000df482d7a125c3b3e1f1007404
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:55:46 2006 +0100

    NLM: Further cancel fixes
    
     If the server receives an NLM cancel call and finds no waiting lock to
     cancel, then chances are the lock has already been applied, and the client
     just hadn't yet processed the NLM granted callback before it sent the
     cancel.
    
     The Open Group text, for example, perimts a server to return either success
     (LCK_GRANTED) or failure (LCK_DENIED) in this case.  But returning an error
     seems more helpful; the client may be able to use it to recognize that a
     race has occurred and to recover from the race.
    
     So, modify the relevant functions to return an error in this case.
    
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 2c5acd2e1a73cad59203a1bace21e6b03f2920a9
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:55:45 2006 +0100

    NLM: clean up nlmsvc_delete_block
    
     The fl_next check here is superfluous (and possibly a layering violation).
    
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5996a298da43a03081e9ba2116983d173001c862
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:55:44 2006 +0100

    NLM: don't unlock on cancel requests
    
     Currently when lockd gets an NLM_CANCEL request, it also does an unlock for
     the same range.  This is incorrect.
    
     The Open Group documentation says that "This procedure cancels an
     *outstanding* blocked lock request."  (Emphasis mine.)
    
     Also, consider a client that holds a lock on the first byte of a file, and
     requests a lock on the entire file.  If the client cancels that request
     (perhaps because the requesting process is signalled), the server shouldn't
     apply perform an unlock on the entire file, since that will also remove the
     previous lock that the client was already granted.
    
     Or consider a lock request that actually *downgraded* an exclusive lock to
     a shared lock.
    
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit f232142cc21127c829559923eb405d1bcb2e2278
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Tue Jan 3 09:55:42 2006 +0100

    NLM: Clean up nlmsvc_grant_reply locking
    
     Slightly simpler logic here makes it more trivial to verify that the up's
     and down's are balanced here.  Break out an assignment from a conditional
     while we're at it.
    
     Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fb459f45f7c7689714023d41b3dca999bb90a5d3
Author: Adrian Bunk <bunk@stusta.de>
Date:   Tue Jan 3 09:55:41 2006 +0100

    SUNRPC: net/sunrpc/xdr.c: remove xdr_decode_string()
    
     This patch removes ths unused function xdr_decode_string().
    
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Acked-by: Neil Brown <neilb@suse.de>
    Acked-by: Charles Lever <Charles.Lever@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a72b44222d222749d54b3e370d825094352e389f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:41 2006 +0100

    NFSv4: Allow user to set the port used by the NFSv4 callback channel
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a895b4a198dd06f8353328867e4f6cfd28b63081
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:40 2006 +0100

    NFS: Clean up weak cache consistency code
    
     ...and ensure that nfs_update_inode() respects wcc
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fa178f29c0f8a0dce748181a5351f4a92fd4f455
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:38 2006 +0100

    NFSv4: Ensure DELEGRETURN returns attributes
    
     Upon return of a write delegation, the server will almost always bump the
     change attribute. Ensure that we pick up that change so that we don't
     invalidate our data cache unnecessarily.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit beb2a5ec386e5ce6891ebd1c06b913da04354b40
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:37 2006 +0100

    NFSv4: Ensure change attribute returned by GETATTR callback conforms to spec
    
     According to RFC3530 we're supposed to cache the change attribute
     at the time the client receives a write delegation.
     If the inode is clean, a CB_GETATTR callback by the server to the
     client is supposed to return the cached change attribute.
     If, OTOH, the inode is dirty, the client should bump the cached
     change attribute by 1.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 969b7f2522c90dfed5d0d2553a91522bda2c3bf3
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:36 2006 +0100

    SUNRPC: Fix a potential race in rpc_pipefs.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 566dd6064e89b15ff2dec666a421bebf0f98f26c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:35 2006 +0100

    NFS: Make directIO aware of compound pages...
    
     ...and avoid calling set_page_dirty on them
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 70b9ecbdb9c5fdc731f8780bffd45d9519020c4a
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:34 2006 +0100

    NFS: Make stat() return updated mtimes after a write()
    
     The SuS states that a call to write() will cause mtime to be updated on
     the file. In order to satisfy that requirement, we need to flush out
     any cached writes in nfs_getattr().
     Speed things up slightly by not committing the writes.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 24174119c73983d5217da8f56a12c79a9b57e056
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:33 2006 +0100

    NFSv4: Ensure that we return the delegation on the target of a rename too.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 40859d7ee64ed6bfad8a4e93f9bb5c1074afadff
Author: Chuck Lever <cel@netapp.com>
Date:   Wed Nov 30 18:09:02 2005 -0500

    NFS: support large reads and writes on the wire
    
     Most NFS server implementations allow up to 64KB reads and writes on the
     wire.  The Solaris NFS server allows up to a megabyte, for instance.
    
     Now the Linux NFS client supports transfer sizes up to 1MB, too.  This will
     help reduce protocol and context switch overhead on read/write intensive NFS
     workloads, and support larger atomic read and write operations on servers
     that support them.
    
     Test-plan:
     Connectathon and iozone on mount point with wsize=rsize>32768 over TCP.
     Tests with NFS over UDP to verify the maximum RPC payload size cap.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 325cfed9ae901320e9234b18c21434b783dbe342
Author: Chuck Lever <cel@netapp.com>
Date:   Wed Nov 30 18:08:55 2005 -0500

    NFS: make "inode number mismatch" message more useful
    
     To help NFS users and server developers, make the "inode number mismatch"
     message display more useful information.
    
     Test-plan:
     None.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit dc20f803904dbf30f834dcc43c14701dfce32491
Author: Chuck Lever <cel@netapp.com>
Date:   Wed Nov 30 18:08:57 2005 -0500

    NFS: get rid of useless kernel log message
    
     nfs_statfs() generates a log message when GETATTR returns an error.  This
     is usually a useless message.  Make it a dprintk.
    
     Test plan:
     None
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a911fd9a6046200e439b4af172e8379c0942eec3
Author: Chuck Lever <cel@netapp.com>
Date:   Wed Nov 30 18:08:59 2005 -0500

    NFS: simplify inlined bit ops in nfs_page.h
    
     Minor cleanup:  inlined bit ops in nfs_page.h can be simpler.
    
     Test plan:
     Write-intensive workload against a server that requires COMMITs.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 6b59a75460eb9527145d7bd55068e5d32bee8a44
Author: Chuck Lever <cel@netapp.com>
Date:   Wed Nov 30 18:08:19 2005 -0500

    NFS: Fix error recovery code in fs/nfs/inode.c:__init_nfs()
    
     Red Hat found a problem in the error recovery logic in __init_nfs.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ce1a8e6796150233f5098100f70217521dc7c08f
Author: Chuck Lever <cel@netapp.com>
Date:   Wed Nov 30 18:08:17 2005 -0500

    NFS: use generic_write_checks() to sanity check direct writes
    
     Replace ad hoc write parameter sanity checking in nfs_file_direct_write()
     with a call to generic_write_checks().  This should make the proper checks
     modulo the O_LARGEFILE flag, and should catch NFSv2-specific limitations by
     virtue of i_sb->s_maxbytes.
    
     Test plan:
     Posix compliance testing with both NFSv2 and NFSv3.
    
     Signed-off-by: Chuck Lever <cel@netapp.com>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 286d7d6a0cb38d3d4316a1dfea9b0c0fc5a6455b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:26 2006 +0100

    NFSv4: Remove requirement for machine creds for the "setclientid" operation
    
     Use a cred from the nfs4_client->cl_state_owners list.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit b4454fe1a7cb76a248d0641c9d68a44a1b8d9a1f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:25 2006 +0100

    NFSv4: Remove requirement for machine creds for the "renew" operation
    
     In RFC3530, the RENEW operation is allowed to use either
    
     the same principal, RPC security flavour and (if RPCSEC_GSS), the same
      mechanism and service that was used for SETCLIENTID_CONFIRM
    
     OR
    
     Any principal, RPC security flavour and service combination that
     currently has an OPEN file on the server.
    
     Choose the latter since that doesn't require us to keep credentials for
     the same principal for the entire duration of the mount.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 58d9714a44a79bba9b414da3ffbf3c753dc5915f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:24 2006 +0100

    NFSv4: Send RENEW requests to the server only when we're holding state
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5043e900f5404c01864fbeb5826aa7de3981bbc1
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:23 2006 +0100

    NFS: Convert instances of kernel_thread() to kthread()
    
     Convert private implementations in NFSv4 state recovery and delegation
     code to use kthreads.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 433fbe4c8837e3cc2ba6a6374edf28737d01a2e9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:22 2006 +0100

    NFSv4: State recovery cleanup
    
     Use wait_on_bit() when waiting for state recovery to complete.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 26e976a884be9aa08f8ff906372f25f68df0d948
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:21 2006 +0100

    NFSv4: OPEN/LOCK/LOCKU/CLOSE will automatically renew the NFSv4 lease
    
     Cut down on the number of unnecessary RENEW requests on the wire.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 2bd615797ef32ec06ef0ee44198a7aecc21ffd8c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:19 2006 +0100

    SUNRPC: Ensure that SIGKILL will always terminate a synchronous RPC call.
    
     ...and make sure that the "intr" flag also enables SIGHUP and SIGTERM to
     interrupt RPC calls too (as per the Solaris implementation).
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fe650407a86823bcafbfbee96c7bc6a1b5cd1c76
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:18 2006 +0100

    NFSv4: Make DELEGRETURN an interruptible operation.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a5d16a4d090bd2af86e648ed9bb205903fcf1e86
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:17 2006 +0100

    NFSv4: Convert LOCK rpc call into an asynchronous RPC call
    
     In order to allow users to interrupt/cancel it.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 911d1aaf26fc4d771174d98fcab710a44e2a5fa0
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:16 2006 +0100

    NFSv4: locking XDR cleanup
    
     Get rid of some unnecessary intermediate structures
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 864472e9b8fa76ffaad17dfcb84d79e16df6828c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:15 2006 +0100

    NFSv4: Make open recovery track O_RDWR, O_RDONLY and O_WRONLY correctly
    
     When recovering from a delegation recall or a network partition, we need
     to replay open(O_RDWR), open(O_RDONLY) and open(O_WRONLY) separately.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e761692381f294ea079d2e869fcd7c0afc79e394
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:13 2006 +0100

    NFSv4: Make nfs4_state track O_RDWR, O_RDONLY and O_WRONLY separately
    
     A closer reading of RFC3530 reveals that OPEN_DOWNGRADE must always
     specify a access modes that have been the argument of a previous OPEN
     operation.
     IOW: doing OPEN(O_RDWR) and then OPEN_DOWNGRADE(O_WRONLY) is forbidden
     unless the user called OPEN(O_WRONLY)
    
     In order to fix that, we really need to track the three possible open
     states separately.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cdd4e68b5f0ed12c64b3e2be83655d2a47588a74
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:12 2006 +0100

    NFSv4: Make open_confirm() asynchronous too
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 24ac23ab88df5b21b5b2df8cde748bf99b289099
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:11 2006 +0100

    NFSv4: Convert open() into an asynchronous RPC call
    
     OPEN is a stateful operation, so we must ensure that it always
     completes. In order to allow users to interrupt the operation,
     we need to make the RPC call asynchronous, and then wait on
     completion (or cancel).
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e60859ac0e50f660d23b72e42e05f58757dcfeff
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:10 2006 +0100

    SUNRPC: rpc_execute should not return task->tk_status;
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 89991c24e48b76f40aa3bd8c40c1e87c75d10a33
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:09 2006 +0100

    SUNRPC: Get rid of some unused exports
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e56e0b78eb1097a8e06512b9ed4be94d7538e7ac
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:08 2006 +0100

    NFSv4: Allocate OPEN call RPC arguments using kmalloc()
    
     Cleanup in preparation for making OPEN calls interruptible by the user.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 06f814a3ad0ddfe19e6e4f44e3da5d490547faf3
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:07 2006 +0100

    NFSv4: Make locku use the new RPC "wait on completion" interface.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 44c288732fdbd7e38460d156a40d29590bf93bce
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:06 2006 +0100

    NFSv4: stateful NFSv4 RPC call interface
    
     The NFSv4 model requires us to complete all RPC calls that might
     establish state on the server whether or not the user wants to
     interrupt it. We may also need to schedule new work (including
     new RPC calls) in order to cancel the new state.
    
     The asynchronous RPC model will allow us to ensure that RPC calls
     always complete, but in order to allow for "synchronous" RPC, we
     want to add the ability to wait for completion.
     The waits are, of course, interruptible.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 4ce70ada1ff1d0b80916ec9ec5764ce44a50a54f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:05 2006 +0100

    SUNRPC: Further cleanups
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 963d8fe53339128ee46a7701f2e36305f0ccff8c
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:04 2006 +0100

    RPC: Clean up RPC task structure
    
     Shrink the RPC task structure. Instead of storing separate pointers
     for task->tk_exit and task->tk_release, put them in a structure.
    
     Also pass the user data pointer as a parameter instead of passing it via
     task->tk_calldata. This enables us to nest callbacks.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit abbcf28f23d53e8ec56a91f3528743913fa2694a
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:03 2006 +0100

    SUNRPC: Yet more RPC cleanups
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit abd3e641d5ef9f836ab2f2b04d80b8619b051531
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Jan 3 09:55:02 2006 +0100

    NFS: Work correctly with single-page ->writepage() calls
    
     Ensure that we always initiate flushing of data before we exit
     a single-page ->writepage() call.
    
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 22905f775dd6a8b73be99826dcad07ceec00244b
Author: Andrew Morton <akpm@osdl.org>
Date:   Wed Nov 16 15:07:01 2005 -0800

    identify multipage ->writepages() calls
    
     NFS needs to be able to distinguish between single-page ->writepage() calls and
     multipage ->writepages() calls.
    
     For the single-page writepage calls NFS can kick off the I/O within the
     context of ->writepage().
    
     For multipage ->writepages calls, nfs_writepage() will leave the I/O pending
     and nfs_writepages() will kick off the I/O when it all has been queued up
     within NFS.
    
     Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>



