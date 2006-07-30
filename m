Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWG3QtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWG3QtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWG3QtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:49:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:2972 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932370AbWG3QtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:49:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=t8fpOBvfEBDqYC/1o0VTvIxNlkjWnEZtBzGvMN203FjRhk7BLym81YggzutR2liZD3KgvqO94L7cU57ux3qBIX+1KeOsLVzI+NQNEHlsFH4tsWtiw/cVQLiWp2IQ19JN1YoXLXTBVPvOIssFVQn8jI9G3+tKed9NJP409Nl4ulA=
Message-ID: <44CCE313.6060208@gmail.com>
Date: Sun, 30 Jul 2006 10:49:23 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/char/pc8736x_gpio.c: remove unused static
 functions
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003743.GQ3633@stusta.de>
In-Reply-To: <20060715003743.GQ3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>   
>> ...
>> Changes since 2.6.18-rc1-mm1:
>> ...
>> +gpio-drop-vtable-members-gpio_set_high-gpio_set_low.patch
>> ...
>>  Misc fixes and updates and cleanups.
>> ...
>>     
>
> This patch removes two no longer used static functions fixing the 
> following gcc warnings:
>   

Oops.  I thought Id acked this, but it seems not, til now.

> <--  snip  -->
>
> ...
>   CC      drivers/char/pc8736x_gpio.o
> drivers/char/pc8736x_gpio.c:192: warning: #pc8736x_gpio_set_high# defined but not used
> drivers/char/pc8736x_gpio.c:197: warning: #pc8736x_gpio_set_low# defined but not used
> ...
>
> <--  snip  -->
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>   
Acked-by:   Jim Cromie  <jim.cromie@gmail.com>
> ---
>
>  drivers/char/pc8736x_gpio.c |   10 ----------
>  1 file changed, 10 deletions(-)
>
> --- linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c.old	2006-07-15 01:38:59.000000000 +0200
> +++ linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c	2006-07-15 01:39:10.000000000 +0200
> @@ -188,16 +188,6 @@
>  	pc8736x_gpio_shadow[port] = val;
>  }
>  
> -static void pc8736x_gpio_set_high(unsigned index)
> -{
> -	pc8736x_gpio_set(index, 1);
> -}
> -
> -static void pc8736x_gpio_set_low(unsigned index)
> -{
> -	pc8736x_gpio_set(index, 0);
> -}
> -
>  static int pc8736x_gpio_current(unsigned minor)
>  {
>  	int port, bit;
>
>
>   

