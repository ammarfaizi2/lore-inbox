Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWCGX7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWCGX7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWCGX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:59:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751687AbWCGX7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:59:48 -0500
Date: Tue, 7 Mar 2006 18:59:40 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: yet more slab corruption.
Message-ID: <20060307235940.GA16843@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Garg. Is there no end to these ?
That kernel is based off 2.6.16rc5-git8

This brings the current count up to 8 different patterns filed
against our 2.6.16rc tree in Fedora bugzilla.
(One of them doesn't count as it's against the out-of-tree bcm43xx driver).

		Dave

-- 
http://www.codemonkey.org.uk

--oyUTqETQ0mS9luUI
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <kernel-maint-admin@redhat.com>
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on 
	nwo.kernelslacker.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	NO_REAL_NAME autolearn=ham version=3.1.0
Received: from 172.16.58.1 [172.16.58.1]
	by nwo.kernelslacker.org with IMAP (fetchmail-6.3.2)
	for <davej@localhost> (single-drop); Tue, 07 Mar 2006 17:43:17 -0500 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k27Mh4n1005081;
	Tue, 7 Mar 2006 17:43:04 -0500
Received: from post-office.corp.redhat.com (post-office.corp.redhat.com [172.16.52.227])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k27Mh3104144;
	Tue, 7 Mar 2006 17:43:03 -0500
Received: from post-office.corp.redhat.com (localhost.localdomain [127.0.0.1])
	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k27Mh3t18041;
	Tue, 7 Mar 2006 17:43:03 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k27Mgwt17996
	for <kernel-maint@post-office.corp.redhat.com>; Tue, 7 Mar 2006 17:42:58 -0500
Received: from mx1.redhat.com (mx1.redhat.com [172.16.48.31])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k27Mgw104056
	for <kernel-maint@redhat.com>; Tue, 7 Mar 2006 17:42:58 -0500
Received: from www.beta.redhat.com (beta.redhat.com [172.16.48.203])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k27MgwWi020981
	for <kernel-maint@redhat.com>; Tue, 7 Mar 2006 17:42:58 -0500
Received: from www.beta.redhat.com (localhost.localdomain [127.0.0.1])
	by www.beta.redhat.com (8.12.11/8.12.10) with ESMTP id k27MbPh8019189
	for <kernel-maint@redhat.com>; Tue, 7 Mar 2006 17:37:25 -0500
Received: (from apache@localhost)
	by www.beta.redhat.com (8.12.11/8.12.11/Submit) id k27MbPtO019184;
	Tue, 7 Mar 2006 17:37:25 -0500
From: bugzilla@redhat.com
To: kernel-maint@redhat.com
Subject: [Bug 184310] New: Slab corruption in 2.6.15-1.2025_FC5smp
Content-type: text/plain; charset=utf-8
Message-ID: <bug-184310-176318@bugzilla.redhat.com>
X-Loop: bugzilla@redhat.com
X-BeenThere: bugzilla@redhat.com
X-Bugzilla-Product: Fedora Core
X-Bugzilla-Version: devel
X-Bugzilla-Component: kernel
X-Bugzilla-Comment: Public
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Changed-Fields: New
Sender: kernel-maint-admin@redhat.com
Errors-To: kernel-maint-admin@redhat.com
X-BeenThere: kernel-maint@redhat.com
X-Mailman-Version: 2.0.13
Precedence: bulk
List-Help: <mailto:kernel-maint-request@redhat.com?subject=help>
List-Post: <mailto:kernel-maint@redhat.com>
List-Subscribe: <http://post-office.corp.redhat.com/mailman/listinfo/kernel-maint>,
	<mailto:kernel-maint-request@redhat.com?subject=subscribe>
List-Id: <kernel-maint.redhat.com>
List-Unsubscribe: <http://post-office.corp.redhat.com/mailman/listinfo/kernel-maint>,
	<mailto:kernel-maint-request@redhat.com?subject=unsubscribe>
List-Archive: <http://post-office.corp.redhat.com/mailman/private/kernel-maint/>
Date: Tue, 7 Mar 2006 17:37:25 -0500

Please do not reply directly to this email. All additional
comments should be made in the comments box of this bug report.




https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184310

           Summary: Slab corruption in 2.6.15-1.2025_FC5smp
           Product: Fedora Core
           Version: devel
          Platform: i686
        OS/Version: Linux
            Status: NEW
          Severity: normal
          Priority: normal
         Component: kernel
        AssignedTo: kernel-maint@redhat.com
        ReportedBy: hongjiu.lu@intel.com
         QAContact: bbrock@redhat.com
                CC: wtogami@redhat.com


