Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVCWNcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVCWNcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVCWNcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:32:50 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:3755 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261443AbVCWNcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:32:45 -0500
Subject: Re: memory leak in net/sched/ipt.c?
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Yichen Xie <yxie@cs.stanford.edu>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>,
       kaber@trash.net
In-Reply-To: <20050323132332.GQ3086@postel.suug.ch>
References: <E1DE44X-0001QM-00@gondolin.me.apana.org.au>
	 <1111581618.1088.72.camel@jzny.localdomain>
	 <20050323125516.GP3086@postel.suug.ch>
	 <1111583497.1089.92.camel@jzny.localdomain>
	 <20050323132332.GQ3086@postel.suug.ch>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1111584760.1089.112.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 23 Mar 2005 08:32:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 08:23, Thomas Graf wrote:

> 
> kfree simply does nothing if it is given a null pointer so that
> goto rtattr_failure for t == NULL  is handled just fine without
> a check. I will never get used to this behaviour and policy as
> well though, it somewhat makes code less readable.
> 

I cant get used to it either; actually i dont think i would be able 
to stop my fingers ;-> 

> > didnt understand the janitor part.
> 
> It will probably be removed again by one of the regular 'remove
> unnecessary pre kfree checks' patchsets.
> 

Yes, already Jan Engelhardt <jengelh@linux01.gwdg.de> has made that
point - although he did not post to netdev!! ;->

So ignore my comment Herbert

cheers,
jamal

