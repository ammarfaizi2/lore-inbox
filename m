Return-Path: <linux-kernel-owner+w=401wt.eu-S1751795AbXAOC4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXAOC4S (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbXAOC4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:56:18 -0500
Received: from rgminet02.oracle.com ([148.87.113.119]:28463 "EHLO
	rgminet02.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXAOC4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:56:17 -0500
Subject: Re: [PATCH] bonding: Replace kmalloc() + memset() pairs with the
	appropriate kzalloc() calls
From: joe jin <joe.jin@oracle.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <84144f020701112335v44bcf8a5see13fdbf01b700cd@mail.gmail.com>
References: <1168568903.10377.7.camel@joejin-pc.cn.oracle.com>
	 <84144f020701112335v44bcf8a5see13fdbf01b700cd@mail.gmail.com>
Content-Type: text/plain
Organization: Oracle
Date: Mon, 15 Jan 2007 10:49:30 +0800
Message-Id: <1168829370.6068.2.camel@joejin-pc.cn.oracle.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27.rhel4.6) 
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Joe,
> 
> On 1/12/07, joe jin <joe.jin@oracle.com> wrote:
> > @@ -788,7 +786,7 @@ static int rlb_initialize(struct bonding
> >
> >         spin_lock_init(&(bond_info->rx_hashtbl_lock));
> >
> > -       new_hashtbl = kmalloc(size, GFP_KERNEL);
> > +       new_hashtbl = kzalloc(size, GFP_KERNEL);
> >         if (!new_hashtbl) {
> >                 printk(KERN_ERR DRV_NAME
> >                        ": %s: Error: Failed to allocate RLB hash table\n",
> 
> You forgot to remove the memset here.

Here is not a memset :)