I am running 2.6.15-1.2025_FC5smp. When I was building gcc with the gcc source
tree on a NFS server running RHEL 4 U2, I got

Slab corruption: (Not tainted) start=c574aeb8, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02182d0>](release_mem+0xe6/0x1de)
 [<c01602a5>] check_poison_obj+0x6a/0x15d     [<c01603ba>]
cache_alloc_debugcheck_after+0x22/0xf9
 [<c02c26d5>] tcp_sendmsg+0x153/0x983     [<c0160bfa>]
__kmalloc_track_caller+0xb5/0xbf
 [<c02c26d5>] tcp_sendmsg+0x153/0x983     [<c029c5db>] __alloc_skb+0x4d/0xf2
 [<c02c26d5>] tcp_sendmsg+0x153/0x983     [<c02d980d>] inet_sendmsg+0x35/0x3f
 [<c02972da>] sock_sendmsg+0xd2/0xec     [<c013465b>]
autoremove_wake_function+0x0/0x2d
 [<c0298acb>] kernel_sendmsg+0x26/0x2c     [<f8c4fd26>]
xs_tcp_send_request+0x107/0x302 [sunrpc]
 [<f8c4f050>] xprt_transmit+0xd7/0x1c8 [sunrpc]     [<f8d386dc>]
nfs3_xdr_fhandle+0x0/0x21 [nfs]
 [<f8c4e1ba>] call_transmit+0x198/0x1cf [sunrpc]     [<f8c51dd7>]
__rpc_execute+0x7a/0x193 [sunrpc]
 [<f8c4d2e4>] rpc_call_sync+0x6b/0x91 [sunrpc]     [<f8d35f3d>]
nfs3_rpc_wrapper+0x1f/0x5b [nfs]
 [<f8d36939>] nfs3_proc_getattr+0x74/0x96 [nfs]     [<f8d2f1f7>]
__nfs_revalidate_inode+0x113/0x24e [nfs]
 [<c01780e5>] __d_lookup+0xbc/0xee     [<c02f5136>] _read_unlock_irq+0x5/0x7
 [<c014d5b6>] __do_page_cache_readahead+0x10f/0x212     [<f8d2b251>]
nfs_lookup_revalidate+0x18a/0x318 [nfs]
 [<c017837a>] dput+0x31/0x164     [<f8d2b2d3>] nfs_lookup_revalidate+0x20c/0x318
[nfs]
 [<c0160420>] cache_alloc_debugcheck_after+0x88/0xf9     [<c01d765c>]
vsnprintf+0x422/0x461
 [<f8c52a58>] rpcauth_lookup_credcache+0x153/0x1ef [sunrpc]     [<c01780e5>]
__d_lookup+0xbc/0xee
 [<c016fbd7>] do_lookup+0x11d/0x14d     [<c01716da>] __link_path_walk+0x834/0xc7d
 [<c017bfe2>] mntput_no_expire+0x11/0x6e     [<c0171afd>]
__link_path_walk+0xc57/0xc7d
 [<c0171b6c>] link_path_walk+0x49/0xbd     [<c0171f07>] do_path_lookup+0x1e3/0x248
 [<c01727bf>] __path_lookup_intent_open+0x42/0x72     [<c017283e>]
path_lookup_open+0xf/0x13
 [<c0172938>] open_namei+0x73/0x54c     [<c0162c1f>] do_filp_open+0x1c/0x31
 [<c0163ab8>] do_sys_open+0x3e/0xaa     [<c0103d81>] syscall_call+0x7/0xb
0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=c574a6ac, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c029c35c>](kfree_skbmem+0x8/0x63)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c574b6c4, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02182d0>](release_mem+0xe6/0x1de)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: (Not tainted) start=c574b6c4, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02182d0>](release_mem+0xe6/0x1de)
 [<c01602a5>] check_poison_obj+0x6a/0x15d     [<c0170dc4>] lookup_one_len+0x4b/0x59
 [<c01603ba>] cache_alloc_debugcheck_after+0x22/0xf9     [<c02181d5>]
