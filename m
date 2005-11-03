Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbVKCSu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbVKCSu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVKCSu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:50:57 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:26593
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030430AbVKCSu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:50:56 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Thu, 3 Nov 2005 12:49:27 -0600
User-Agent: KMail/1.8
Cc: Jeff Dike <jdike@addtoit.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Gerrit Huizenga <gh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <20051103163555.GA4174@ccure.user-mode-linux.org> <1131035000.24503.135.camel@localhost.localdomain>
In-Reply-To: <1131035000.24503.135.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031249.28072.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 10:23, Badari Pulavarty wrote:

> Yep. This is the exactly the issue other product groups normally raise
> on Linux. How do we measure memory pressure in linux ? Some of our
> software products want to grow or shrink their memory usage depending
> on the memory pressure in the system. Since most memory is used for
> cache, "free" really doesn't indicate anything -they are monitoring
> info in /proc/meminfo and swapping rates to "guess" on the memory
> pressure. They want a clear way of finding out "how badly" system
> is under memory pressure. (As a starting point, they want to find out
> out of "cached" memory - how much is really easily "reclaimable"
> under memory pressure - without swapping). I know this is kind of
> crazy, but interesting to think about :)

If we do ever get prezeroing, we'd want a tuneable to say how much memory 
should be spent on random page cache and how much should be prezeroed.  And 
large chunks of prezeroed memory lying around are what you'd think about 
handing back to the host OS...

Rob
