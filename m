Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVGQUqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVGQUqL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVGQUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:46:10 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:22792 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261394AbVGQUqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:46:08 -0400
Date: Mon, 18 Jul 2005 06:45:54 +1000
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@intercode.com.au
Subject: Re: 2.6.13rc3: crypto horribly broken on all 64bit archs
Message-ID: <20050717204554.GA23637@gondor.apana.org.au>
References: <42DA4D05.7000403@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DA4D05.7000403@domdv.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 02:20:21PM +0200, Andreas Steinmetz wrote:
> 
> The compiler first does ~((a)-1)) and then expands the unsigned int to
> unsigned long for the & operation. So we end up with only the lower 32
> bits of the address. Who did smoke what to do this? Patch attached.

Thanks for the patch Andreas.  A similar patch will be in the
mainline kernel as soon as everybody is back home from Canada.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
