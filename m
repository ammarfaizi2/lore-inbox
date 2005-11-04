Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030489AbVKDHg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030489AbVKDHg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKDHgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:36:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030489AbVKDHgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:36:53 -0500
Date: Thu, 3 Nov 2005 23:36:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: pbadari@gmail.com, torvalds@osdl.org, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
       haveblue@us.ibm.com, mel@csn.ul.ie, mbligh@mbligh.org,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [patch] swapin rlimit
Message-Id: <20051103233628.12ed1eee.akpm@osdl.org>
In-Reply-To: <20051104072628.GA20108@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
	<20051103205202.4417acf4.akpm@osdl.org>
	<20051104072628.GA20108@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> * Andrew Morton <akpm@osdl.org> wrote:
> 
>  > Similarly, that SGI patch which was rejected 6-12 months ago to kill 
>  > off processes once they started swapping.  We thought that it could be 
>  > done from userspace, but we need a way for userspace to detect when a 
>  > task is being swapped on a per-task basis.
> 
>  wouldnt the clean solution here be a "swap ulimit"?

Well it's _a_ solution, but it's terribly specific.

How hard is it to read /proc/<pid>/nr_swapped_in_pages and if that's
non-zero, kill <pid>?
