Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbVKDPYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbVKDPYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVKDPYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:24:05 -0500
Received: from dvhart.com ([64.146.134.43]:37810 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964937AbVKDPYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:24:03 -0500
Date: Fri, 04 Nov 2005 07:24:04 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: pbadari@gmail.com, torvalds@osdl.org, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
       haveblue@us.ibm.com, mel@csn.ul.ie, kravetz@us.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [patch] swapin rlimit
Message-ID: <325850000.1131117844@[10.10.2.4]>
In-Reply-To: <20051104080731.GB21321@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au> <200511030007.34285.rob@landley.net> <20051103163555.GA4174@ccure.user-mode-linux.org> <1131035000.24503.135.camel@localhost.localdomain> <20051103205202.4417acf4.akpm@osdl.org> <20051104072628.GA20108@elte.hu> <20051103233628.12ed1eee.akpm@osdl.org> <20051104080731.GB21321@elte.hu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> System instrumentation people are already complaining about how costly 
> /proc parsing is. If you have to get some nontrivial stat from all 
> threads in the system, and if Linux doesnt offer that counter or summary 
> by default, it gets pretty expensive.
> 
> One solution i can think of would be to make a binary representation of 
> /proc/<pid>/stats readonly-mmap-able. This would add a 4K page to every 
> task tracked that way, and stats updates would have to update this page 
> too - but it would make instrumentation of running apps really 
> unintrusive and scalable.

That would be awesome - the current methods we have are mostly crap. There
are some atomicity issues though. Plus when I suggested this 2 years ago,
everyone told me to piss off, but I'm not bitter ;-) Seriously, we do
need a fast communication mechanism.
 
M.

