Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163553AbWLGWtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163553AbWLGWtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163556AbWLGWtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:49:53 -0500
Received: from pat.uio.no ([129.240.10.15]:54128 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163553AbWLGWtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:49:51 -0500
Subject: Re: [GIT] Please pull the NFS client update for 2.6.19
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       nfsv4@linux-nfs.org
In-Reply-To: <1165455261.5744.71.camel@lade.trondhjem.org>
References: <1165424156.5744.10.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0612061713270.3542@woody.osdl.org>
	 <1165455261.5744.71.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8
Date: Thu, 07 Dec 2006 17:49:37 -0500
Message-Id: <1165531777.5648.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.547, required 12,
	autolearn=disabled, AWL 1.45, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 20:34 -0500, Trond Myklebust wrote:
> On Wed, 2006-12-06 at 17:16 -0800, Linus Torvalds wrote:
> > 
> > On Wed, 6 Dec 2006, Trond Myklebust wrote:
> > > 
> > >    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git
> > > 
> > > This will update the following files through the appended changesets.
> > 
> > Well, right now it conflicts with the workqueue cleanups. Can you fix up 
> > the conflicts and push again? Quite frankly, I could try, but since I 
> > don't even run NFS, I _really_ don't think you want me to do so.
> 
> OK. I'll fix it up and resend.

I've fixed up the conflicts with the workqueue stuff. It both compiles
and works for me. Please could you try pulling again.

Cheers,
  Trond

--------------------------------------------------------------------------
Hi Linus,

Please pull from the repository at

   git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git

This will update the following files through the appended changesets.

  Cheers,
    Trond

----
 fs/lockd/clntproc.c                    |    2 
 fs/lockd/svc4proc.c                    |    2 
 fs/lockd/svcproc.c                     |    2 
 fs/nfs/direct.c                        |    6 
 fs/nfs/file.c                          |   28 +
 fs/nfs/inode.c                         |    2 
 fs/nfs/internal.h                      |   18 +
 fs/nfs/nfs3proc.c                      |   52 --
 fs/nfs/nfs4proc.c                      |   99 ----
 fs/nfs/pagelist.c                      |   67 ++-
 fs/nfs/proc.c                          |   31 -
 fs/nfs/read.c                          |  179 ++++----
 fs/nfs/symlink.c                       |    2 
 fs/nfs/write.c                         |  598 +++++++++++++--------------
 include/linux/nfs_fs.h                 |   37 --
 include/linux/nfs_page.h               |    7 
 include/linux/nfs_xdr.h                |    2 
 include/linux/sunrpc/auth_gss.h        |    2 
 include/linux/sunrpc/clnt.h            |    1 
 include/linux/sunrpc/debug.h           |    6 
 include/linux/sunrpc/gss_krb5.h        |    6 
 include/linux/sunrpc/gss_spkm3.h       |   34 +-
 include/linux/sunrpc/sched.h           |   11 
 include/linux/sunrpc/xdr.h             |   23 +
 include/linux/sunrpc/xprt.h            |   37 --
 net/sunrpc/auth_gss/auth_gss.c         |   42 --
 net/sunrpc/auth_gss/gss_krb5_crypto.c  |  101 -----
 net/sunrpc/auth_gss/gss_krb5_mech.c    |   18 +
 net/sunrpc/auth_gss/gss_krb5_seal.c    |   55 +-
 net/sunrpc/auth_gss/gss_krb5_unseal.c  |   87 +---
 net/sunrpc/auth_gss/gss_krb5_wrap.c    |  153 ++-----
 net/sunrpc/auth_gss/gss_spkm3_mech.c   |  131 ++----
 net/sunrpc/auth_gss/gss_spkm3_seal.c   |  101 ++++-
 net/sunrpc/auth_gss/gss_spkm3_token.c  |    6 
 net/sunrpc/auth_gss/gss_spkm3_unseal.c |   92 ++--
 net/sunrpc/clnt.c                      |   70 ++-
 net/sunrpc/pmap_clnt.c                 |   13 -
 net/sunrpc/sched.c                     |  137 ++++--
 net/sunrpc/socklib.c                   |   18 -
 net/sunrpc/sunrpc_syms.c               |    5 
 net/sunrpc/sysctl.c                    |   50 --
 net/sunrpc/xdr.c                       |  255 +++++++----
 net/sunrpc/xprt.c                      |   33 -
 net/sunrpc/xprtsock.c                  |  716 ++++++++++++++++++++------------
 44 files changed, 1557 insertions(+), 1780 deletions(-)

commit 5847e1f4d058677c5e46dc6c3e3c70e8855ea3ba
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:36:14 2006 -0500

    SUNRPC: Remove pprintk() from net/sunrpc/xprt.c
    
    These appear to be deprecated.  Removing them also gets rid of some sparse
    noise.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c041b5ff8d50c432698d9bfbd68cc4b76c2ea5bc
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:36:03 2006 -0500

    NLM: fix print format for tk_pid
    
    The tk_pid field is an unsigned short.  The proper print format specifier for
    that type is %5u, not %4d.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fbf76683ff9d1462ec0b2f90ec6ea4793652318c
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:54 2006 -0500

    SUNRPC: relocate the creation of socket-specific tunables
    
    Clean-up:
    
    The RPC client currently creates some sysctls that are specific to the
    socket transport.  Move those entirely into xprtsock.c.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 282b32e17f64be2204f1ac96d7f40f92cb768cd7
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:51 2006 -0500

    SUNRPC: create stubs for xprtsock init and cleanup
    
    Over time we will want to add some specific init and cleanup logic for the
    xprtsock implementation.  Add stub routines for initialization and exit
    processing.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit dd4564715eae2c4136f278da9ae1c3bb5af3e509
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:44 2006 -0500

    SUNRPC: Rename skb_reader_t and friends
    
    Clean-up:  hch suggested that the RPC client shouldn't pollute the name
    space used by the generic skb manipulation routines in net/core/skbuff.c.
    
    Rename a couple of types in xdr.h to adhere to this convention.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9d29231690925915015c21c1fff73c7118099843
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:41 2006 -0500

    SUNRPC: skb_read_bits is the same as xs_tcp_copy_data
    
    Clean-up: eliminate xs_tcp_copy_data -- it's exactly the same logic as the
    common routine skb_read_bits.  The UDP and TCP socket read code now share
    the same routine for copying data into an xdr_buf.
    
    Now that skb_read_bits() is exported, rename it to avoid confusing it with
    a generic skb_* function.  As these functions are XDR-specific, they should
    not have names that suggest they are of generic use.  Also rename
    skb_read_and_csum_bits() to be consistent.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7559c7a28fbcaa0bca028eeebd5f251b09befe6b
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:37 2006 -0500

    SUNRPC: Make address format buffers more generic
    
    For now we will assume that all transports will use the address format
    buffers in the rpc_xprt struct to store their addresses.  Change
    rpc_peer2str() to be a generic routine to handle this, and get rid of the
    print_address() op in the rpc_xprt_ops vector.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 314dfd7987c71d7ba0c43ac3bf3d243c102ce025
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:34 2006 -0500

    SUNRPC: move saved socket callback functions to a private data structure
    
    Move the three fields for saving socket callback functions out of the
    rpc_xprt structure and into a private data structure maintained in
    net/sunrpc/xprtsock.c.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 7c6e066ec29290bf062f5bff2984bad9be5809c7
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:30 2006 -0500

    SUNRPC: Move the UDP socket bufsize parameters to a private data structure
    
    Move the socket-specific buffer size parameters for UDP sockets to a
    private data structure maintained in net/sunrpc/xprtsock.c.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c8475461829fd94f30208fbfa4eab7e5584c6495
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:26 2006 -0500

    SUNRPC: Move rpc_xprt socket connect fields into private data structure
    
    Move the socket-specific connection management fields out of the generic
    rpc_xprt structure into a private data structure maintained in
    net/sunrpc/xprtsock.c.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e136d0926ef6a048f6e65b35263c0a9faae3abbe
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:23 2006 -0500

    SUNRPC: Move TCP state flags into xprtsock.c
    
    Move "XPRT_LAST_FRAG" and friends from xprt.h into xprtsock.c, and rename
    them to use the naming scheme in use in xprtsock.c.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 51971139b2342fa1005e87bbfcb52305da3fe891
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:19 2006 -0500

    SUNRPC: Move TCP receive state variables into private data structure
    
    Move the TCP receive state variables from the generic rpc_xprt structure to
    a private structure maintained inside net/sunrpc/xprtsock.c.
    
    Also rename a function/variable pair to refer to RPC fragment headers
    instead of record markers, to be consistent with types defined in
    sunrpc/*.h.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ee0ac0c227c2a2b6dd1b33c23831100ee895dacf
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:15 2006 -0500

    SUNRPC: Remove sock and inet fields from rpc_xprt
    
    The "sock" and "inet" fields are socket-specific.  Move them to a private
    data structure maintained entirely within net/sunrpc/xprtsock.c
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ffc2e518c91942b7ed45fb0ab7deba1ba0c8594a
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Dec 5 16:35:11 2006 -0500

    SUNRPC: Allocate a private data area for socket-specific rpc_xprt fields
    
    When setting up a new transport instance, allocate enough memory for an
    rpc_xprt and a private area.  As part of the same memory allocation, it
    will be easy to find one, given a pointer to the other.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 94efa93435383b08d822a40f24ff6f6ce1a888df
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:42 2006 -0500

    rpcgss: krb5: miscellaneous cleanup
    
    Miscellaneous cosmetic fixes.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 717757ad1038ab6aacb89bad579c89b006efd913
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:41 2006 -0500

    rpcgss: krb5: ignore seed
    
    We're currently not actually using seed or seed_init.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit d922a84a8bf1d627810906d033223d4fa629fdbf
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:40 2006 -0500

    rpcgss: krb5: sanity check sealalg value in the downcall
    
    The sealalg is checked in several places, giving the impression it could be
    either SEAL_ALG_NONE or SEAL_ALG_DES.  But in fact SEAL_ALG_NONE seems to
    be sufficient only for making mic's, and all the contexts we get must be
    capable of wrapping as well.  So the sealalg must be SEAL_ALG_DES.  As
    with signalg, just check for the right value on the downcall and ignore it
    otherwise.  Similarly, tighten expectations for the sealalg on incoming
    tokens, in case we do support other values eventually.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 39a21dd1b0eec3f5eac84ee42bda5ab4915098ae
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:39 2006 -0500

    rpcgss: krb5: clean up some goto's, etc.
    
    Remove some unnecessary goto labels; clean up some return values; etc.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit ca54f896454852f0bc8d50e6e4c55d9defedbd0a
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:38 2006 -0500

    rpcgss: simplify make_checksum
    
    We're doing some pointless translation between krb5 constants and kernel
    crypto string names.
    
    Also clean up some related spkm3 code as necessary.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 2818bf81a8c91fb29634df68bdc3cc5e003201d0
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:37 2006 -0500

    rpcgss: krb5: kill checksum_type, miscellaneous small cleanup
    
    Previous changes reveal some obvious cruft.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 5eb064f93973def1ec2ab4a46929e94389a6283b
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:36 2006 -0500

    rpcgss: krb5: expect a constant signalg value
    
    We also only ever receive one value of the signalg, so let's not pretend
    otherwise
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e678e06bf8fa25981a6fa1f08b979fd086d713f8
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:35 2006 -0500

    gss: krb5: remove signalg and sealalg
    
    We designed the krb5 context import without completely understanding the
    context.  Now it's clear that there are a number of fields that we ignore,
    or that we depend on having one single value.
    
    In particular, we only support one value of signalg currently; so let's
    check the signalg field in the downcall (in case we decide there's
    something else we could support here eventually), but ignore it otherwise.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit adeb8133dd57f380e70a389a89a2ea3ae227f9e2
Author: Olga Kornievskaia <aglo@citi.umich.edu>
Date:   Mon Dec 4 20:22:34 2006 -0500

    rpc: spkm3 update
    
    This updates the spkm3 code to bring it up to date with our current
    understanding of the spkm3 spec.
    
    In doing so, we're changing the downcall format used by gssd in the spkm3 case,
    which will cause an incompatilibity with old userland spkm3 support.  Since the
    old code a) didn't implement the protocol correctly, and b) was never
    distributed except in the form of some experimental patches from the citi web
    site, we're assuming this is OK.
    
    We do detect the old downcall format and print warning (and fail).  We also
    include a version number in the new downcall format, to be used in the
    future in case any further change is required.
    
    In some more detail:
    
    	- fix integrity support
    	- removed dependency on NIDs. instead OIDs are used
    	- known OID values for algorithms added.
    	- fixed some context fields and types
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 37a4e6cb0391f2293ba3d59e3a63ec0e56ed720d
Author: Olga Kornievskaia <aglo@citi.umich.edu>
Date:   Mon Dec 4 20:22:33 2006 -0500

    rpc: move process_xdr_buf
    
    Since process_xdr_buf() is useful outside of the kerberos-specific code, we
    move it to net/sunrpc/xdr.c, export it, and rename it in keeping with xdr_*
    naming convention of xdr.c.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 87d918d667e51962938392759aef6ca368d6e96d
Author: J. Bruce Fields <bfields@fieldses.org>
Date:   Mon Dec 4 20:22:32 2006 -0500

    rpc: gss: fix a kmap_atomic race in krb5 code
    
    This code is never called from interrupt context; it's always run by either
    a user thread or rpciod.  So KM_SKB_SUNRPC_DATA is inappropriate here.
    
    Thanks to Aimé Le Rouzic for capturing an oops which showed the kernel
    taking an interrupt while we were in this piece of code, resulting in a
    nested kmap_atomic(.,KM_SKB_SUNRPC_DATA) call from
    xdr_partial_copy_from_skb().
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 8fc7500bb8ea3b5c909869d00628635e964ae882
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Mon Dec 4 20:22:31 2006 -0500

    rpc: gss: eliminate print_hexl()'s
    
    Dumping all this data to the logs is wasteful (even when debugging is turned
    off), and creates too much output to be useful when it's turned on.
    
    Fix a minor style bug or two while we're at it.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 2b577f1f14c8d83ba9400ec8accaf4a208f4f36a
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Thu Nov 16 15:03:38 2006 -0500

    SUNRPC: another pmap wakeup fix
    
    Don't wake up bind waiters if a task finds that another task is already
    trying to bind.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a18030445fd4dd20e2248007b5d1cf0b5d89c69d
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:45:19 2006 -0500

    NFS: Clean up calls to mark_inode_dirty() part 2
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 9cf85e0a243b56f4ef8439a1e6430307fd9dcda6
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:36:56 2006 -0500

    NFS: Fix up writeback_control->nr_to_write accounting
    
    We're really accounting for the same page twice now: once in
    generic_writepages(), and once in nfs_scan_dirty().
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 3925675cb37cc9c3fd1d3f56ce0fa729f995f863
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:36:09 2006 -0500

    NFS: Fix up the dirty page accounting
    
    There is now no reason to account for the dirty pages in the NFS code,
    since the VM code will now do it for us via __set_page_dirty_nobuffers(),
    and set_page_writeback().
    
    We still need to keep the accounting of stable writes, though.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e507d9ebbb2d5db5948a6fb3c33f015d60708d19
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:42 2006 -0500

    NFS: Ensure the inode is marked as dirty if we break out of nfs_wb_all()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit fa8d8c5b77a2dc467b5365a5651710161b84f16d
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:42 2006 -0500

    NFS: Fix nfs_release_page
    
    invalidate_inode_pages2_range() will clear the PG_dirty bit before calling
    try_to_release_page().
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 61822ab5e3ed09fcfc49e37227b655202adf6130
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:42 2006 -0500

    NFS: Ensure we only call set_page_writeback() under the page lock
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e261f51f25b98c213e0b3d7f2109b117d714f69d
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:41 2006 -0500

    NFS: Make nfs_updatepage() mark the page as dirty.
    
    This will ensure that we can call set_page_writeback() from within
    nfs_writepage(), which is always called with the page lock set.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 4d770ccf4257b23a7ca2a85de1b1c22657b581d8
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:41 2006 -0500

    NFS: Ensure that nfs_wb_page() calls writepage when necessary.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1a54533ec8d92a5edae97ec6ae10023ee71c4b46
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:40 2006 -0500

    NFS: Add nfs_set_page_dirty()
    
    We will want to allow nfs_writepage() to distinguish between pages that
    have been marked as dirty by the VM, and those that have been marked as
    dirty by nfs_updatepage().
    In the former case, the entire page will want to be written out, and so any
    requests that were pending need to be flushed out first.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 200baa2112012dd8a13db9da3ee6885403f9c013
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:40 2006 -0500

    NFS: Remove nfs_writepage_sync()
    
    Maintaining two parallel ways of doing synchronous writes is rather
    pointless. This patch gets rid of the legacy nfs_writepage_sync(), and
    replaces it with the faster asynchronous writes.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e21195a740533348e77efa8a2e2cf03bb4092b2b
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:39 2006 -0500

    NFS: More cleanups of fs/nfs/write.c
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 87a4ce16082e92b4b6d27596a517b302f3692650
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:39 2006 -0500

    NFS: Remove call to igrab() from nfs_writepage()
    
    We always ensure that the nfs_open_context holds a reference to the dentry,
    so the test in nfs_writepage() for whether or not the inode is referenced
    is redundant.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 49a70f278658894d2899824cd4037095fb6711fe
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:38 2006 -0500

    NFS: Cleanup: add common helper nfs_page_length()
    
    Clean up a lot of ad-hoc page length calculations in fs/nfs/write.c
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 277459d2e2cd40594967757e8fd016c4c7016614
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Dec 5 00:35:35 2006 -0500

    NFS: Store pointer to the nfs_page in page->private
    
    This will allow fast lookup of the nfs_page from the struct page instead of
    having to search the radix tree.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1c75950b9a2254ef08f986e00ad20266ae9ba7f1
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Oct 9 16:18:38 2006 -0400

    NFS: cleanup of nfs_sync_inode_wait()
    
    Allow callers to directly pass it a struct writeback_control.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 3f442547b76bf9fb70d7aecc41cf1980459253c9
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Sun Sep 17 14:46:44 2006 -0400

    NFS: Clean up nfs_scan_dirty()
    
    Pass down struct writeback control.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 28c6925fce3927a9fe3c5b44af5fb266680fdcea
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Sat Sep 16 13:04:50 2006 -0400

    NFS: Clean up nfs_flush_inode()
    
    Make it take a struct writepages argument, and rename to
    nfs_flush_mapping().
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit c8541ecdd5692bcfbcb5305cab9a873288d29175
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Oct 17 14:44:27 2006 -0400

    SUNRPC: Make the transport-specific setup routine allocate rpc_xprt
    
    Change the location where the rpc_xprt structure is allocated so each
    transport implementation can allocate a private area from the same
    chunk of memory.
    
    Note also that xprt->ops->destroy, rather than xprt_destroy, is now
    responsible for freeing rpc_xprt when the transport is destroyed.
    
    Test plan:
    Connectathon.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e744cf2e3ab8535a8494a4cf0177de26f94586da
Author: Chuck Lever <chuck.lever@oracle.com>
Date:   Tue Oct 17 14:44:24 2006 -0400

    SUNRPC: minor optimization of "xid" field in rpc_xprt
    
    Move the xid field in the rpc_xprt structure to be in the same cache line
    as the reserve_lock, since these are used at the same time.
    
    Test plan:
    None.
    
    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 24c5684b65ff52ebfa942e8086d91a4966121ae7
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Oct 17 15:06:22 2006 -0400

    SUNRPC: Clean up xs_send_pages()
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit bee57c99c322d64407b80c8171958b4384902da4
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Oct 9 22:08:22 2006 -0400

    SUNRPC: Ensure xdr_buf_read_netobj() checks for memory overruns
    
    Also clean up the code...
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 4e3e43ad14c574281034a27420abf1993694ac11
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Oct 17 13:47:24 2006 -0400

    SUNRPC: Add __(read|write)_bytes_from_xdr_buf
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 1e78957e0a8f882df6a3660b62f9aae441f54891
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Aug 31 15:09:19 2006 -0400

    SUNRPC: Clean up argument types in xdr.c
    
    Converts various integer buffer offsets and sizes to unsigned integer.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit eb5f8545ffff98a11c6656d4d2106341ab69c57d
Author: Frank Filz <ffilzlnx@us.ibm.com>
Date:   Tue Oct 17 10:24:42 2006 -0700

    NFS: Remove use of the Big Kernel Lock around nfs calls to readlink
    
    Remove use of the Big Kernel Lock around indirect calls to
    nfs3_proc_readlink and nfs4_proc_readlink, both of which
    basically call rpc_call_sync.
    
    Signed-off-by: Frank Filz <ffilz@us.ibm.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cae823c4c089d2c7c2a90f39f20376ccd85f9893
Author: Frank Filz <ffilzlnx@us.ibm.com>
Date:   Tue Oct 17 10:24:38 2006 -0700

    NFS: Remove use of the Big Kernel Lock around calls to rpc_call_sync
    
    Remove use of the Big Kernel Lock around calls to rpc_call_sync.
    
    Signed-off-by: Frank Filz <ffilz@us.ibm.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit a99b71c9c43499bf2312c64f5c1d367aaf559dc4
Author: Frank Filz <ffilzlnx@us.ibm.com>
Date:   Tue Oct 17 10:24:36 2006 -0700

    NFS: Remove use of the Big Kernel Lock around calls to rpc_execute.
    
    Remove use of the Big Kernel Lock around calls to rpc_execute.
    
    Signed-off-by: Frank Filz <ffilz@us.ibm.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 6d5fcb5a52bfd00eab3ba2c7ca890823388436ae
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Oct 18 16:01:06 2006 -0400

    SUNRPC: Remove BKL around the RPC socket operations etc.
    
    All internal RPC client operations should no longer depend on the BKL,
    however lockd and NFS callbacks may still require it.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit bbd5a1f9fc9fad0f8725812d91c51b052e847de8
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Oct 18 16:01:05 2006 -0400

    SUNRPC: Fix up missing BKL in asynchronous RPC callback functions
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 3e32a5d99a467b9d4d416323c8c292479b4915e5
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Thu Nov 16 11:37:27 2006 -0500

    SUNRPC: Give cloned RPC clients their own rpc_pipefs directory
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 23bf85ba43650e4341672a6bc85aa3f2c02eb633
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Nov 21 10:40:23 2006 -0500

    SUNRPC: Handle the cases where rpc_alloc_iostats() fails
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e8e058e830f46a76f837522e5e2df46d4303111f
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Nov 15 17:31:56 2006 -0500

    NFS: Fix nfs_sync_inode_wait(FLUSH_INVALIDATE)
    
    Currently nfs_sync_inode_wait() will fail to loop correctly when we call
    nfs_sync_inode_wait with the FLUSH_INVALIDATE argument.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cf1308ff7829017dab0dbcc817c63dc9c212923e
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Sun Nov 19 16:44:52 2006 -0500

    NFS: Fix missing page_unlock() in nfs_readpage
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 0b67130149b006628389ff3e8f46be9957af98aa
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Tue Nov 14 16:12:23 2006 -0500

    NFS: Fix asynchronous read error handling
    
    We must always call ->read_done() before we truncate the page data, or
    decide to flag an error. The reasons are that
    	in NFSv2, ->read_done() is where the eof flag gets set.
    	in NFSv3/v4 ->read_done() handles EJUKEBOX-type errors, and
    		  v4 state recovery.
    
    However, we need to mark the pages as uptodate before we deal with short
    read errors, since we may need to modify the nfs_read_data arguments.
    
    We therefore split the current nfs_readpage_result() into two parts:
    nfs_readpage_result(), which calls ->read_done() etc, and
    nfs_readpage_retry(), which subsequently handles short reads.
    
    Note: Removing the code that retries in case of a short read also fixes a
    bug in nfs_direct_read_result(), which used to return a corrupted number of
    bytes.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 46b9f8e1484352f09f229107ba2a758fe386d7f7
Author: Andy Ryan <genanr@allantgroup.com>
Date:   Tue Nov 7 14:36:26 2006 -0600

    NFS Exclusive open not supported bug
    
    When trying to open a file with the O_EXCL flag over NFS on a server that does
    not support exclusive mode, the file does not open.  The reason,
    rpc_call_sync returns a errno number, and not the nfs error number.  I fixed
    it by changing the status check in nfs3proc.c.  Either this is how it should
    be fixed, or rpc_call_sync should be fixed to return the NFS error.
    
    Signed-off-by: Andy Ryan <genanr@allantgroup.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit 8aca67f0ae2d8811165c22326825a645cc8e1b48
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Mon Nov 13 16:23:44 2006 -0500

    SUNRPC: Fix a potential race in rpc_wake_up_task()
    
    Use RCU to ensure that we can safely call rpc_finish_wakeup after we've
    called __rpc_do_wake_up_task. If not, there is a theoretical race, in which
    the rpc_task finishes executing, and gets freed first.
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit e6b3c4db6fbcd0d33720696f37790d6b8be12313
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Sat Nov 11 22:18:03 2006 -0500

    Fix a second potential rpc_wakeup race...
    
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

commit cc4dc59e5580d6c0de1685a25b74d32175f43434
Author: Christophe Saout <christophe@saout.de>
Date:   Sun Nov 5 18:42:48 2006 +0100

    Subject: Re: [PATCH] Fix SUNRPC wakeup/execute race condition
    
    The sunrpc scheduler contains a race condition that can let an RPC
    task end up being neither running nor on any wait queue. The race takes
    place between rpc_make_runnable (called from rpc_wake_up_task) and
    __rpc_execute under the following condition:
    
    First __rpc_execute calls tk_action which puts the task on some wait
    queue. The task is dequeued by another process before __rpc_execute
    continues its execution. While executing rpc_make_runnable exactly after
    setting the task `running' bit and before clearing the `queued' bit
    __rpc_execute picks up execution, clears `running' and subsequently
    both functions fall through, both under the false assumption somebody
    else took the job.
    
    Swapping rpc_test_and_set_running with rpc_clear_queued in
    rpc_make_runnable fixes that hole. This introduces another possible
    race condition that can be handled by checking for `queued' after
    setting the `running' bit.
    
    Bug noticed on a 4-way x86_64 system under XEN with an NFSv4 server
    on the same physical machine, apparently one of the few ways to hit
    this race condition at all.
    
    Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
    Cc: J. Bruce Fields <bfields@citi.umich.edu>
    Signed-off-by: Christophe Saout <christophe@saout.de>
    Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>



