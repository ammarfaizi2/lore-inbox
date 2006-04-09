Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWDISlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWDISlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWDISlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:41:24 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:55241 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbWDISlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:41:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VXRJmzDeOljrcJ4Pa/sYTgUnAjCU8wlBZxEVKDr1wZxvfW06OBUdNg/UUjvi9jJwf8UCXGkkXhwIP8/LJv7oLkQbV7ciYdVc2cxFgkFnDpFzoU7UTEudLLPcWHxq2qXPgaR/hrsv65MVNxBzhQmn3SR2mK35sjG208WWouKaGx8=
Message-ID: <4439554E.4050200@gmail.com>
Date: Sun, 09 Apr 2006 22:41:18 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] dvb/bt8xx/bt878.c: don't export static variables
References: <20060409174846.GJ8454@stusta.de>
In-Reply-To: <20060409174846.GJ8454@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Static variables mustn't be EXPORT_SYMBOL'ed.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
>  drivers/media/dvb/bt8xx/bt878.c |    2 --
>  1 file changed, 2 deletions(-)
>
> --- linux-2.6.17-rc1-mm2-full/drivers/media/dvb/bt8xx/bt878.c.old	2006-04-09 18:43:28.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-full/drivers/media/dvb/bt8xx/bt878.c	2006-04-09 18:44:26.000000000 +0200
> @@ -54,26 +54,24 @@
>  static unsigned int bt878_verbose = 1;
>  static unsigned int bt878_debug;
>  
>  module_param_named(verbose, bt878_verbose, int, 0444);
>  MODULE_PARM_DESC(verbose,
>  		 "verbose startup messages, default is 1 (yes)");
>  module_param_named(debug, bt878_debug, int, 0644);
>  MODULE_PARM_DESC(debug, "Turn on/off debugging, default is 0 (off).");
>  
>  int bt878_num;
>  struct bt878 bt878[BT878_MAX];
>  
> -EXPORT_SYMBOL(bt878_debug);
> -EXPORT_SYMBOL(bt878_verbose);
>  EXPORT_SYMBOL(bt878_num);
>  EXPORT_SYMBOL(bt878);
>  
>  #define btwrite(dat,adr)    bmtwrite((dat), (bt->bt878_mem+(adr)))
>  #define btread(adr)         bmtread(bt->bt878_mem+(adr))
>  
>  #define btand(dat,adr)      btwrite((dat) & btread(adr), adr)
>  #define btor(dat,adr)       btwrite((dat) | btread(adr), adr)
>  #define btaor(dat,mask,adr) btwrite((dat) | ((mask) & btread(adr)), adr)
>  
>  #if defined(dprintk)
>  #undef dprintk
>
> -
>   

Ack'd-by: Manu Abraham <manu@linuxtv.org>