alloc_tty_struct+0x10/0x25
 [<c0160510>] kmem_cache_alloc+0x7f/0x89     [<c02181d5>] alloc_tty_struct+0x10/0x25
 [<c02181d5>] alloc_tty_struct+0x10/0x25     [<c0218446>] init_dev+0x7e/0x47a
 [<c021ac1b>] ptmx_open+0xf8/0x1b6     [<c02f525b>] lock_kernel+0x25/0x34
 [<c016ba4e>] chrdev_open+0x104/0x148     [<c016b94a>] chrdev_open+0x0/0x148
 [<c0162aac>] __dentry_open+0xc7/0x1ab     [<c0162bf4>] nameidata_to_filp+0x19/0x28
 [<c0162c2e>] do_filp_open+0x2b/0x31     [<c0163ab8>] do_sys_open+0x3e/0xaa
 [<c0103d81>] syscall_call+0x7/0xb    <3>0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b ff ff ff ff
0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=c574aeb8, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c029c35c>](kfree_skbmem+0x8/0x63)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: (Not tainted) start=c574a6ac, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02182d0>](release_mem+0xe6/0x1de)
 [<c01602a5>] check_poison_obj+0x6a/0x15d
 [<c01603ba>] cache_alloc_debugcheck_after+0x22/0xf9     [<c02c26d5>]
tcp_sendmsg+0x153/0x983
 [<c0160bfa>] __kmalloc_track_caller+0xb5/0xbf     [<c02c26d5>]
tcp_sendmsg+0x153/0x983
 [<c029c5db>] __alloc_skb+0x4d/0xf2     [<c02c26d5>] tcp_sendmsg+0x153/0x983
 [<c02d980d>] inet_sendmsg+0x35/0x3f     [<c02972da>] sock_sendmsg+0xd2/0xec
 [<c013465b>] autoremove_wake_function+0x0/0x2d     [<c0298acb>]
kernel_sendmsg+0x26/0x2c
 [<f8c4fd26>] xs_tcp_send_request+0x107/0x302 [sunrpc]     [<f8c4f050>]
xprt_transmit+0xd7/0x1c8 [sunrpc]
 [<f8d38c69>] nfs3_xdr_diropargs+0x0/0x2e [nfs]     [<f8c4e1ba>]
call_transmit+0x198/0x1cf [sunrpc]
 [<f8c51dd7>] __rpc_execute+0x7a/0x193 [sunrpc]     [<f8c4d2e4>]
rpc_call_sync+0x6b/0x91 [sunrpc]
 [<f8d35f3d>] nfs3_rpc_wrapper+0x1f/0x5b [nfs]     [<f8d36a59>]
nfs3_proc_lookup+0xfe/0x1a6 [nfs]
 [<c01780e5>] __d_lookup+0xbc/0xee     [<c02f5136>] _read_unlock_irq+0x5/0x7
 [<c014d5b6>] __do_page_cache_readahead+0x10f/0x212     [<c017837a>] dput+0x31/0x164
 [<f8d2b822>] nfs_lookup+0x96/0x104 [nfs]     [<c0160420>]
cache_alloc_debugcheck_after+0x88/0xf9
 [<c01d765c>] vsnprintf+0x422/0x461     [<c0160459>]
cache_alloc_debugcheck_after+0xc1/0xf9
 [<c017816f>] d_alloc+0x1d/0x1c1     [<c0160510>] kmem_cache_alloc+0x7f/0x89
 [<c017816f>] d_alloc+0x1d/0x1c1     [<c0178307>] d_alloc+0x1b5/0x1c1
 [<c016fb6c>] do_lookup+0xb2/0x14d     [<c01716da>] __link_path_walk+0x834/0xc7d
[<c017837a>] dput+0x31/0x164     [<c0171b6c>] link_path_walk+0x49/0xbd
 [<c0171f07>] do_path_lookup+0x1e3/0x248     [<c0172661>] __user_walk_fd+0x29/0x3a
 [<c016c470>] vfs_stat_fd+0x15/0x3c     [<c016c524>] sys_stat64+0xf/0x23
 [<c02f5e9f>] do_page_fault+0x0/0x5e2     [<c0103d81>] syscall_call+0x7/0xb
0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c574aeb8, len=2048
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<c02181d5>](alloc_tty_struct+0x10/0x25)
000: 01 54 00 00 d4 a4 d5 f7 02 00 00 00 03 54 00 00
010: 7c 85 32 c0 00 00 00 00 01 00 00 00 4c b8 21 c0

-- 
Configure bugmail: https://bugzilla.redhat.com/bugzilla/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

--oyUTqETQ0mS9luUI--
