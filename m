Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUEMLoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUEMLoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUEMLoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:44:17 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:4882 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S264132AbUEMLnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:43:08 -0400
Date: Thu, 13 May 2004 13:42:50 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES i586 optimized
Message-ID: <20040513114250.GB22233@ghanima.endorphin.org>
References: <20040513110110.GA8491@ghanima.endorphin.org>
	<20040513040732.75c5999c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513040732.75c5999c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085312570.422b@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 04:07:32AM -0700, Andrew Morton wrote:
> Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org> wrote:

> >  The following patch adds an i586 optimized implementation of AES aka
> >  Rijndael. It's following an integration strategy similiar to recent
> >  s390/z990 integration for DES/SHA1. aes-i586-glue.c, a glue layer for
> >  CryptoAPI, and aes-i586-asm.S, the actual implementation, are added to
> >  arch/i386/crypto, as well as a config section to crypto/Kconfig.
> 
> Some benchmark figures would be useful.  Cache-cold and cache-hot.

I posted this patch for the first time about 3/4 year ago. The first
response has been the same. Please have a look at

My first posting:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106321924724484&w=2
My original claim:
http://www.kerneli.org/pipermail/cryptoapi-devel/2003-August/000607.html
Jari Ruusu's posting:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106321682117697&w=2

I suspect the result to be similar for a P4 for example. I could do some P4
benchmarking.

> >  The code has been in use for half a year by myself and the loop-aes project
> >  for the last - I think - 2 years. I consider the implementation
> >  production-stable. Andrew, please consider applying.
> 
> James Morris <jmorris@redhat.com> is the crypto guy....

Ack. I'll try to get his opinion on this.

Regards, Clemens
