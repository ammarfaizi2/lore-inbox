Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbVHaQ71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbVHaQ71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 12:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVHaQ71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 12:59:27 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:6062 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S964879AbVHaQ70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 12:59:26 -0400
Date: Wed, 31 Aug 2005 18:59:07 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Michael Krufky <mkrufky@m1k.net>, Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
       linux-dvb-maintainer@linuxtv.org, stable@kernel.org
Message-ID: <20050831165907.GC21194@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, Michael Krufky <mkrufky@m1k.net>,
	Andrew Morton <akpm@osdl.org>,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org,
	linux-dvb-maintainer@linuxtv.org, stable@kernel.org
References: <4314B7C2.2080705@m1k.net> <20050831154350.GB8638@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831154350.GB8638@stusta.de>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.244.102
Subject: Re: [linux-dvb-maintainer] [2.6 patch] add missing select's to DVB_BUDGET_AV
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 Adrian Bunk wrote:
> 
> Add missing select's to DVB_BUDGET_AV fixing the following compile 
> error:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `frontend_init':
> budget-av.c:(.text+0xb9448): undefined reference to `tda10046_attach'
> budget-av.c:(.text+0xb9518): undefined reference to `tda10021_attach'
> drivers/built-in.o: In function `philips_tu1216_request_firmware':
> budget-av.c:(.text+0xb937b): undefined reference to `request_firmware'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Johannes Stezenbach <js@linuxtv.org>

I also added this to linuxtv.org CVS. But I'm not sure it
is critical enough to put it in stable.

Thanks,
Johannes

> --- linux-2.6.13/drivers/media/dvb/ttpci/Kconfig.old	2005-08-31 17:36:33.000000000 +0200
> +++ linux-2.6.13/drivers/media/dvb/ttpci/Kconfig	2005-08-31 17:39:57.000000000 +0200
> @@ -99,12 +99,15 @@
>  config DVB_BUDGET_AV
>  	tristate "Budget cards with analog video inputs"
>  	depends on DVB_CORE && PCI
>  	select VIDEO_DEV
>  	select VIDEO_SAA7146_VV
>  	select DVB_STV0299
> +	select DVB_TDA1004X
> +	select DVB_TDA10021
> +	select FW_LOADER
>  	help
>  	  Support for simple SAA7146 based DVB cards
>  	  (so called Budget- or Nova-PCI cards) without onboard
>  	  MPEG2 decoder, but with one or more analog video inputs.
>  
>  	  Say Y if you own such a card and want to use it.
> 
> 
> _______________________________________________
> linux-dvb-maintainer mailing list
> linux-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/linux-dvb-maintainer
> 
