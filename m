Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVEVH4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVEVH4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVEVH4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 03:56:39 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:48910 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261767AbVEVH4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 03:56:38 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jengelh@linux01.gwdg.de (Jan Engelhardt)
Subject: Re: route procfile problems
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <Pine.LNX.4.61.0505212105100.28358@yvahk01.tjqt.qr>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DZlK1-0005Js-00@gondolin.me.apana.org.au>
Date: Sun, 22 May 2005 17:56:29 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> The one that does not work is:
> 
>        while read line; echo $line; done </proc/net/route;
> 
> which only returns one line. Does anybody know what is causing this?

Well for me it return an error since you're missing a "do" before
the echo :)

However, with that addition I've tried a number of shells including
bash and they all work as expected.  So please do

strace -f sh -c 'while read line; do echo $line; done < /proc/net/route'

as that should give us the necessary clue.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
