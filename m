Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVBYWbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVBYWbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVBYWbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:31:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46090 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262785AbVBYW3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:29:49 -0500
Date: Fri, 25 Feb 2005 23:29:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chris Friesen <cfriesen@nortel.com>
Cc: jmorris@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] better CRYPTO_AES <-> CRYPTO_AES_586 dependencies
Message-ID: <20050225222938.GG3311@stusta.de>
References: <20050225214613.GF3311@stusta.de> <421FA1C7.2080201@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421FA1C7.2080201@nortel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 04:08:07PM -0600, Chris Friesen wrote:
> Adrian Bunk wrote:
> 
> >--- linux-2.6.11-rc4-mm1-full/crypto/Kconfig.old	2005-02-25 
> >22:26:20.000000000 +0100
> >+++ linux-2.6.11-rc4-mm1-full/crypto/Kconfig	2005-02-25 
> >22:28:44.000000000 +0100
> >@@ -133,7 +133,9 @@
> > 
> > config CRYPTO_AES
> > 	tristate "AES cipher algorithms"
> >-	depends on CRYPTO && !(X86 && !X86_64)
> >+	depends on CRYPTO
> >+	select CRYPTO_AES_GENERIC if !(X86 && !X86_64)
> >+	select CRYPTO_AES_586 if (X86 && !X86_64)
> 
> Wouldn't the 586 one also work on x86_64?

I'd assume yes.

But the CRYPTO_AES_586 were already this way, and since I don't know the 
history of these dependencies this isn't changed by my patch.

> Chris

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

