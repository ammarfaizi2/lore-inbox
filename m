Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUHKS1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUHKS1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268154AbUHKS1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:27:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2223 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268164AbUHKS0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:26:00 -0400
Message-ID: <411A64AA.70902@pobox.com>
Date: Wed, 11 Aug 2004 14:25:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/seeq8005.c: small cleanups (fwd)
References: <20040809215112.GE26174@fs.tum.de>
In-Reply-To: <20040809215112.GE26174@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The trivial patch forwarded below still applies and compiles against 
> 2.6.8-rc3-mm2.
> 
> Please apply.
> 
> 
> ----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----
> 
> Date:	Fri, 16 Jul 2004 00:17:42 +0200
> From: Adrian Bunk <bunk@fs.tum.de>
> To: hamish@zot.apana.org.au
> Cc: jgarzik@pobox.com, linux-net@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Subject: [2.6 patch] net/seeq8005.c: small cleanups
> 
> The patch below does the following small cleanups in seeq8005.c:
> - kill ancient version variable
> - remove Emacs settings
> 
> 
> diffstat output:
>  drivers/net/seeq8005.c |   18 ------------------
>  1 files changed, 18 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> 
> --- linux-2.6.8-rc1-mm1-full-3.4/drivers/net/seeq8005.c.old	2004-07-16 00:08:55.000000000 +0200
> +++ linux-2.6.8-rc1-mm1-full-3.4/drivers/net/seeq8005.c	2004-07-16 00:09:28.000000000 +0200
> @@ -12,12 +12,7 @@
>  	This file is a network device driver for the SEEQ 8005 chipset and
>  	the Linux operating system.
>  
> -*/
> -
> -static const char version[] =
> -	"seeq8005.c:v1.00 8/07/95 Hamish Coleman (hamish@zot.apana.org.au)\n";
>  
> -/*
>    Sources:
>    	SEEQ 8005 databook
>    	
> @@ -150,7 +145,6 @@
>  
>  static int __init seeq8005_probe1(struct net_device *dev, int ioaddr)
>  {
> -	static unsigned version_printed;
>  	int i,j;
>  	unsigned char SA_prom[32];
>  	int old_cfg1;
> @@ -291,9 +285,6 @@
>  	}
>  #endif
>  
> -	if (net_debug  &&  version_printed++ == 0)
> -		printk(version);
> -


This "small cleanup" appears to kill useful and working code.

	Jeff


