Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTGKUsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbTGKUqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:46:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51617 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266771AbTGKUqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:46:37 -0400
Date: Fri, 11 Jul 2003 13:49:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 907] New: Kernel oops with nfs3svc_decode_symlinkargs
Message-ID: <836090000.1057956577@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=907

           Summary: Kernel oops with nfs3svc_decode_symlinkargs
    Kernel Version: 2.5.75-bk1
            Status: NEW
          Severity: normal
             Owner: trond.myklebust@fys.uio.no
         Submitter: robbiew@us.ibm.com
                CC: sglass@us.ibm.com


Distribution:SuSE 8.0

Hardware Environment: Server from NFS testplan at http://ltp.sf.net/nfs

Software Environment: 
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
NFS-utils              1.0.3
No Modules Loaded

Problem Description: After starting the test scenario, the following kernel 
oops occurs on the server.
========================
Unable to handle kernel paging request at virtual address f45d0000
 printing eip:
c01c1383
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[nfs3svc_decode_symlinkargs+723/844]    Not tainted
EFLAGS: 00010206
EIP is at nfs3svc_decode_symlinkargs+0x2d3/0x34c
eax: f2764f3c   ebx: 00000000   ecx: f45d0000   edx: f44a5078
esi: f445c004   edi: 0000004e   ebp: f3b7df4c   esp: f3b7df30
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1211, threadinfo=f3b7c000 task=f44f6000)
Stack: f44f7014 f445c004 c04f93e8 f44a50fc f2764f3c 00000003 00000011 f3b7df6c 
       c01b536b f445c004 f45cf068 f44a5004 f44f7014 f445c0e0 f44a41d8 f3b7dfa4 
       c042d3ad f445c004 f44f7014 00164e2d 00164e2d f3b7c000 000001d4 00000003 
Call Trace:
 [nfsd_dispatch+127/409] nfsd_dispatch+0x7f/0x199
 [svc_process+973/1626] svc_process+0x3cd/0x65a
 [nfsd+492/864] nfsd+0x1ec/0x360
 [nfsd+0/864] nfsd+0x0/0x360
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

Code: 8a 11 84 d2 74 04 85 db 75 e6 85 ff 74 4b 85 db 75 39 8b 75 
========================

Steps to reproduce: Execute the test scenario from the NFS 2.5 Testplan.


