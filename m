Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVDEHfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDEHfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDEHfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:35:03 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:41613 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261603AbVDEHd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:33:56 -0400
Message-ID: <42523F5D.7020201@yahoo.com.au>
Date: Tue, 05 Apr 2005 17:33:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org>
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> +sched-remove-unnecessary-sched-domains.patch
> +sched-improve-pinned-task-handling-again.patch
[snip]
> 
>  CPU scheduler updates
> 

It is no problem that you picked these up for testing. But
don't merge them yet, please.

Suresh's underlying problem with the unnecessary sched domains
is a failing of sched-balance-exec and sched-balance-fork, which
I am working on now.

Removing unnecessary domains is a nice optimisation, but just
needs to account for a few more flags before declaring that a
domain is unnecessary (not to mention this probably breaks if
isolcpus= is used). I have made some modifications to the patch
to fix these problems.

Lastly, I'd like to be a bit less intrusive with pinned task
handling improvements. I think we can do this while still being
effective in preventing livelocks.

I will keep you posted with regards to the various scheduler
patches.

-- 
SUSE Labs, Novell Inc.

