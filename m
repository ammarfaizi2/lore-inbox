Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVHGFkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVHGFkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 01:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVHGFkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 01:40:52 -0400
Received: from waste.org ([216.27.176.166]:17644 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751062AbVHGFkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 01:40:51 -0400
Date: Sat, 6 Aug 2005 22:40:30 -0700
From: Matt Mackall <mpm@selenic.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "David S. Miller" <davem@davemloft.net>, ak@suse.de, akpm@osdl.org,
       mingo@elte.hu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       sandos@home.se
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050807054030.GG8074@waste.org>
References: <1123287835.18332.110.camel@localhost.localdomain> <20050806015310.GA8074@waste.org> <1123295548.18332.126.camel@localhost.localdomain> <20050806.024636.28814830.davem@davemloft.net> <1123322240.18332.131.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123322240.18332.131.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 05:57:20AM -0400, Steven Rostedt wrote:
> On Sat, 2005-08-06 at 02:46 -0700, David S. Miller wrote:
> > Can you guys stop peeing your pants over this, put aside
> > your differences, and work on a mutually acceptable fix
> > for these bugs?
> > 
> > Much appreciated, thanks :-)
> 
> In my last email, I stated that this discussion seems to have
> demonstrated that the e1000 driver's netpoll is indeed broken, and needs
> to be fixed.  I submitted eariler a patch for this, but it's untested
> and someone who owns an e1000 needs to try it.

I've got your e1000 change in my queue and I'll try to test it
tomorrow (realized I've got e1000 in my laptop).
 
> As for all the netpoll issues, I'm satisfied with whatever you guys
> decide.  But I've seen lots of problems posted over the netpoll and
> e1000, where people send in patches that do everything but fix the
> e1000, and that's where I chimed in.

Andi's patch looks like it fixes a related but slightly different
problem. I'm working on a variant. And I'll try to make the skb
allocation code eventually give up too.

-- 
Mathematics is the supreme nostalgia of our time.
