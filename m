Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVK1QoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVK1QoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVK1QoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:44:08 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:50138 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751295AbVK1QoG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:44:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=umCvBf2CEWvBn/rWd5lyhLXYd5vPq7AZiRCO/51JLAGZ8kkae2YoA/9xgYg+m7H8KLSWQiQ5Qi9Eq5rXrDVx5782Fiqw1RSs56lEY78kl0Cy+px5ypM6tRmPFCPda/6Ww6AzNTyNn2a7Ty1A2Dja3OaAzzZSAUsAUed7fBikKkc=
Message-ID: <4807377b0511280844w5ab2cb95y9955a62c0efe2f9d@mail.gmail.com>
Date: Mon, 28 Nov 2005 08:44:05 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>, nipsy@bitgnome.net
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
In-Reply-To: <dmf1kn$t2s$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051128123601.GA32346@king.bitgnome.net>
	 <dmf1kn$t2s$1@news.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should really be on netdev, so I copied it.

On 11/28/05, Miquel van Smoorenburg <miquels@cistron.nl> wrote:
> In article <20051128123601.GA32346@king.bitgnome.net>,
> Mark Nipper  <nipsy@bitgnome.net> wrote:
> >        I received the following in my system logs recently:
> >---
> >Nov 27 22:56:20 king kernel: KERNEL: assertion (!sk->sk_forward_alloc)
> >failed at net/core/stream.c (279)
> >Nov 27 22:56:20 king kernel: KERNEL: assertion (!sk->sk_forward_alloc)
> >failed at net/ipv4/af_inet.c (151)
> >
> >        All I could find related to this was some potential bugs
> >mentioned in 2.6.9 and in particular with relation to TSO.
> >However, I'm running a vanilla 2.6.13.4 at the moment.  But, I do
> >have an e1000 and checking ethtool does show TSO on.
>
> I'm seeing the same on 2.6.14.2, also with e1000. It wasn't there on
> 2.6.11.12 which I was running previously.

I don't believe this is related to e1000 because we don't mess with
the sock (sk) struct.  Did you try disabling TSO?  I bet the netdev
guys can help.
