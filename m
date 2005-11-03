Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVKCCb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVKCCb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKCCb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:31:28 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:53774 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030272AbVKCCb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:31:27 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Kris Katterjohn" <kjak@users.sourceforge.net>
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Cc: herbert@gondor.apana.org.au, jschlst@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       acme@ghostprotocols.net, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <310a17ad00f84c389e64ae26656ce1a1.kjak@ispwest.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EXUsN-0006r9-00@gondolin.me.apana.org.au>
Date: Thu, 03 Nov 2005 13:30:51 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kris Katterjohn <kjak@ispwest.com> wrote:
> I wasn't actually changing it to add performance, but to make the code look
> cleaner. The new load_pointer() is virtually the same as having the seperate
> functions that are currently there, but the code, I think, is "better looking".
> If you look at the current net/core/filter.c and then my patched version, the
> steps are done in the exact same order and same way, but all in that one
> function.

You've just changed an out-of-line function (__load_pointer) into an
inlined function.  There may be a cost to that.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
