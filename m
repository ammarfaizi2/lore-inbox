Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267393AbUHZD7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267393AbUHZD7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 23:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHZD7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 23:59:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:39613 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267393AbUHZD7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 23:59:11 -0400
Subject: Please revert this patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200408260010.i7Q0A6EB001323@hera.kernel.org>
References: <200408260010.i7Q0A6EB001323@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1093492619.2637.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 26 Aug 2004 13:57:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux !

Please revert that for now, I need to figure out what they were
exactly trying to do and will come up with something if it makes
sense but the patch as-is doesn't.

Thanks,
Ben.

On Thu, 2004-08-26 at 06:21, Linux Kernel Mailing List wrote:
> ChangeSet 1.1870.2.2, 2004/08/25 13:21:22-07:00, khali@linux-fr.org
> 
> 	[PATCH] I2C: keywest class
> 	
> 	This is needed for iBook2 owners to be able to use their ADM1030
> 	hardware monitoring chip. Successfully tested by one user.
> 	
> 	Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 	Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> 
> 
>  i2c-keywest.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> 
> diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
> --- a/drivers/i2c/busses/i2c-keywest.c	2004-08-25 17:10:16 -07:00
> +++ b/drivers/i2c/busses/i2c-keywest.c	2004-08-25 17:10:16 -07:00
> @@ -618,6 +618,8 @@
>  		chan->iface = iface;
>  		chan->chan_no = i;
>  		chan->adapter.id = I2C_ALGO_SMBUS;
> +		if (i==1)
> +			chan->adapter.class = I2C_CLASS_HWMON;
>  		chan->adapter.algo = &keywest_algorithm;
>  		chan->adapter.algo_data = NULL;
>  		chan->adapter.client_register = NULL;
> -
> To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

