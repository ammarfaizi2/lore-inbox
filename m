Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVDMXOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDMXOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVDMXOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:14:06 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:5896 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261218AbVDMXNx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:13:53 -0400
Date: Thu, 14 Apr 2005 09:10:44 +1000
To: Andreas Steinmetz <ast@domdv.de>
Cc: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050413231044.GA31005@gondor.apana.org.au>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D9D50.9050507@domdv.de>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 12:29:36AM +0200, Andreas Steinmetz wrote:
>
> > Why is that? In the case of swap over dmcrypt, swsusp never reads/writes
> > the disk directly.  All operations are done through dmcrypt.
> > 
> > The user has to enter a password before the system can be resumed.
> 
> Think of it the following way: user suspend and later resumes. During
> suspend some mlocked memory e.g. from ssh-agent gets dumped to swap.
> Some days later the system gets broken in from a remote place.
> Unfortunately the ssh keys are still on swap (assuming that ssh-agent is
> not running then) and can be recovered by the intruder. The intruder can

The ssh keys are *encrypted* in the swap when dmcrypt is used.
When the swap runs over dmcrypt all writes including those from
swsusp are encrypted.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
