Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUFMITy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUFMITy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 04:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbUFMITy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 04:19:54 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:35593 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265015AbUFMITx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 04:19:53 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ncunningham@linuxmail.org (Nigel Cunningham)
Subject: Re: Fix memory leak in swsusp
Cc: akpm@osdl.org, herbert@gondor.apana.org.au, pavel@suse.cz,
       mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <40CB7EBD.2020109@linuxmail.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BZQ95-0006oU-00@gondolin.me.apana.org.au>
Date: Sun, 13 Jun 2004 18:15:15 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
> At some stage, you copy the page that contains the preempt count for the process that is doing the 
> suspending. If you use memcpy on a 3Dnow machine, the preempt count is incremented prior to doing 
> the copy of the page. Then, at resume time, it is one too high.

Nope, this function only copies the swsusp page data structure so
this is irrelevant.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
