Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUIHIWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUIHIWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268950AbUIHIWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:22:53 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:14857 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268947AbUIHIWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:22:51 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jmoyer@redhat.com
Subject: Re: netpoll trapped question
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <16701.60264.560942.236743@segfault.boston.redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1C4xil-0005yZ-00@gondolin.me.apana.org.au>
Date: Wed, 08 Sep 2004 18:22:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer <jmoyer@redhat.com> wrote:
> 
> mpm> Yes, true. But we're still in trouble if we have nic irq handler ->
> mpm> take private lock -> printk -> netconsole -> nic irq handler -> take
> mpm> private lock. See?
> 
> Okay, so that one has to be addressed on a per-driver basis.  There's no
> way for us to detect that situation.  And how do drivers address this?
> Simply don't printk inside the lock?  I think that's reasonable.

Why not queue the message whenever you're in IRQ context, and only
print when you are not?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
