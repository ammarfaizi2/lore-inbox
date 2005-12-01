Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbVLATJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbVLATJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbVLATJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:09:44 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:42757 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751708AbVLATJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:09:43 -0500
Date: Thu, 1 Dec 2005 20:11:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mauro Carvalho Chehab" <mchehab@brturbo.com.br>
Cc: "Andrew Morton" <akpm@osdl.org>, js@linuxtv.org,
       "LM Sensors" <lm-sensors@lm-sensors.org>, "Greg KH" <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 11/31] V4L (0999) Some funcions now static and I2C hw
 code for IR
Message-Id: <20051201201121.1c09cec7.khali@linux-fr.org>
In-Reply-To: <1133400730.21135.62.camel@localhost>
References: <1133400730.21135.62.camel@localhost>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

[As a side note, it looks like there have been some distribution
problems with this patchset... I can only see 0/31 (twice) on LKML and
11/31 didn't make it to the lm-sensors list as it was supposed to. I
received it twice though.]

> From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>
> - Some funcions are now declared as static
> - Added a I2C code for InfraRed.

Unrelated changes, this should have been two separate patches. Also,
"I2C driver ID" would better describe what the second change is about
than "I2C code".

> --- git.orig/drivers/media/video/ir-kbd-i2c.c
> +++ git/drivers/media/video/ir-kbd-i2c.c
> @@ -278,7 +278,7 @@ static int ir_probe(struct i2c_adapter *
>
> static struct i2c_driver driver = {
> 	.name           = "ir remote kbd driver",
> -	.id             = I2C_DRIVERID_EXP3, /* FIXME */
> +	.id             = I2C_DRIVERID_I2C_IR,
> 	.flags          = I2C_DF_NOTIFY,
> 	.attach_adapter = ir_probe,
> 	.detach_client  = ir_detach,

That's a poor ID name you chose. The second "I2C" is totally redundant,
and "IR" is a bit short and could mean about anything. Please change it to
I2C_DRIVERID_IRKBD or I2C_DRIVERID_INFRARED or something.

Thanks,
-- 
Jean Delvare
