Return-Path: <linux-kernel-owner+w=401wt.eu-S1762269AbWLJRfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762269AbWLJRfD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762276AbWLJRfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:35:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38697 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762269AbWLJRfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:35:01 -0500
Subject: Re: [PATCH] include/linux/freezer.h needs PF_FREEZE and PF_FROZEN
	declarations
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612100623560.8221@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.64.0612100623560.8221@lancer.cnet.absolutedigital.net>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 11:34:54 -0600
Message-Id: <1165772094.14669.9.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-10 at 06:37 -0500, Cal Peake wrote:
> JFS (modular, if it matters) fails to build with this error:
> 
>   In file included from fs/jfs/jfs_txnmgr.c:49:
>   include/linux/freezer.h: In function `frozen':
>   include/linux/freezer.h:9: error: dereferencing pointer to incomplete type
>   include/linux/freezer.h:9: error: `PF_FROZEN' undeclared (first use in this function)
>   include/linux/freezer.h:9: error: (Each undeclared identifier is reported only once
>   include/linux/freezer.h:9: error: for each function it appears in.)
>   ...
> 
> 
> From: Cal Peake <cp@absolutedigital.net>
> 
> Include include/linux/sched.h in include/linux/freezer.h for PF_FREEZE and
> PF_FROZEN declarations.
> 
> Signed-off-by: Cal Peake <cp@absolutedigital.net>

Randy Dunlap has already submitted a patch to fix this:
http://marc.theaimsgroup.com/?l=linux-kernel&m=116555878318822&w=2

> 
> --- ./include/linux/freezer.h~orig	2006-12-07 22:33:46.000000000 -0500
> +++ ./include/linux/freezer.h	2006-12-10 06:15:11.000000000 -0500
> @@ -1,6 +1,9 @@
>  /* Freezer declarations */
> 
>  #ifdef CONFIG_PM
> +
> +#include <linux/sched.h>
> +
>  /*
>   * Check if a process has been frozen
>   */

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

