Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUITHrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUITHrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 03:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUITHrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 03:47:14 -0400
Received: from peter.smtp.cz ([81.95.97.120]:60066 "EHLO out.smtp.cz")
	by vger.kernel.org with ESMTP id S266128AbUITHrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 03:47:12 -0400
Subject: Re: Minor IPSec bug + solution
From: Martin Bouzek <martin.bouzek@radas-atc.cz>
Reply-To: martin.bouzek@radas-atc.cz
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, davem@davemloft.net,
       netdev@oss.sgi.com
In-Reply-To: <20040917102720.GA14579@gondor.apana.org.au>
References: <E1C83f1-0002X7-00@gondolin.me.apana.org.au>
	 <1095413173.2708.106.camel@mabouzek>
	 <20040917102720.GA14579@gondor.apana.org.au>
Content-Type: text/plain
Organization: Radas, s.r.o.
Message-Id: <1095666589.2723.8.camel@mabouzek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Sep 2004 09:49:49 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-17 at 12:27, Herbert Xu wrote:
> On Fri, Sep 17, 2004 at 11:26:13AM +0200, Martin Bouzek wrote:
> >
> > > > function. For tunnels it returns 
> > > > 
> > > > tmpl->optional && !xfrm_state_addr_cmp(tmpl, x, family);
> > 
> > Well, I am not expierienced with the networking kernel code,
> > nevertheless I still think the check is not correct. 
> 
> If you change the && to ||, then an ESP tunnel SA marked as required
> can be matched by a simple IPIP SA with the same addresses.

Ok. And would it be possible to check the protocols too (eg.
tmpl->id.proto == x->id.proto)? If it is realy not possible to make the
IPComp/required tunnel to work, it would be nice to mention it in for
example the setkey man page. It could save quite lot of time to some
people. (like me :-) ).

