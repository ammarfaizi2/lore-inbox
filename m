Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUFSEvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUFSEvb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 00:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFSEvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 00:51:31 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:20231 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265817AbUFSEva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 00:51:30 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: albert@users.sf.net (Albert Cahalan)
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Cc: linux-kernel@vger.kernel.org, ak@suse.de, bcasavan@sgi.com
Organization: Core
In-Reply-To: <1087605785.8188.834.camel@cube>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BbXoj-0006t2-00@gondolin.me.apana.org.au>
Date: Sat, 19 Jun 2004 14:51:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> wrote:
>
>> Are you saying your top reads /proc/kallsyms on each redisplay? 
>> That sounds completely wrong - it should only read the file once
>> and cache it and then look the numbers it is reading from wchan
>> in the cache.
>>
>> Doing the cache in the kernel is the wrong place. This should be fixed
>> in user space.
> 
> No way, because:
> 
> 1. kernel modules may be loaded or unloaded at any time

We seem to have coped alright under 2.4.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
