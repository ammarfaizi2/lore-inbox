Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWHYPlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWHYPlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHYPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:41:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5899 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S964879AbWHYPlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:41:52 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Rik van Riel <riel@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 25 Aug 2006 17:37:09 +0200
Message-Id: <20060825153709.24254.28118.sendpatchset@twins>
Subject: [PATCH 0/6] Swap over NFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches implement swap files on NFS, but lay the foundation to
allow swap files on any non block device backed file.

As is, these patches allow for swapfiles to me used on NFS mounts. However
some extra work is needed to make this safe. It is not very hard to deadlock
a kernel with only these patches.

In the next VM deadlock avoidance series I will include a patch to remedy
this.
