Return-Path: <linux-kernel-owner+w=401wt.eu-S1761181AbWLHVFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761181AbWLHVFs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761209AbWLHVFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:05:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36683 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761180AbWLHVFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:05:47 -0500
Date: Fri, 8 Dec 2006 13:01:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@ltc.vnet.ibm.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] freezer.h uses task_struct fields
Message-Id: <20061208130155.c6cf85e1.akpm@osdl.org>
In-Reply-To: <1165588271.8686.8.camel@kleikamp.austin.ibm.com>
References: <20061207221343.82271a53.randy.dunlap@oracle.com>
	<1165588271.8686.8.camel@kleikamp.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 08:31:11 -0600
Dave Kleikamp <shaggy@ltc.vnet.ibm.com> wrote:

> > include/linux/freezer.h: In function 'frozen_process':
> > include/linux/freezer.h:55: error: dereferencing pointer to incomplete type
> > include/linux/freezer.h:55: error: dereferencing pointer to incomplete type
> > include/linux/freezer.h:55: error: 'PF_FREEZE' undeclared (first use in this function)
> > include/linux/freezer.h:55: error: 'PF_FROZEN' undeclared (first use in this function)
> > fs/jfs/jfs_txnmgr.c: In function 'freezing':
> > include/linux/freezer.h:18: warning: control reaches end of non-void function
> > make[2]: *** [fs/jfs/jfs_txnmgr.o] Error 1
> 
> Defining CONFIG_SMP or CONFIG_PREEMPT masks this problem (at least in
> jfs), since smp_lock.h will include sched.h when CONFIG_LOCK_KERNEL is
> defined, and smp_lock.h happens to be included by jfs_txngmr.c before
> freezer.h.
> 
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

OK, thanks guys.  This is the sort of patch which I like to put
through a decent round of cross-compilation testing, so it's unlikely
to appear in mainline for 2-3 days.
