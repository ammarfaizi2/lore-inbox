Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUFFCLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUFFCLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 22:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUFFCLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 22:11:48 -0400
Received: from ozlabs.org ([203.10.76.45]:60579 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262766AbUFFCLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 22:11:46 -0400
Subject: Re: [PATCH] speedup flush_workqueue for singlethread_workqueue
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: anil.s.keshavamurthy@intel.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040604153018.00768aab.akpm@osdl.org>
References: <ORSMSX409uejPw8Zyai00000001@orsmsx409.amr.corp.intel.com>
	 <20040604153018.00768aab.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086487875.11456.23.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 12:11:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 08:30, Andrew Morton wrote:
> "Anil" <anil.s.keshavamurthy@intel.com> wrote:
> >
> > 	In the flush_workqueue function for a single_threaded_worqueue case the code seemed to loop the same cpu_workqueue_struct
> > for each_online_cpu's. The attached patch checks this condition and bails out of for loop there by speeding up the flush_workqueue
> > for a singlethreaded_workqueue.
> 
> 
> OK, thanks.  I think it's a bit clearer to do it as below.  I haven't
> tested it though.

Me neither, but agree.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

