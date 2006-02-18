Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWBROQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWBROQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 09:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBROQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 09:16:12 -0500
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:61578
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751255AbWBROQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 09:16:12 -0500
From: =?iso-8859-2?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Date: Sat, 18 Feb 2006 16:15:30 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Hellwig <hch@infradead.org>, netfilter-devel@lists.netfilter.org,
       fireflier-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       martinmaurer@gmx.at
References: <200602181410.59757.edwin.torok@level7.ro> <200602181447.31592.edwin@gurde.com> <1140268203.4698.7.camel@laptopd505.fenrus.org>
In-Reply-To: <1140268203.4698.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602181615.31004.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 15:10, Arjan van de Ven wrote:
> >  As a last resort, I'll try to maintain this as separate patch to be
> > applied to the kernel, but that is something I'd really try to avoid,
> > because:
>
> the problem is this: The export is going away for a reason and not "just
> because". 
I understand that, I didn't say there wasn't a reason for it going away.
> And that reason is that the implementation is going to be 
> radically redone such that this isn't possible anymore. At all.
Could you tell me on which thread is this reimplementation being discussed? 
I'd like to get a more clear picture of what exports I can use, and which 
ones I can't.

Is the sk_sleep field of struct socket going to remain? If yes what am I 
allowed to do with it inside ipt_owner.c?

Can you provide a function (in the new implementation) that at least gives me 
a list of pids that are going to be woken up by data being received on a 
socket? (for the moment it doesn't matter if that function will take some 
time to complete its job, it's still going to be faster, than doing all this 
from userspace). Then I could do the rest of the checking in userspace.

Or if that is not possible, could you tell me what kind of information am I 
going to be able to obtain from the wait_queue_t of the socket?

> No amount of patching can fix that ;)
That is why I started this thread in the first place. I want to implement the 
inode match in such a way that it will use only functions/structures it is 
supposed to, (and not some functions/structures that are going away).

Could you please help me, and tell me _how_  I can implement this, _without_ 
doing something that won't be possible in the (near) future. 

P.S.: This is my first attempt at modifying the kernel. If I ask something 
that is obvious, just point me where the documentation for that is, or to the 
thread where that has been already discussed.

Thanks,
Edwin

