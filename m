Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266072AbUGJBtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUGJBtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUGJBtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:49:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:49421 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266072AbUGJBtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:49:21 -0400
Date: Sat, 10 Jul 2004 11:47:40 +1000
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Paul Jackson <pj@sgi.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       chrisw@osdl.org, sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mika@osdl.org, akpm@osdl.org, jmorris@redhat.com
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040710014740.GA11477@gondor.apana.org.au>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <20040709164919.6b6a077d.pj@sgi.com> <849F7707-D212-11D8-8B07-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849F7707-D212-11D8-8B07-000393ACC76E@mac.com>
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 09:43:18PM -0400, Kyle Moffett wrote:
>
> most clear?  These are all "logically" correct, for the most part, but
> as humans we have certain readability standards.

Nope, B is undefined.

> int some_function(int a, void *b, char *c, unsigned char d, int e);
> 
> A)	int res = some_function(0,0,0,0,0);
> B)	int res = some_function(NULL,NULL,NULL,NULL,NULL);
> C)	int res = some_function(0,NULL,NULL,'\0',0);
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
