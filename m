Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285278AbRLFWhx>; Thu, 6 Dec 2001 17:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285269AbRLFWfh>; Thu, 6 Dec 2001 17:35:37 -0500
Received: from bitmover.com ([192.132.92.2]:57988 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285339AbRLFWfV>;
	Thu, 6 Dec 2001 17:35:21 -0500
Date: Thu, 6 Dec 2001 14:35:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
        phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206143516.P27589@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
	phillips@bonn-fries.net, davidel@xmailserver.org,
	rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com,
	riel@conectiva.com.br, lars.spam@nocrew.org, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206122116.H27589@work.bitmover.com> <E16C78o-0003LB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16C78o-0003LB-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 06, 2001 at 10:37:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 10:37:18PM +0000, Alan Cox wrote:
> >    problem.  Scheduler, networking, device drivers, everything.  That's
> >    thousands of locks and uncountable bugs, not to mention the impact on
> >    uniprocessor performance.
> 
> Most of my block drivers in Linux have one lock. The block queuing layer
> has one lock which is often the same lock.

Hooray!  That's great and that's the way I'd like to keep it.  Do you think
you can do that on a 64 way SMP?  Not much chance, right?

> > You tell me - which is easier, multithreading the networking stack to 
> > 64 way SMP or running 64 distinct networking stacks?
> 
> Which is easier. Managing 64 routers or managing 1 router ?

That's a red herring, there are not 64 routers in either picture, there
are 64 ethernet interfaces in both pictures.  So let me rephrase the
question: given 64 ethernets, 64 CPUs, on one machine, what's easier,
1 multithreaded networking stack or 64 independent networking stacks?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
