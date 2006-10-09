Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWJIIh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWJIIh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWJIIh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:37:26 -0400
Received: from natblert.rzone.de ([81.169.145.181]:706 "EHLO natblert.rzone.de")
	by vger.kernel.org with ESMTP id S932400AbWJIIhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:37:25 -0400
Date: Mon, 9 Oct 2006 10:37:23 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Amit Choudhary <amit2030@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c: check kmalloc() return value.
Message-ID: <20061009083723.GA27728@aepfle.de>
References: <20061008231034.e50118df.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061008231034.e50118df.amit2030@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, Amit Choudhary wrote:

> Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.
> 
> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
> 
> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> index fb6c4cc..14e69a7 100644
> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> @@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
>  	case BTTV_BOARD_TWINHAN_DST:
>  		/*	DST is not a frontend driver !!!		*/
>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
> +		if (!state) {
> +			printk("dvb_bt8xx: No memory\n");

KERN_FOO loglevel is missing.
