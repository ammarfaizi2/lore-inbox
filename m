Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUKOL4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUKOL4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 06:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUKOL4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 06:56:44 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:31354 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261571AbUKOLzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 06:55:12 -0500
Message-ID: <4198991C.6060203@yahoo.com.au>
Date: Mon, 15 Nov 2004 22:55:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.10-rc2
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, the -rc2 changes are almost as big as the -rc1 changes, and we should 
> now calm down, so I do not want to see anything but bug-fixes until 2.6.10 
> is released. Otherwise we'll never get there.
> 

I'd like to get included that patch to restore the buffer of memory
reserved for GFP_ATOMIC allocations (ie. the difference between GFP_KERNEL
and GFP_ATOMIC allocations).

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/mm-restore-atomic-buffer.patch

It is not actually a regression versus 2.6.9 (it is vs 2.6.8), although I
think it is responsible for the increased reports of page allocation failures.

It would be nice to let it have more testing in -mm first, but OTOH if we
_really_ want it in 2.6.10 it would make sense to merge it ASAP so it can get
wider testing.

Any feelings on the matter yet, Andrew? Or were you thinking it would be OK for
post 2.6.10?
