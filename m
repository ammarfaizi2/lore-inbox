Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUHAHgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUHAHgl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 03:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUHAHgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 03:36:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:23998 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265288AbUHAHfr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 03:35:47 -0400
Date: Sun, 1 Aug 2004 13:15:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Concurrent O_SYNC write speedups using radix-tree walks
Message-ID: <20040801074518.GA7310@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patches (generated against 2.6.8-rc2) enable concurrent 
O_SYNC writers to different parts of the same file by avoiding 
serialising on i_sem across the wait for IO completion.

This is mostly your work, ported to the tagged radix tree VFS changes
and a few fixes. I have been carrying these patches for sometime now; 
they can be the merged upstream. Please apply.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

