Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTK0JUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 04:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTK0JUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 04:20:51 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:23816 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264462AbTK0JUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 04:20:50 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bruce@perens.com (Bruce Perens), linux-kernel@vger.kernel.org
Subject: Re: Signal left blocked after signal handler.
Organization: Core
In-Reply-To: <20031126173953.GA3534@perens.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.2-20031002 ("Berneray") (UNIX) (Linux/2.4.22-1-686-smp (i686))
Message-Id: <E1APIKE-0002GV-00@gondolin.me.apana.org.au>
Date: Thu, 27 Nov 2003 20:20:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Perens <bruce@perens.com> wrote:
> 
> Test program attached below.

I don't know about your other problems, but your code is buggy.

>        if ( sigsetjmp(sjbuf, 0) == 0 ) {

For sigsetjmp to be useful, you need to call it with a nonzero
value in the second argument.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
