Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319818AbSIMWpt>; Fri, 13 Sep 2002 18:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319819AbSIMWpr>; Fri, 13 Sep 2002 18:45:47 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:33777 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S319818AbSIMWpp>;
	Fri, 13 Sep 2002 18:45:45 -0400
Date: Sat, 14 Sep 2002 00:50:33 +0200
From: David Weinehall <tao@acc.umu.se>
To: "David S. Miller" <davem@redhat.com>
Cc: defouwj@purdue.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.0-2.5 bug in ip_options_compile
Message-ID: <20020913225033.GP2242@khan.acc.umu.se>
References: <20020913220838.GA1579@blorp.plorb.com> <20020913.151306.40776578.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020913.151306.40776578.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 03:13:06PM -0700, David S. Miller wrote:
>    From: Jeff DeFouw <defouwj@purdue.edu>
>    Date: Fri, 13 Sep 2002 17:08:38 -0500
> 
>    While reading about IP options, I found the IPOPT_END padding (cleaning)
>    in ip_options_compile (net/ipv4/ip_options.c) was not incrementing a
>    pointer.  There should be an optptr++ in the for end-of-block statement
>    to go along with the l--, otherwise it's just comparing the same byte
>    for each l.  Patch is against 2.4.19.  From the kernel source browser
>    this bug is also in 2.5.31, 2.2.21, and 2.0.39.
> 
> Thanks a lot for spotting this, I will add this
> to my 2.4.x and 2.5.x trees and merge upstream.

Thanks. Will be in 2.0.40-rc7.


Regards: David Weinehall
-- 
 /> David Weinehall <tao@acc.umu.se> /> Northern lights wander      <\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
