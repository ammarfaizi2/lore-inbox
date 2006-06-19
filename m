Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWFSUkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWFSUkk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbWFSUkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:40:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:30593 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751163AbWFSUkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:40:40 -0400
Date: Mon, 19 Jun 2006 15:40:37 -0500
To: christoph@lameter.com, clg@fr.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: NFS crash in linux-2.6.17-rc6-mm2; patch testd and works good.
Message-ID: <20060619204037.GF9200@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I saw a crash in 2.6.17-rc6-mm2 in the NFS code, w/ stack trace 

                   c00000000007efac .dec_zone_page_state+0x4/0xb0
[c00000003321bb60] c0000000001790f8 .nfs_commit_done+0x1a8/0x1f0
[c00000003321bc00] c00000000042169c .rpc_exit_task+0x48/0x84
[c00000003321bc80] c0000000004219b8 .__rpc_execute+0xec/0x2ac
[c00000003321bd20] c00000000005f57c .run_workqueue+0xdc/0x168
[c00000003321bdc0] c00000000005ff30 .worker_thread+0x138/0x1a8
[c00000003321bee0] c0000000000643f0 .kthread+0x124/0x174
[c00000003321bf90] c00000000002260c .kernel_thread+0x4c/0x68

which was passed a NULL pointer. This was on PowerPC. 

It appears that the patch of Tue, 13 Jun 2006 14:13:36 -0700 (PDT)
from Christoph Lameter seems to fix the probelm for me, after
some light testing. 

That is, the patch posted at  http://lkml.org/lkml/2006/6/13/210

So -- thanks -- and please add the appropriate Signed-Off-bys to 
that patch and get it upstream!

--linas

