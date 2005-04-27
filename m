Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVD0NUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVD0NUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVD0NUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:20:54 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:19593 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261308AbVD0NUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:20:47 -0400
Message-ID: <426F91AB.3090600@yahoo.com.au>
Date: Wed, 27 Apr 2005 23:20:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [patch] fix the 2nd buffer race properly
References: <426F908C.2060804@yahoo.com.au>
In-Reply-To: <426F908C.2060804@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> The bug (the reason I asked you to drop the patch just now)
> was that the code previously did a get_bh on all bh's in a
> page, but I changed it to only put_bh the ones to be written.
> 
> The minor fix for that was to only get_bh the buffer heads to
> be written.
> 

Err, that wasn't very clear: my earlier patch to fix the problem
introduced the above bh leak, but was otherwise correct in that
it solved the underlying problem.

-- 
SUSE Labs, Novell Inc.

