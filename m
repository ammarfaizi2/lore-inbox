Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUJHCWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUJHCWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 22:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJHCSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 22:18:10 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:33541 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267415AbUJHCQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 22:16:26 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, rmk+lkml@arm.linux.org.uk,
       joern@wohnheim.fh-wedel.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200410070551.i975pJvx010290@turing-police.cc.vt.edu>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CFkHd-0007p5-00@gondolin.me.apana.org.au>
Date: Fri, 08 Oct 2004 12:15:01 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> The reason the rm/mknod isn't really safe is because if either of them
> generate an error message, they'll go wherever fd2 is pointing (which is
> the problem we're trying to solve, and a major bootstrap problem).

Just close them before you start:

exec <&- >&- 2>&-
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
