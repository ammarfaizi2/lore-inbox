Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUHETxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUHETxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUHETxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 15:53:31 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:7610 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S267926AbUHETx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 15:53:29 -0400
Date: Thu, 5 Aug 2004 15:49:14 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: Michal Ludvig <mludvig@suse.cz>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
Message-ID: <20040805194914.GC23994@certainkey.com>
References: <41123B7E.2060601@suse.cz> <Xine.LNX.4.44.0408051000130.17694-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408051000130.17694-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Would you be against a patch to cryptoapi to have access to a
non-scatter-list set of calls?

I know a few people would like to see that , and I would also like to use
some low-level:

crypto_digest_update_byte(struct digest_alg *digest,
                          unsigned char *buf,
                          unsigned int  nbytes);
crypto_cipher_encrypt_byte(struct cipher_alg *cipher,
                           unsigned char *dst,
                           unsigned char *src,
                           unsigned int  nbytes);

I'm in the middle of preparing for a paper and would like to get code running
without scatterlists.

Cheers,

JLC

On Thu, Aug 05, 2004 at 10:11:14AM -0400, James Morris wrote:
> On Thu, 5 Aug 2004, Michal Ludvig wrote:
> 
> > Hi James,
> > 
> > the aes-i586 patch recently added to BK breaks compilation of AES on
> > non-i586 platforms. Attached patch fixes it.
> 
> Thanks, the code is about to be dropped and replaced, so we need to
> remember to fix it then.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 
> 
> _______________________________________________
> 
> Subscription: http://lists.logix.cz/mailman/listinfo/cryptoapi
> List archive: http://lists.logix.cz/pipermail/cryptoapi
