Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWAYFvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWAYFvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 00:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWAYFvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 00:51:17 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:37544 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751027AbWAYFvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 00:51:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] iforce: fix -ENOMEM check
Date: Wed, 25 Jan 2006 00:51:10 -0500
User-Agent: KMail/1.9.1
Cc: Marek Va?ut <marek.vasut@gmail.com>, linux-kernel@vger.kernel.org
References: <200601221250.26792.marek.vasut@gmail.com> <200601230048.43360.dtor_core@ameritech.net> <20060123152808.GA7766@mipter.zuzino.mipt.ru>
In-Reply-To: <20060123152808.GA7766@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601250051.10835.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 10:28, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/input/joystick/iforce/iforce-main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/input/joystick/iforce/iforce-main.c
> +++ b/drivers/input/joystick/iforce/iforce-main.c
> @@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
>  	int i;
>  
>  	input_dev = input_allocate_device();
> -	if (input_dev)
> +	if (!input_dev)
>  		return -ENOMEM;
>  
>  	init_waitqueue_head(&iforce->wait);
> 
> 

Applied to the input tree, thank you.

-- 
Dmitry
