Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVBUBri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVBUBri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 20:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVBUBrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 20:47:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5302 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261173AbVBUBrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 20:47:31 -0500
Message-ID: <42193DA2.9050606@pobox.com>
Date: Sun, 20 Feb 2005 20:47:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/lp486e.c: make some code static
References: <20050217205454.GI6194@stusta.de>
In-Reply-To: <20050217205454.GI6194@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/net/lp486e.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.11-rc3-mm2-full/drivers/net/lp486e.c.old	2005-02-16 16:08:34.000000000 +0100
> +++ linux-2.6.11-rc3-mm2-full/drivers/net/lp486e.c	2005-02-16 16:15:33.000000000 +0100
> @@ -112,8 +112,10 @@
>  	CmdDiagnose = 7
>  };
>  
> -char *CUcmdnames[8] = { "NOP", "IASetup", "Configure", "MulticastList",
> -			"Tx", "TDR", "Dump", "Diagnose" };
> +#if 0
> +static char *CUcmdnames[8] = { "NOP", "IASetup", "Configure", "MulticastList",
> +			       "Tx", "TDR", "Dump", "Diagnose" };
> +#endif

Need const.

	Jeff



