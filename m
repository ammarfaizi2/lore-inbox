Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbUCUPHG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 10:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUCUPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 10:07:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263662AbUCUPHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 10:07:03 -0500
Date: Sun, 21 Mar 2004 10:08:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: Jouni Malinen <jkmaline@cc.hut.fi>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Crypto API and keyed non-HMAC digest algorithms / Michael MIC
In-Reply-To: <yqujr7vpiwmv.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0403211006190.16503-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Clay Haapala wrote:

> I've redone the crypto crc32c implementation to make use of Jouni's
> setkey() digest api.  So now crypto crc32c checksums are just another
> type of digest, rather than a new CRYPTO_ALG type.
> 
> This implementation is still a wrapper for the actual computation
> routine in lib/libcrc32c, per previous requests.  The patch below
> includes the code under lib and crypto.  It requires Jouni's previous
> patches to be applied, and was tested on 2.6.4 kernel source.
> 
> Let me know how it looks, especially if I should add further tests in
> tcrypt.

This looks fine, could you split it into two patches, one with the 
libcrc32c code and then one with the crypto algorithm?

Also, in the configuration help, "This implementation uses lib/crc32c"  
should be ""This implementation uses lib/libcrc32c".


- James
-- 
James Morris
<jmorris@redhat.com>


