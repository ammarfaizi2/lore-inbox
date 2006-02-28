Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWB1Viq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWB1Viq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWB1Viq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:38:46 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:15014
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932592AbWB1Vip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:38:45 -0500
Message-ID: <4404C2E4.9070102@microgate.com>
Date: Tue, 28 Feb 2006 15:38:44 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Darren Jenkins <darrenrjenkins@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] synclink_gt: make ->init_error signed
References: <20060228212619.GB7793@mipter.zuzino.mipt.ru>
In-Reply-To: <20060228212619.GB7793@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>
> 
> Examples of misuse are
> 
> 3112 info->init_error = -1;
> 
> 4440 if ((info->init_error = register_test(info)) < 0) {
> 
> Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/char/synclink_gt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/char/synclink_gt.c
> +++ b/drivers/char/synclink_gt.c
> @@ -306,7 +306,7 @@ struct slgt_info {
>  	int tx_active;
>  
>  	unsigned char signals;    /* serial signal states */
> -	unsigned int init_error;  /* initialization error */
> +	int init_error;  /* initialization error */
>  
>  	unsigned char *tx_buf;
>  	int tx_count;

Yes, should definately by signed.

Acked-by: Paul Fulghum <paulkf@microgate.com>

-- 
Paul Fulghum
Microgate Systems, Ltd.
