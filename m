Return-Path: <linux-kernel-owner+w=401wt.eu-S1751205AbXAIJHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXAIJHl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXAIJHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:07:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:34737 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbXAIJHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:07:38 -0500
Subject: Re: Linux 2.6.20-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Greg KH <gregkh@suse.de>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
       paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <45A340E4.5030702@246tNt.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <200701081550.27748.m.kozlowski@tuxland.pl> <45A25C17.5070606@246tNt.com>
	 <1168303139.22458.246.camel@localhost.localdomain>
	 <20070109005624.GA598@suse.de>
	 <1168308323.22458.254.camel@localhost.localdomain>
	 <45A340E4.5030702@246tNt.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 20:07:14 +1100
Message-Id: <1168333634.22458.266.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But maybe the question we should ask is why would it build
> drivers/usb/host/ohci-ppc-soc.c for an iMac G3 ... Because that problem
> (ohci multiple glue in module) is there since a long time, just never
> spotted before.
> 
> arch/powerpc/KConfig :
> 
> config PPC_EFIKA
>         bool "bPlan Efika 5k2. MPC5200B based computer"
>         depends on PPC_MULTIPLATFORM && PPC32
>         select PPC_RTAS
>         select RTAS_PROC
>         select PPC_MPC52xx
>         select PPC_NATIVE
>         default y
>                ^^^
> 
> This was added by commit
> c37858d333a50815c74349396e31a535f4128e0b on Nov5.
> 
> and a patch to correct that has been submitted recently :
> http://patchwork.ozlabs.org/linuxppc/patch?id=8848

Yes, I think both issue should be fixed for 2.6.20 : the compile problem
with the OF glue -and- removing the default y.

The later should get picked up by Paulus, I'll make sure it is
tomorrow. 

The former, well, since it seems it doesn't mixup too much with my
patches, greg, you can probably send it to linus now if you think it
looks good (I haven't looked too closely at Sylvain patches myself).

Ben.

