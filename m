Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCWMk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCWMk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVCWMk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:40:29 -0500
Received: from mx04.cybersurf.com ([209.197.145.108]:17807 "EHLO
	mx04.cybersurf.com") by vger.kernel.org with ESMTP id S261575AbVCWMkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:40:24 -0500
Subject: Re: memory leak in net/sched/ipt.c?
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Yichen Xie <yxie@cs.stanford.edu>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>,
       kaber@trash.net
In-Reply-To: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1111581618.1088.72.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2005 07:40:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 06:30, Herbert Xu wrote:
> Yichen Xie <yxie@cs.stanford.edu> wrote:
> > Is the memory block allocated on line 315 leaked every time tcp_ipt_dump 
> > is called?
> 
> It seems to be.  This patch should free it.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> BTW, please report networking bugs to netdev@oss.sgi.com.
> 

Thanks for pointing this out - I _know_ its in the kernel list FAQ.
I was sitting beside R Gooch when he added "thou shalt post to netdev".
And of course i am gonna bitch about it every time someone doesnt
post to netdev;-> 

Just a small correction to patchlet:
The second kfree should check for existence of t.

cheers,
jamal

> Thanks,

