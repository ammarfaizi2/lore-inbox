Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWEYRJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWEYRJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWEYRJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:09:47 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:13484 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1030289AbWEYRJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:09:45 -0400
Message-ID: <4475E4D9.2010505@pardus.org.tr>
Date: Thu, 25 May 2006 20:09:45 +0300
From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
User-Agent: Mozilla Thunderbird 1.5.0.2 (X11/20060426)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scx200_acb: fix section mismatch warning
References: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
In-Reply-To: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=5B88F54C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote On 25-05-2006 20:01:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix section mismatch warning reported by İsmail Dönmez:
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .init.text: from .text after 'scx200_add_cs553x' (at offset 0x528)
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/i2c/busses/scx200_acb.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2617-rc5.orig/drivers/i2c/busses/scx200_acb.c
> +++ linux-2617-rc5/drivers/i2c/busses/scx200_acb.c
> @@ -491,7 +491,7 @@ static struct pci_device_id divil_pci[] 
>  
>  #define MSR_LBAR_SMB		0x5140000B
>  
> -static int scx200_add_cs553x(void)
> +static __init int scx200_add_cs553x(void)
>  {
>  	u32	low, hi;
>  	u32	smb_base;
> 
> 
> ---

Ack, this fixes the warning for me.

Regards,
ismail

