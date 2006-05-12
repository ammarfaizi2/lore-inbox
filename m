Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWELUlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWELUlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWELUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:41:12 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:49864
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751380AbWELUlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:41:11 -0400
From: Michael Buesch <mb@bu3sch.de>
To: David Vrabel <dvrabel@cantab.net>
Subject: Re: [patch 5/9] Add Geode HW RNG driver
Date: Fri, 12 May 2006 22:46:58 +0200
User-Agent: KMail/1.9.1
References: <20060512103522.898597000@bu3sch.de> <20060512103648.229129000@bu3sch.de> <44646C08.9000800@cantab.net>
In-Reply-To: <44646C08.9000800@cantab.net>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605122246.58961.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 13:05, you wrote:
> mb@bu3sch.de wrote:
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> > Index: hwrng/drivers/char/hw_random/Kconfig
> > ===================================================================
> > --- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:59.000000000 +0200
> > +++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
> > @@ -35,3 +35,16 @@
> >  	  module will be called amd-rng.
> >  
> >  	  If unsure, say Y.
> > +
> > +config HW_RANDOM_GEODE
> > +	tristate "AMD Geode HW Random Number Generator support"
> > +	depends on HW_RANDOM && (X86 || IA64) && PCI
>                                      ^^^^^^^
> IA64?

I have no idea. I neither wrote the driver, nor do I have the device.
So, drop IA64?

> > +	default y
> > +	---help---
> > +	  This driver provides kernel-side support for the Random Number
> > +	  Generator hardware found on AMD Geode based motherboards.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called geode-rng.
> 
> You need to state which members of the Geode family have this hardware.
>  e.g., Is it only the Geode LX CPUs?

Well, no idea. It was not stated in the existing old help text either.

-- 
Greetings Michael.
