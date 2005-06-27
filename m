Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVF0IQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVF0IQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVF0IQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:16:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261910AbVF0IQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:16:11 -0400
Date: Mon, 27 Jun 2005 01:15:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
Message-Id: <20050627011539.28793896.akpm@osdl.org>
In-Reply-To: <42BFB287.5060104@yahoo.com.au>
References: <42BF9CD1.2030102@yahoo.com.au>
	<20050627004624.53f0415e.akpm@osdl.org>
	<42BFB287.5060104@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Also, the memory usage regression cases that fault ahead brings makes it
>  a bit contentious.

faultahead consumes no more memory: if the page is present then point a pte
at it.  It'll make reclaim work a bit harder in some situations.

>  I like that the lockless patch completely removes the problem at its
>  source and even makes the serial path lighter. The other things is, the
>  speculative get_page may be useful for more code than just pagecache
>  lookups. But it is fairly tricky I'll give you that.

Yes, it's scary-looking stuff.

>  Anyway it is obviously not something that can go in tomorrow. At the
>  very least the PageReserved patches need to go in first, and even they
>  will need a lot of testing out of tree.
> 
>  Perhaps it can be discussed at KS and we can think about what to do with
>  it after that - that kind of time frame. No rush.
> 
>  Oh yeah, and obviously it would be nice if it provided real improvements
>  on real workloads too ;)

umm, yes.
