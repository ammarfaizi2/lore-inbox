Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWIUB7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWIUB7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWIUB7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:59:55 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:10289 "EHLO
	asav14.insightbb.com") by vger.kernel.org with ESMTP
	id S1750989AbWIUB7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:59:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAEqOEUWBT4obLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: [PATCH] ams: remove usage of input_dev cdev
Date: Wed, 20 Sep 2006 21:59:53 -0400
User-Agent: KMail/1.9.3
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060921005158.GB16002@cathedrallabs.org>
In-Reply-To: <20060921005158.GB16002@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202159.53628.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 20:51, Aristeu Sergio Rozanski Filho wrote:
> This patch removes usage of 'cdev' member of input_dev, not present
> on that struct anymore.
> 

Where did it go?

> Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> 
> --- mm.orig/drivers/hwmon/ams/ams-mouse.c	2006-09-20 13:57:59.000000000 -0300
> +++ mm/drivers/hwmon/ams/ams-mouse.c	2006-09-20 21:01:59.000000000 -0300
> @@ -66,7 +66,6 @@
>  	ams_info.idev->name = "Apple Motion Sensor";
>  	ams_info.idev->id.bustype = ams_info.bustype;
>  	ams_info.idev->id.vendor = 0;
> -	ams_info.idev->cdev.dev = &ams_info.of_dev->dev;
>  
>  	input_set_abs_params(ams_info.idev, ABS_X, -50, 50, 3, 0);
>  	input_set_abs_params(ams_info.idev, ABS_Y, -50, 50, 3, 0);
> 

-- 
Dmitry
