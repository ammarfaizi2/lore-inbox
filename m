Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWC2HlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWC2HlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWC2HlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:41:04 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1762
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751154AbWC2HlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:41:03 -0500
Date: Tue, 28 Mar 2006 23:41:19 -0800 (PST)
Message-Id: <20060328.234119.24811924.davem@davemloft.net>
To: nipsy@bitgnome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/...
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060329060816.GB26340@king.bitgnome.net>
References: <20060329060816.GB26340@king.bitgnome.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Nipper <nipsy@bitgnome.net>
Date: Wed, 29 Mar 2006 00:08:16 -0600

>         Sorry, I forgot a subject last time.  Maybe this will get
> a response instead.
> 
>         I'm seeing these in my logcheck output:
> ---
> Mar 27 16:16:45 king kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (283)
> Mar 27 16:16:45 king kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (150)
> ---
> 
> I also saw this with 2.6.14.5.  I found references on LKML about
> this happening in 2.6.9 with regards to TSO and lowering
> tcp_tso_win_divisor.  I'm not lowering any values via sysctl
> (that I'm aware of anyway), so I'm not sure if I should worry
> about this.
> 
>         Just a heads up in case this is a real problem.

It's being discussed at the proper place, netdev@vger.kernel.org.

You have an e1000 card right?  A temporary workaround is to disable
TSO on that interface.
