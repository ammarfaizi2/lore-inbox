Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVGZUxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVGZUxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGZUxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:53:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15262 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261912AbVGZUxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:53:05 -0400
Date: Tue, 26 Jul 2005 22:52:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [warning: ugly, FYI] battery charging support for sharp sl-5500
Message-ID: <20050726205257.GA12838@elf.ucw.cz>
References: <20050725054642.GA6651@elf.ucw.cz> <1122304018.7942.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122304018.7942.61.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #define        SCP_REG_MCR     SCP_REG(SCP_MCR)
> > #define        SCP_REG_CDR     SCP_REG(SCP_CDR)
> > #define        SCP_REG_CSR     SCP_REG(SCP_CSR)
> > #define        SCP_REG_CPR     SCP_REG(SCP_CPR)
> > #define        SCP_REG_CCR     SCP_REG(SCP_CCR)
> > #define        SCP_REG_IRR     SCP_REG(SCP_IRR)
> > #define        SCP_REG_IRM     SCP_REG(SCP_IRM)
> > #define        SCP_REG_IMR     SCP_REG(SCP_IMR)
> > #define        SCP_REG_ISR     SCP_REG(SCP_ISR)
> > #define        SCP_REG_GPCR    SCP_REG(SCP_GPCR)
> > #define        SCP_REG_GPWR    SCP_REG(SCP_GPWR)
> > #define        SCP_REG_GPRR    SCP_REG(SCP_GPRR)
> 
> You'll find the scoop driver deals with the above
> (arch/arm/common/scoop.c).

Thanks.

> > #define FLASH_MEM_BASE 0xe8ffc000
> > #define        FLASH_DATA(adr) (*(volatile unsigned int*)(FLASH_MEM_BASE+(adr)))
> > #define        FLASH_DATA_F(adr) (*(volatile float32 *)(FLASH_MEM_BASE+(adr)))
> > #define FLASH_MAGIC_CHG(a,b,c,d) ( ( d << 24 ) | ( c << 16 )  | ( b << 8 ) | a )
> > 
> > // AD
> > #define FLASH_AD_MAJIC FLASH_MAGIC_CHG('B','V','A','D')
> > #define        FLASH_AD_MAGIC_ADR      0x30
> > #define        FLASH_AD_DATA_ADR       0x34
> 
> and arch/arm/common/sharpsl_param.c with these.

Hmm, I wonder what it wants there... It seems to read some battery
correction value? 

> > #define IRQ_GPIO_CO                IRQ_GPIO20
> > #define IRQ_GPIO_AC_IN             IRQ_GPIO1
> 
> There will (or if not, there should) be an equivalent in collie.h for
> the above.
> 
> I have similar problems with the corgi battery driver which is probably
> even more of a mess than this. My conclusion is the whole lot needs
> rewriting in a nice fashion before it can be included in mainline. My
> work so far on the corgi code is here:
> 
> http://www.rpsys.net/openzaurus/patches/corgi_power-r24.patch
> http://www.rpsys.net/openzaurus/patches/corgi_power1-r1.patch

I'll comment in separate mail.

> I'm making progress in areas but I'm not sure how much can be shared
> between devices. My plan is to split the above into two sections, a
> battery driver and some power management code. The powermanagement code
> can probably then make mainline. The battery driver still needs a lot of
> work.

It looks pretty similar... on the first look.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
