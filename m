Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTJAXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJAXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:38:27 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:53133 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262777AbTJAXiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:38:25 -0400
Date: Wed, 1 Oct 2003 16:38:15 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from 10/1 LSE Call
Message-ID: <20031001233815.GB29605@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@osdl.org>, Hanna Linder <hannal@us.ibm.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <37940000.1065035945@w-hlinder> <20031001162916.5fc2241b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001162916.5fc2241b.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 04:29:16PM -0700, Andrew Morton wrote:
> If you have a loop like:
> 
> 	char *buf;
> 
> 	for (lots) {
> 		read(fd, buf, size);
> 	}
> 
> the optimum value of `size' is small: as little as 8k.  Once `size' gets
> close to half the size of the L1 cache you end up pushing the memory at
> `buf' out of CPU cache all the time.

I've seen this too, not that Andrew needs me to back him up, but in many 
cases even 4k is big enough.  Linux has a very thin system call layer so
it is OK, good even, to use reasonable buffer sizes.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
