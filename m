Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSFEMSV>; Wed, 5 Jun 2002 08:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSFEMSU>; Wed, 5 Jun 2002 08:18:20 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:34776 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314096AbSFEMSU>; Wed, 5 Jun 2002 08:18:20 -0400
Date: Wed, 5 Jun 2002 14:17:55 +0200
From: Andi Kleen <ak@muc.de>
To: Ian Collinson <icollinson@imerge.co.uk>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        Andi Kleen <ak@muc.de>, Mike Kravetz <kravetz@us.ibm.com>,
        linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: realtime scheduling problems with 2.4 linux kernel >= 2.4.10
Message-ID: <20020605141755.A1410@averell>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB09C99A@imgserv04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 01:53:06PM +0200, Ian Collinson wrote:

> 
> Are there any potentially negative consequences of this fix, apart from
> those already mentioned?

I don't think so. 

It could still fail when you install a prio=99, SCHED_FIFO process.

> I certainly vote for this feature being preserved, as it is extremely useful
> for debugging realtime priority apps.  FYI, we narrowed it down to breaking
> in either 2.4.10-pre11 or pre12. 

That was when the low latency console changes went in. Before that console
switches could interrupt scheduling for a long time, causing problems
for other realtime people. The change was to move the expensive parts
of the console switch to keventd.

-Andi
