Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVIIOve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVIIOve (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIIOve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:51:34 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:25116 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751407AbVIIOve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:51:34 -0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in
 ntfs_malloc_nofs() and add _nofail() version.
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 09 Sep 2005 07:51:23 -0700
In-Reply-To: <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk> (Anton
 Altaparmakov's message of "Fri, 9 Sep 2005 10:19:52 +0100 (BST)")
Message-ID: <52ek7yi9as.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Sep 2005 14:51:25.0186 (UTC) FILETIME=[F3797620:01C5B54D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Anton> fs/ntfs/malloc.h::ntfs_malloc_nofs() to do the kmalloc()
    Anton> based allocations with __GFP_HIGHMEM, analogous to how the
    Anton> vmalloc() based allocations are done.

Does it make sense to pass __GFP_HIGHMEM to kmalloc()?  kmalloc() has
to return memory from lowmem, since it gives you an address from the
direct-mapped kernel area, so at best kmalloc() ignores this flag.

 - R.
