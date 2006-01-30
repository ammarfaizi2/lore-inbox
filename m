Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWA3Ua6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWA3Ua6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWA3Ua6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:30:58 -0500
Received: from hosting9000.com ([81.169.143.62]:29930 "EHLO
	mail.hosting9000.com") by vger.kernel.org with ESMTP
	id S964954AbWA3Ua5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:30:57 -0500
Date: Mon, 30 Jan 2006 21:30:52 +0100
From: "Gabriel C." <crazy@pimpmylinux.org>
To: linux-kernel@vger.kernel.org, linville@tuxdriver.com
Cc: netdev@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, da.crew@gmx.net
Subject: Re: [2.6 patch] PCMCIA=m, HOSTAP_CS=y is not a legal configuration
Message-ID: <20060130213052.5b1ea5cd@zwerg>
In-Reply-To: <20060130182317.GD3655@stusta.de>
References: <20060130133833.7b7a3f8e@zwerg>
	<20060130182317.GD3655@stusta.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2006 19:23:17 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Jan 30, 2006 at 01:38:33PM +0100, Gabriel C. wrote:
> 
> > Hello,
> 
> Hallo Gabriel,
> 
> > I got this compile error with 2.6.16-rc1-mm4 , config attached. 
> > 
> > 
> >   LD      .tmp_vmlinux1
> >...
> > `sandisk_set_iobase':hostap_cs.c:(.text+0x801ad): undefined
> > reference to
> > `pcmcia_access_configuration_register' :hostap_cs.c:(.text+0x801f3):
> > undefined reference to `pcmcia_access_configuration_register'
> > drivers/built-in.o: In function
> > `prism2_pccard_cor_sreset':hostap_cs.c:(.text+0x80254): undefined
> > reference to
> > `pcmcia_access_configuration_register' :hostap_cs.c:(.text+0x80289):
> > undefined reference to
> > `pcmcia_access_configuration_register' :hostap_cs.c:(.text+0x80325):
> > undefined reference to `pcmcia_access_configuration_register' [more
> > errors]
> >...
> 
> thanks for your report, a patch is below.
> > Gabriel 
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> CONFIG_PCMCIA=m, CONFIG_HOSTAP_CS=y doesn't compile.
> 
> Reported by "Gabriel C." <crazy@pimpmylinux.org>.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> linux-2.6.16-rc1-mm4/drivers/net/wireless/hostap/Kconfig.old
> 2006-01-30 19:00:44.000000000 +0100 +++
> linux-2.6.16-rc1-mm4/drivers/net/wireless/hostap/Kconfig
> 2006-01-30 19:01:04.000000000 +0100 @@ -75,7 +75,7 @@ config HOSTAP_CS
>  	tristate "Host AP driver for Prism2/2.5/3 PC Cards"
> -	depends on PCMCIA!=n && HOSTAP
> +	depends on PCMCIA && HOSTAP
>  	---help---
>  	Host AP driver's version for Prism2/2.5/3 PC Cards.
>  
> 

Hi Adrian,

Your patch works fine,  thanks :)

Gabriel
