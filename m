Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbUKBW0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbUKBW0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUKBW0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:26:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:63901 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262366AbUKBWZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:25:44 -0500
Date: Tue, 2 Nov 2004 14:29:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: andrea@novell.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-Id: <20041102142944.0be6f750.akpm@osdl.org>
In-Reply-To: <4188086F.8010005@us.ibm.com>
References: <4187FA6D.3070604@us.ibm.com>
	<20041102220720.GV3571@dualathlon.random>
	<4188086F.8010005@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> Andrea Arcangeli wrote:
> > Still I recommend investigating _why_ debug_pagealloc is violating the
> > API. It might not be necessary to wait for the pageattr universal
> > feature to make DEBUG_PAGEALLOC work safe.
> 
> OK, good to know.  But, for now, can we pull this out of -mm?  Or, at 
> least that BUG_ON()?  DEBUG_PAGEALLOC is an awfully powerful debugging 
> tool to just be removed like this.

If we make it a WARN_ON, will that cause a complete storm of output?
