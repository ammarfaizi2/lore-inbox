Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTEFEe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTEFEe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:34:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30948 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262357AbTEFEez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:34:55 -0400
Date: Mon, 05 May 2003 20:40:02 -0700 (PDT)
Message-Id: <20030505.204002.08338116.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: akpm@digeo.com, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030506040856.8B3712C36E@lists.samba.org>
References: <1052187119.983.5.camel@rth.ninka.net>
	<20030506040856.8B3712C36E@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Tue, 06 May 2003 14:08:27 +1000

   In message <1052187119.983.5.camel@rth.ninka.net> you write:
   > I think the fixed size pool is perfectly reasonable.
   
   Yes.  It's a tradeoff.  I think it's worth it at the moment (although
   I'll add a limited printk to __alloc_percpu if it fails).

I think you should BUG() if a module calls kmalloc_percpu() outside
of mod->init(), this is actually implementable.

Andrew's example with some module doing kmalloc_percpu() inside
of fops->open() is just rediculious.
