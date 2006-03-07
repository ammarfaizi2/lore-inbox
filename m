Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWCGWim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWCGWim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWCGWim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:38:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964825AbWCGWil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:38:41 -0500
Message-ID: <440E0BBA.5060802@ce.jp.nec.com>
Date: Tue, 07 Mar 2006 17:39:54 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
References: <20060307021929.754329c9.akpm@osdl.org>	<200603072217.k27MH6IJ003533@turing-police.cc.vt.edu> <20060307143029.3149e6b6.akpm@osdl.org>
In-Reply-To: <20060307143029.3149e6b6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>[   17.600897] BUG: sleeping function called from invalid context at mm/slab.c:2751
>>[   17.625891] in_atomic():1, irqs_disabled():0
>>[   17.650461]  [<c0103aba>] show_trace+0xd/0xf
>>[   17.674759]  [<c0103b5b>] dump_stack+0x17/0x19
>>[   17.698533]  [<c010ff3c>] __might_sleep+0x86/0x90
>>[   17.722149]  [<c015155a>] kmem_cache_alloc+0x27/0x82
>>[   17.745520]  [<c015baf1>] bd_claim_by_kobject+0x77/0x1b1
...
> Jun'ishi-san, please ensure that they're tested with CONFIG_PREEMPT and all
> debug options turned on.

Oops, thank you for testing and reporting.
I'll make sure to test with CONFIG_PREEMPT.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
