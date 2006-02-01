Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWBAGHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWBAGHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWBAGHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:07:18 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58574 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030408AbWBAGHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:07:17 -0500
Message-ID: <43E05031.2000107@t-online.de>
Date: Wed, 01 Feb 2006 07:07:45 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no,
       nfs@lists.sourceforge.net
Subject: [BUG] nfs version 2 broken
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XHeR18Zr8eSAhA634AaQvJCB8lsh0Gzdszzy9SNDED5So5vWxLe+cP@t-dialin.net
X-TOI-MSGID: 924c6a6b-afec-419b-99fb-adaadc08ca52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

The good news is that I finally succeeded to boot over network
using the PXE-bootrom / ip dhcp autoconfig / nfsroot method.
But "ip=dhcp root=/dev/nfs nfsroot=%s" is not the way to go
with recent kernels. This results in a kernel panic caused by
the inability to find root. Things go wrong immediately after
rpc port lookup:

 > NFS: Buggy server - nlink == 0!
 > nfs_fhget failed

Well, adding ",v3" to the nfsroot parameter helps, forcing the
client not to use the default nfs version 2 but nfs version 3.

All machines use kernel 2.6.15-git7.

cu,
 Knut
