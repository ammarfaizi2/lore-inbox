Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRI0Lmn>; Thu, 27 Sep 2001 07:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272407AbRI0Lmd>; Thu, 27 Sep 2001 07:42:33 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:50113 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S272369AbRI0LmT>;
	Thu, 27 Sep 2001 07:42:19 -0400
Date: Thu, 27 Sep 2001 13:42:43 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jean Marc LACROIX <jean-marc.lacroix@logatique.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10 hang with agpart driver enable on Laptob HP 4150
Message-ID: <20010927134241.A4815@se1.cogenit.fr>
In-Reply-To: <3BB2E84E.12381FB9@logatique.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB2E84E.12381FB9@logatique.fr>; from jean-marc.lacroix@logatique.fr on Thu, Sep 27, 2001 at 10:50:23AM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut,

Jean Marc LACROIX <jean-marc.lacroix@logatique.fr> :
[...]
> I have a Laptob omnibook 4150 with "Debian testing Woody" configuration.
> I have compiled 2.4.10 kernel with agpart char driver enable, installed 
> it and reboot.....
> The system hang with following message:
> 
> -----------------------------------------------
> linux agpart interface V0.99 (c) Jeff Hartmann
> agpart: Maximum main memory to use for agp memory : 27M
> agpart: Detected Intel 440Bx chipset
> -----------------------------------------------

It misses a 'printk(KERN_INFO PFX "AGP aperture is %dM @ 0x%lx\n", ...',
you're stuck in agp_backend_initialize.
Does SysRq still work after this message ?

-- 
Ueimor
