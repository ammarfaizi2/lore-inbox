Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVAYW6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVAYW6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVAYW4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:56:32 -0500
Received: from fire.osdl.org ([65.172.181.4]:50575 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262221AbVAYWyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:54:31 -0500
Message-ID: <41F6C07A.5010609@osdl.org>
Date: Tue, 25 Jan 2005 13:56:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/configs.c: make a variable static
References: <20050121100737.GA3209@stusta.de>
In-Reply-To: <20050121100737.GA3209@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes a needlessly global variable static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Randy Dunlap <rddunlap@osdl.org>

> ---
> 
> This patch was already sent on:
> - 12 Dec 2004
> 
> --- linux-2.6.10-rc2-mm4-full/kernel/Makefile.old	2004-12-12 02:45:07.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/kernel/Makefile	2004-12-12 02:45:18.000000000 +0100
> @@ -48,7 +48,7 @@
>  	$(call if_changed,gzip)
>  
>  quiet_cmd_ikconfiggz = IKCFG   $@
> -      cmd_ikconfiggz = (echo "const char kernel_config_data[] = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
> +      cmd_ikconfiggz = (echo "static const char kernel_config_data[] = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
>  targets += config_data.h
>  $(obj)/config_data.h: $(obj)/config_data.gz FORCE
>  	$(call if_changed,ikconfiggz)
> 
> -

-- 
~Randy
