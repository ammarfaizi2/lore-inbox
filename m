Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264995AbTFCNHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbTFCNHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:07:50 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:29638 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S264995AbTFCNHt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:07:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NFS] Disabling Symbolic Link Content Caching in NFS Client
Date: Tue, 3 Jun 2003 18:50:34 +0530
Message-ID: <2BB7146B38D9CA40B215AB3DAAE24C080BA622@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] Disabling Symbolic Link Content Caching in NFS Client
Thread-Index: AcMpUL9KhvUiL4HrTeav8XekvNAMkgAeeQIA
From: "Vivek Goyal" <vivek.goyal@wipro.com>
To: <trond.myklebust@fys.uio.no>, "Ion Badulescu" <ionut@badula.org>
Cc: <viro@math.psu.edu>, <davem@redhat.com>, <ezk@cs.sunysb.edu>,
       <indou.takao@jp.fujitsu.com>, <nfs@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, "Vivek Goyal" <vivek.goyal@wipro.com>
X-OriginalArrivalTime: 03 Jun 2003 13:20:34.0957 (UTC) FILETIME=[EA6FC3D0:01C329D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>> " " == Ion Badulescu <ionut@badula.org> writes:
>     >> 1. Make nfs_symlink_caching dynamically tunable using /proc and
>     >> sysctl interface.
>      > No. Do it on a per-mount basis, like the other OS's do.
> 
> As I said to Vivek in a private mail, it would be very nice to see
> if this could be done by replacing hlfsd with namespace groups.
> 
> Al Viro has already done all the VFS layer work, which should be ready
> and working in existing 2.4.20 and 2.5.x kernels. What is missing is
> userland support for doing a CLONE_NEWNS, and then mounting the user's
> home directory, mailspool,.... in the appropriate locations at login
> time.

Yes, this could be a better way to tackle hlfsd issues.

<snip from Trond's mail>

>I'm not overly keen on this proposal. IMHO we want to *maximize*
caching >rather than reduce it. This is particularly important as the
speed of >networks etc. starts to approach that of the PCI bus on the
server.

<end of snip>

You are right. But our idea is to provide an option to disable/enable
caching based on the nature of intended application.

With this, Linux will have enhanced flexibility in NFS client like other
operating systems. For example.

1. Solaris provides dynamically tunable parameter "nfs_do_symlink_cache"
for enabling/disabling symlink caching.

2. UNIX and IRIX provide 'symttl' mount option for enabling/disabling
symbolic link content caching in NFS client.

Kindly let me know your comments.

Regards,
Vivek

