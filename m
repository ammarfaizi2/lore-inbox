Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVJPHoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVJPHoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 03:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVJPHoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 03:44:20 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:9478 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751298AbVJPHoT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 03:44:19 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: davem@davemloft.net (David S. Miller)
Subject: Re: [PATCH] highest_possible_processor_id() has to be a macro
Cc: viro@ftp.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20051016.001649.94729039.davem@davemloft.net>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1ER3BD-0004aX-00@gondolin.me.apana.org.au>
Date: Sun, 16 Oct 2005 17:43:39 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
> 
> So ugly...
> 
> But, it's the best fix for now.
> 
> Longer term we might want to make an asm/cpumask.h that can
> help allow the platforms to cleanly say "well, mask X is
> equivalent to Y, so only instantiate X and define Y to X"
> which is all that these two platforms are trying to accomplish.

The other thing you could is have an inline function called
highest_processor_id (or perhaps last_cpu) that calculates the
biggest CPU ID for any map and then define highest_possible_processor_id
as a macro that just calls the function with the right arguments.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
