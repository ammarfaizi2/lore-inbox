Return-Path: <linux-kernel-owner+w=401wt.eu-S932293AbXAONDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbXAONDP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbXAONDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:03:15 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58535 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932293AbXAONDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:03:14 -0500
X-Originating-Ip: 74.109.98.130
Date: Mon, 15 Jan 2007 07:32:46 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Ben Dooks <ben-linux@fluff.org>
cc: rpurdie@rpsys.net, linux-kernel@vger.kernel.org
Subject: Re: LEDS: S3C24XX generate name if none given
In-Reply-To: <20070115122654.GA25047@home.fluff.org>
Message-ID: <Pine.LNX.4.64.0701150732190.2742@CPE00045a9c397f-CM001225dbafb6>
References: <20070115122654.GA25047@home.fluff.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Ben Dooks wrote:

> Generate a name if none is passed to the S3C24XX GPIO LED driver.
>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
>
> diff -urpN -X ../dontdiff linux-2.6.19/drivers/leds/leds-s3c24xx.c linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c
> --- linux-2.6.19/drivers/leds/leds-s3c24xx.c	2006-11-29 21:57:37.000000000 +0000
> +++ linux-2.6.19-simtec1p22/drivers/leds/leds-s3c24xx.c	2007-01-04 10:22:58.000000000 +0000
> @@ -23,6 +23,8 @@
>  /* our context */
>
>  struct s3c24xx_gpio_led {
> +	char				 name[32];
> +
>  	struct led_classdev		 cdev;
>  	struct s3c24xx_led_platdata	*pdata;
>  };
> @@ -85,6 +87,14 @@ static int s3c24xx_led_probe(struct plat
>
>  	led->pdata = pdata;
>
> +	/* create name if we where not passed one */
                             ^^^^^ "were"


rday
