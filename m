Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUITLDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUITLDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUITLBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:01:00 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:4113 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266195AbUITK7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:59:39 -0400
Date: Mon, 20 Sep 2004 20:57:20 +1000
To: Martin Bouzek <martin.bouzek@radas-atc.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, davem@davemloft.net,
       netdev@oss.sgi.com
Subject: Re: Minor IPSec bug + solution
Message-ID: <20040920105720.GA14214@gondor.apana.org.au>
References: <E1C83f1-0002X7-00@gondolin.me.apana.org.au> <1095413173.2708.106.camel@mabouzek> <20040917102720.GA14579@gondor.apana.org.au> <1095666589.2723.8.camel@mabouzek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095666589.2723.8.camel@mabouzek>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 09:49:49AM +0200, Martin Bouzek wrote:
> 
> Ok. And would it be possible to check the protocols too (eg.
> tmpl->id.proto == x->id.proto)? If it is realy not possible to make the

Obviously not, since IPCOMP != IPIP.

> IPComp/required tunnel to work, it would be nice to mention it in for
> example the setkey man page. It could save quite lot of time to some
> people. (like me :-) ).

IPComp is the main reason why we have optional SAs at all.  So
IPComp/required definitely does not make sense.

As to the documentation of this issue, feel free to write something up
and send it to either the kernel maintainers or one of the user-space
projects.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
