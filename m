Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267934AbUHFCrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267934AbUHFCrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268063AbUHFCrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:47:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267934AbUHFCr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:47:29 -0400
Date: Thu, 5 Aug 2004 22:47:12 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: Michal Ludvig <mludvig@suse.cz>, <cryptoapi@lists.logix.cz>,
       <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH]
In-Reply-To: <20040805194914.GC23994@certainkey.com>
Message-ID: <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Jean-Luc Cooke wrote:

> Would you be against a patch to cryptoapi to have access to a
> non-scatter-list set of calls?
> 
> I know a few people would like to see that , and I would also like to use
> some low-level:
> 
> crypto_digest_update_byte(struct digest_alg *digest,
>                           unsigned char *buf,
>                           unsigned int  nbytes);
> crypto_cipher_encrypt_byte(struct cipher_alg *cipher,
>                            unsigned char *dst,
>                            unsigned char *src,
>                            unsigned int  nbytes);
> 
> I'm in the middle of preparing for a paper and would like to get code running
> without scatterlists.

The idea of the scatterlist API is to encourage encryption at the page
level.  Can you demonstrate a compelling need for raw access to the
algorithms via the API?


- James
-- 
James Morris
<jmorris@redhat.com>


