Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWHDADk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWHDADk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWHDADk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:03:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12525 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030243AbWHDADj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:03:39 -0400
Subject: Re: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd
	handling fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 17:03:36 -0700
Message-Id: <1154649816.5925.36.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ioresouce handling code in memory hotplug allows not-aligned memory hot add.
> But when memmap and other memory structures are initialized, parameters
> should be aligned. (if not aligned, initialization of mem_map will do wrong,
> it assumes parameters are aligned.) This patch fix it.
> 
> And this patch allows ioresource collision check to handle -EEXIST.
>
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> 
>  mm/memory_hotplug.c |   23 ++++++++++++++++-------
>  1 files changed, 16 insertions(+), 7 deletions(-)

This code looks and boots fine for me with x86_64.

 
Acked-by: Keith Mannthey <kmannth@us.ibm.com>

