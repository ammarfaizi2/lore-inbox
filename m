Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUIGFwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUIGFwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 01:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUIGFwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 01:52:44 -0400
Received: from [211.155.249.251] ([211.155.249.251]:62993 "EHLO
	nnt.neonetech.com") by vger.kernel.org with ESMTP id S267587AbUIGFwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 01:52:39 -0400
Date: Tue, 7 Sep 2004 13:52:34 +0800
From: "xuhaoz" <xuhaoz@neonetech.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: beginner met kernel BUG at slab.c 871
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-ID: <NNT6PcyfAWZdVbOnoPx00000024@nnt.neonetech.com>
X-OriginalArrivalTime: 07 Sep 2004 05:56:25.0437 (UTC) FILETIME=[68EE38D0:01C4949F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernelhi:

	I met a kernel BUG at slab.c , exactly at here:

			down(&cache_chain_sem);
			{
				struct list_head *p;
				list_for_each(p,&cache_chain){
					kmem_cache_t *pc=list_entry(p,kmem_cache_t,next);
					if(!strcmp(pc->name,name))
						BUG();
				}
			}
	I also print the pc->name and name to the terminal, the pc->name is files_cache, certainly the name is files_cache.
 
     the version is linux-2.4.19

	Would you please give some advice about the cause of the Kernel BUG?
	Maybe I haven't give you enough information, but I really don't know what message I should give, please tell me, 
	and I will post them .
	 Any suggestion will be appreciated.
	Thank you . 

