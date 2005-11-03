Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbVKCTVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbVKCTVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVKCTVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:21:41 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:62983 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030449AbVKCTVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:21:40 -0500
Date: Thu, 3 Nov 2005 15:13:17 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Rob Landley <rob@landley.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Gerrit Huizenga <gh@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051103201317.GA8341@ccure.user-mode-linux.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511030007.34285.rob@landley.net> <4369BD7D.6050507@yahoo.com.au> <200511031154.11219.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511031154.11219.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 11:54:10AM -0600, Rob Landley wrote:
> Lots of work has gone into batching up syscalls and making as few of them as 
> possible because they are a performance bottleneck.  You want to introduce a 
> syscall for every single individual page of memory allocated or freed.
> 
> That's stupid.

I think what I'm optimizing is TLB flushes, not system calls.  With
mmap et al, they are effectively the same thing though.

				Jeff
