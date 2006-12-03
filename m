Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760071AbWLCUWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760071AbWLCUWf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760072AbWLCUWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:22:35 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:5238 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1760071AbWLCUWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:22:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ZGpYnQcY9XRW2k9KCceDmZyk5BJG3dquG4ILx2zoZbS6KmCJ2pIN3gdBGy5/G/e2ssKYFi9SMOfcvAQLYUeESciU3SbvsMAiIEiBzhJ3bKyxLiJcYf0+VmmjobRUPplILmXaxAEvW0Q25Cw1L18d/oU4KX+kvEEAOMelFaJCbi8=  ;
X-YMail-OSG: yFLjkkAVM1nVczmrRV2joJdRbltHLEmS6J2sfQ023WwWtaipTVpSMGMx7r_C7MlMQSkUWp3pKDJjyhVCjJ9pw9YT1U7MK_aWu0XgdCCGioJU_Ms2MJKw
From: David Brownell <david-b@pacbell.net>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [Bulk] [MMC] Fix syntax error
Date: Sun, 3 Dec 2006 12:22:31 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20061203193721.GA20896@linux-mips.org>
In-Reply-To: <20061203193721.GA20896@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612031222.32028.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 December 2006 11:37 am, Ralf Baechle wrote:
> Fix syntax error introduced in ab7aefd0b38297e6d2d71f43e8f81f9f4a36cdae.

Whoops, sorry -- my bad.  However:


> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
> index 447fba5..6aac498 100644
> --- a/drivers/mmc/au1xmmc.c
> +++ b/drivers/mmc/au1xmmc.c
> @@ -875,7 +875,7 @@ static void au1xmmc_init_dma(struct au1x
>  	host->rx_chan = rxchan;
>  }
>  
> -struct const mmc_host_ops au1xmmc_ops = {
> +const struct mmc_host_ops au1xmmc_ops = {

This would normally be "static const struct" ...

>  	.request	= au1xmmc_request,
>  	.set_ios	= au1xmmc_set_ios,
>  };
> 
