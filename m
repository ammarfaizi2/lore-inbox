Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265475AbTFSMzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbTFSMzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:55:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53977 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265475AbTFSMzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:55:04 -0400
Date: Thu, 19 Jun 2003 18:39:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: [patch 0/3] dentry->d_count fixes
Message-ID: <20030619130943.GI1204@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are few races regarding the use of dentry->d_count
at various places as pointed by Trond. I have audited these and
made following patches for the places which I think are problemetic.

1. d_invalidate-fix.patch 
   - fixes race between d_invalidate & lockless d_lookup

2. nfs_unlink-d_count-fix.patch 
   - fixes race with nfs_unlink()

3. hpfs-d_count-fix.patch 
   - fixes race with hpfs_unlink()

Thanks,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
