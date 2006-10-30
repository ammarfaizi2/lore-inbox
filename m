Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWJ3OYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWJ3OYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWJ3OYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:24:50 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:62372 "EHLO
	extu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1751785AbWJ3OYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:24:43 -0500
X-AuditID: d80ac287-9ea02bb00000720f-a0-45460b2ad5d0 
Date: Mon, 30 Oct 2006 14:24:57 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
In-Reply-To: <4545C756.30403@innova-card.com>
Message-ID: <Pine.LNX.4.64.0610301419090.32176@blonde.wat.veritas.com>
References: <20061026174858.b7c5eab1.maxextreme@gmail.com>
 <20061026220703.37182521.akpm@osdl.org> <4545C756.30403@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 30 Oct 2006 14:24:42.0259 (UTC) FILETIME=[23E63630:01C6FC2F]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Franck Bui-Huu wrote:
> 
> Any idea why LDD3 states:
> 
> 	An interesting limitation of remap_pfn_range is that it gives
> 	access only to reserved pages and physical addresses above the
> 	top of physical memory.

It was true until 2.6.15, when VM_PFNMAP removed that restriction to
PageReserved (or struct-page-less) pages.

Hugh
