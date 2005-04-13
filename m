Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVDMVar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDMVar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 17:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDMVar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 17:30:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:52485 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261193AbVDMVal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 17:30:41 -0400
Date: Thu, 14 Apr 2005 07:27:31 +1000
To: Andreas Steinmetz <ast@domdv.de>
Cc: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050413212731.GA27091@gondor.apana.org.au>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D17B0.8070109@domdv.de>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 02:59:28PM +0200, Andreas Steinmetz wrote:
> Herbert Xu wrote:
> > What's wrong with using swap over dmcrypt + initramfs? People have
> > already used that to do encrypted swsusp.
> 
> Nothing. The problem is the fact that after resume there is then
> unencrypted(*) data on disk that should never have been there, e.g.
> dm-crypt keys, ssh keys, ...

Why is that? In the case of swap over dmcrypt, swsusp never reads/writes
the disk directly.  All operations are done through dmcrypt.

The user has to enter a password before the system can be resumed.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
