Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSE0PuJ>; Mon, 27 May 2002 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSE0PuI>; Mon, 27 May 2002 11:50:08 -0400
Received: from holomorphy.com ([66.224.33.161]:47273 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316672AbSE0PuH>;
	Mon, 27 May 2002 11:50:07 -0400
Date: Mon, 27 May 2002 08:49:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Joseph Cordina <joseph.cordina@um.edu.mt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait queue process state
Message-ID: <20020527154950.GO14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joseph Cordina <joseph.cordina@um.edu.mt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CF2A0FB.8090507@um.edu.mt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 05:11:23PM -0400, Joseph Cordina wrote:
> The reason I am asking is that I am working on scheduler activations 
> which allow new kernel threads to be created when a kernel thread blocks 
> inside the kernel. Yet this only works for INTERRUPTIBLE processes, I 
> was thinking of making it work also for NONINTERRUPTIBLE processes. Just 
> wondering if this would have any repurcusions. Also when a process 
> generates a page fault which causes a page to be retreived from the 
> filesystem, it such a process placed in the wait queue as 
> NONINTERRUPTIBLE also ?

filemap_nopage() from mm/filemap.c does wait_on_page() or some variant
thereof (2.5 has wait_on_page_locked()) in several places, and it's
placed into the TASK_UNINTERRUPTIBLE state while doing so.

Cheers,
Bill
