Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWEJKaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWEJKaS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWEJKaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:30:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:49029 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964896AbWEJKaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:30:17 -0400
Date: Wed, 10 May 2006 15:56:20 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: [PATCH][delayacct] Clean up coding style in taskstats interface (was Re: [updated] [Patch 5/8] taskstats interface)
Message-ID: <20060510102620.GF29432@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061829.GB22607@in.ibm.com> <20060504184011.GB6966@in.ibm.com> <20060508143139.2f1c7623.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508143139.2f1c7623.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:31:39PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > +
> > +	if ((rc = genl_register_ops(&family, &taskstats_ops)) < 0)
> > +		goto err;
> 
> 	rc = genl_register_ops(&family, &taskstats_ops);
> 	if (rc < 0)
> 		goto err;
> 
> please.

Sure, here you go Andrew

I have updated the coding style as per your suggestion

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs


Changelog

1. Split the complex if condition into
   a. function call
   b. check return status for error

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/taskstats.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/taskstats.c~taskstats-interface-coding-style-cleanup kernel/taskstats.c
--- linux-2.6.17-rc3/kernel/taskstats.c~taskstats-interface-coding-style-cleanup	2006-05-10 15:08:53.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/taskstats.c	2006-05-10 15:09:50.000000000 +0530
@@ -322,7 +322,8 @@ static int __init taskstats_init(void)
 		return rc;
 	family_registered = 1;
 
-	if ((rc = genl_register_ops(&family, &taskstats_ops)) < 0)
+	rc = genl_register_ops(&family, &taskstats_ops);
+	if (rc < 0)
 		goto err;
 
 	return 0;
_
