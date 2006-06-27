Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWF0VjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWF0VjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161319AbWF0VjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:39:06 -0400
Received: from main.gmane.org ([80.91.229.2]:56239 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161318AbWF0VjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:39:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.17-mm3
Date: Tue, 27 Jun 2006 16:38:41 -0500
Organization: IBM
Message-ID: <pan.2006.06.27.21.38.38.491569@us.ibm.com>
References: <20060627015211.ce480da6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rchp4.rochester.ibm.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 01:52:11 -0700, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm3/

Got this oops on a ppc64 box while running the reaim test. There were lots
of fs/mount issues during boot, so if anyone thinks that is the problem,
then we can try to fix that up first.

 Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 NUMA 
Modules linked in:
NIP: C0000000000A311C LR: C0000000000A30D4 CTR: C0000000000A3024
REGS: c0000007725b38d0 TRAP: 0300   Not tainted  (2.6.17-mm3-autokern1)
MSR: 8000000000001032 <ME,IR,DR>  CR: 28224424  XER: 00000000
DAR: 000000077BCC6180, DSISR: 0000000040000000
TASK = c00000002fc74670[29812] 'cp' THREAD: c0000007725b0000 CPU: 2
GPR00: 0000000000000000 C0000007725B3B50 C00000000063B828 C00000001E303EC0 
GPR04: 0000000000000010 0000000000000000 0000000000000000 FFFFFFFFFFFFFFFD 
GPR08: 0000000000000001 0000000000000000 000000077BCC6180 0000000000000000 
GPR12: 0000000000000000 C00000000051FF80 0000000000000000 0000000000000001 
GPR16: 0000000000000000 0000000000000004 0000000000020000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 C0000007759F9D00 0000000000000000 
GPR24: 0000000000000E42 0000000000000000 000000000000474A C00000001E30F300 
GPR28: 0000000000000000 0000000000000000 C000000000537288 C00000001E303E80 
NIP [C0000000000A311C] .s_show+0xf8/0x364
LR [C0000000000A30D4] .s_show+0xb0/0x364
Call Trace:
[C0000007725B3B50] [C0000000000A3334] .s_show+0x310/0x364 (unreliable)
[C0000007725B3C20] [C0000000000D5E84] .seq_read+0x2f4/0x450
[C0000007725B3D00] [C0000000000AADF8] .vfs_read+0xe0/0x1b4
[C0000007725B3D90] [C0000000000AAFD4] .sys_read+0x54/0x98
[C0000007725B3E30] [C00000000000871C] syscall_exit+0x0/0x40
Instruction dump:
3b180001 7c004a78 79290020 7c0bfe70 7f5a4a14 7d600278 7c005850 54000ffe 
7c094038 2c090000 41820008 ebbe80b0 <e96a0000> 2fab0000 419e0008 7c005a2c 

-- 

Steve Fox
IBM Linux Technology Center


