Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVCWMy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVCWMy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVCWMy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:54:58 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:40844 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261163AbVCWMy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:54:57 -0500
Date: Wed, 23 Mar 2005 13:55:16 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Yichen Xie <yxie@cs.stanford.edu>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>,
       kaber@trash.net
Subject: Re: memory leak in net/sched/ipt.c?
Message-ID: <20050323125516.GP3086@postel.suug.ch>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au> <1111581618.1088.72.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111581618.1088.72.camel@jzny.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal <1111581618.1088.72.camel@jzny.localdomain> 2005-03-23 07:40
> On Wed, 2005-03-23 at 06:30, Herbert Xu wrote:
> > Yichen Xie <yxie@cs.stanford.edu> wrote:
> > > Is the memory block allocated on line 315 leaked every time tcp_ipt_dump 
> > > is called?
> > 
> > It seems to be.  This patch should free it.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

> Just a small correction to patchlet:
> The second kfree should check for existence of t.

t is either valid or NULL so it's not a problem, unless you want
to create janitor work of course. ;->
