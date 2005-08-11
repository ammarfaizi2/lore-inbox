Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVHKM2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVHKM2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVHKM2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:28:51 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:56774 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1030231AbVHKM2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:28:50 -0400
Date: Thu, 11 Aug 2005 22:28:35 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Olaf Hering <olh@suse.de>, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [AES] Add module alias to x86_64 implementation
Message-ID: <20050811122834.GA21105@gondor.apana.org.au>
References: <20050808173336.GA11503@suse.de> <20050808105109.5e3168fc.akpm@osdl.org> <20050808175520.GA12150@suse.de> <20050808201046.GB15425@suse.de> <Pine.LNX.4.63.0508090015230.20178@excalibur.intercode>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508090015230.20178@excalibur.intercode>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 09, 2005 at 12:16:18AM -0400, James Morris wrote:
>
> > > I cant test it due to lack of hardware. Will find someone who does.
> > > modprobe aes is done by openswan, works on ppc, i386, but not on x86_64.
> > 
> > This works, tested it. modprobe -v aes
> > insmod /lib/modules/2.6.13-rc6-3-default/kernel/arch/x86_64/crypto/aes-x86_64.ko 
> 
> It looks the same as the i386 version, so probably ok.

It looks good to me too.  Andrew, please add this to 2.6.13:

Subject: [AES] Add module alias to x86_64 implementation
From: Olaf Hering <olh@suse.de>

modprobe aes does not work on x86_64. i386 has a similar line,

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/arch/x86_64/crypto/aes.c b/arch/x86_64/crypto/aes.c
--- a/arch/x86_64/crypto/aes.c
+++ b/arch/x86_64/crypto/aes.c
@@ -322,3 +322,4 @@ module_exit(aes_fini);
 
 MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("aes");

--u3/rZRmxL6MmkK24--
