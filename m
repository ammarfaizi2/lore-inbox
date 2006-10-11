Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbWJKWmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWJKWmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWJKWmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:42:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54750 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161253AbWJKWmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:42:04 -0400
Subject: Re: [PATCH] I2O: more error checking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: markus.lidel@shadowconnect.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061011214148.GA20524@havoc.gtf.org>
References: <20061011214148.GA20524@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2006 00:06:28 +0100
Message-Id: <1160607988.19068.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-11 am 17:41 -0400, ysgrifennodd Jeff Garzik:
> i2o_scsi: handle sysfs failure
> 
> i2o_device:
> * convert i2o_device_add() to return integer error code

NAK, Fix the comments to match the code changes.

> diff --git a/drivers/message/i2o/device.c b/drivers/message/i2o/device.c
> index ee18305..5f2c317 100644
> --- a/drivers/message/i2o/device.c
> +++ b/drivers/message/i2o/device.c
> @@ -217,15 +217,15 @@ static struct i2o_device *i2o_device_all
>   *	Returns a pointer to the I2O device on success or negative error code
>   *	on failure.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

>   */
> -static struct i2o_device *i2o_device_add(struct i2o_controller *c,
> -					 i2o_lct_entry * entry)
> +static int i2o_device_add(struct i2o_controller *c, i2o_lct_entry *entry)
>  {

Otherwise Ack.

