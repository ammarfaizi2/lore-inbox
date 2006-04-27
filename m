Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWD0CSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWD0CSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWD0CSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:18:36 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:48571 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964878AbWD0CSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:18:35 -0400
Date: Thu, 27 Apr 2006 11:19:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-Id: <20060427111937.deeed668.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060426185750.GM5002@suse.de>
References: <20060426135310.GB5083@suse.de>
	<20060426095511.0cc7a3f9.akpm@osdl.org>
	<20060426174235.GC5002@suse.de>
	<20060426185750.GM5002@suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 20:57:50 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Wed, Apr 26 2006, Jens Axboe wrote:
> > We can speedup the lookups with find_get_pages(). The test does 64k max,
> > so with luck we should be able to pull 16 pages in at the time. I'll try
> > and run such a test. But boy I wish find_get_pages_contig() was there
> > for that. I think I'd prefer adding that instead of coding that logic in
> > splice, it can get a little tricky.
> 
> Here's such a run, graphed with the other two. I'll redo the lockless
> side as well now, it's only fair to compare with that batching as well.
> 

Hi, thank you for interesting tests.

>From user's view, I want to see the comparison among 
- splice(file,/dev/null),
- mmap+madvise(file,WILLNEED)/write(/dev/null),
- read(file)/write(/dev/null)
in this 1-4 threads test. 

This will show when splice() can be used effectively.

Thanks,
-Kame

