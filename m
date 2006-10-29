Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWJ2L56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWJ2L56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 06:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWJ2L56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 06:57:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:27816 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932274AbWJ2L55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 06:57:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=q+wS//JxQjlIr5kGnYRVfYDDEoR5HMvx6QJTeGijylo4Oha/MBH/IT1740Ys7AswChoZQYTMzyOujdKl3h3g8BpoB9FYJzDbmiMTSB333rR3+JiWX5VdmDiV80yS0jHVFkOFS0V9hEYvdifvbvIigrVeTss/AA1zu7SXbLM4pq0=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18 forcedeth GSO panic on send
Date: Sun, 29 Oct 2006 13:55:56 +0100
User-Agent: KMail/1.8.2
Cc: Manfred Spraul <manfred@colorfullife.com>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <200610270117.57877.vda.linux@googlemail.com> <20061027035858.GA11129@gondor.apana.org.au>
In-Reply-To: <20061027035858.GA11129@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610291355.56196.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.

On Friday 27 October 2006 05:58, Herbert Xu wrote:
> > I am using an AMD64 box with 32bit userspace / 64bit kernel.
> > 
> > Kernels 2.6.18 and 2.6.18.1 semi-randomly hang when I upload stuff
> > over the net - for example, "svn commit", scp are affected.
> > 2.6.17.11 does not seem to be affected.
> > 
> > Unfortunately even 60-line screen is not big enough
> > to catch whole trace. There are at least two traces,
> > and first scrolls off. I have a photo at
> > http://busybox.net/~vda/gso_panic/forcedeth_gso_panic.jpg
> 
> Looks like a network stack bug rather than a driver problem.
> However, I'd really like to see the first oops including the
> print out from skb_over_panic.

With "echo 1 >/proc/sys/kernel/panic_on_oops" I've got
what you're requested. See screenshot:

http://busybox.net/~vda/gso_panic/forcedeth_gso_panic2.jpg

--
vda
