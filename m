Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVKUUvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVKUUvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVKUUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:51:14 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:37648 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932358AbVKUUvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:51:13 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: cfriesen@nortel.com (Christopher Friesen)
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
       <kuznet@ms2.inr.ac.ru>
Organization: Core
In-Reply-To: <438220C3.4040602@nortel.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EeIcx-0006i3-00@gondolin.me.apana.org.au>
Date: Tue, 22 Nov 2005 07:51:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen <cfriesen@nortel.com> wrote:
> 
> When using netlink, should "nlmsg_pid" be set to pid (current->tgid) or 
> tid (current->pid)?

I tend to agree with you here that tgid makes more sense.  Dave, what
do you think?

However, you should never assume whatever value the kernel uses since
it may always choose an arbitrary value should the preferred pid/tgid
be taken by someone else.

So always use getsockname(2) to find out the correct address.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
