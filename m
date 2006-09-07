Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWIGTkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWIGTkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWIGTkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:40:46 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:5742 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1751270AbWIGTkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:40:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HABURAEWBT4lx
From: Dmitry Torokhov <dtor@insightbb.com>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: PATCH] usbtouchscreen: fix ITM data reading
Date: Thu, 7 Sep 2006 15:40:42 -0400
User-Agent: KMail/1.9.3
Cc: Greg KH <gregkh@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>,
       Kai Lindholm <megantti@gmail.com>
References: <200609072125.53404.daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200609072125.53404.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609071540.43474.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 September 2006 15:25, Daniel Ritz wrote:
> before 2.6.19, please :)
> 
> [PATCH] usbtouchscreen: fix ITM data reading
> 
> From: Kai Lindhom <megantti@gmail.com>
> Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
>

Acked-by: Dmitry Torokhov <dtor@mail.ru>

Greg, will you push it through your tree?
 
> diff --git a/drivers/usb/input/usbtouchscreen.c b/drivers/usb/input/usbtouchscreen.c
> index 3b175aa..a338bf4 100644
> --- a/drivers/usb/input/usbtouchscreen.c
> +++ b/drivers/usb/input/usbtouchscreen.c
> @@ -286,7 +286,7 @@ #ifdef CONFIG_USB_TOUCHSCREEN_ITM
>  static int itm_read_data(unsigned char *pkt, int *x, int *y, int *touch, int *press)
>  {
>  	*x = ((pkt[0] & 0x1F) << 7) | (pkt[3] & 0x7F);
> -	*x = ((pkt[1] & 0x1F) << 7) | (pkt[4] & 0x7F);
> +	*y = ((pkt[1] & 0x1F) << 7) | (pkt[4] & 0x7F);
>  	*press = ((pkt[2] & 0x1F) << 7) | (pkt[5] & 0x7F);
>  	*touch = ~pkt[7] & 0x20;
>  
> 

-- 
Dmitry
