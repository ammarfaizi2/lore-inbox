Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268262AbUIMPUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268262AbUIMPUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268227AbUIMPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:20:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61092 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267841AbUIMPTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:19:14 -0400
Date: Mon, 13 Sep 2004 08:18:41 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, colpatch@us.ibm.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
Message-Id: <20040913081841.6689d34c.pj@sgi.com>
In-Reply-To: <650660000.1095088173@[10.10.2.4]>
References: <20040913015003.5406abae.akpm@osdl.org>
	<650660000.1095088173@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> The NUMA one is either cpusets-big-numa-cpu-and-memory-placement.patch
> or create-nodemask_t.patch by the looks of it

The numa one, with the following errors:

  mm/mempolicy.c: In function `get_zonemask':
  mm/mempolicy.c:419: error: `maxnode' undeclared (first use in this function)

is due to fix-abi-in-set_mempolicy.patch.

See my fix on lkml:

  Subject: [PATCH] undo more numa maxnode confusions
  Date: Mon, 13 Sep 2004 05:58:48 -0700

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
