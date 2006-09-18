Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbWIRBIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbWIRBIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 21:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWIRBIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 21:08:41 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:26135 "EHLO
	asav02.insightbb.com") by vger.kernel.org with ESMTP
	id S965208AbWIRBIk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 21:08:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAF6NDUWBT4oRLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Om Narasimhan <om.turyx@gmail.com>
Subject: Re: kmalloc to kzalloc patches for drivers/base
Date: Sun, 17 Sep 2006 21:08:36 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
References: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
In-Reply-To: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609172108.37707.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 September 2006 20:53, Om Narasimhan wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 2b8755d..e08950b 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -192,7 +192,7 @@ int platform_device_add_resources(struct
>  {
>         struct resource *r;
> 
> -       r = kmalloc(sizeof(struct resource) * num, GFP_KERNEL);
> +       r = kzalloc(sizeof(struct resource) * num, GFP_KERNEL);
>         if (r) {
>                 memcpy(r, res, sizeof(struct resource) * num);
>                 pdev->resource = r;

Just out of curiosity could you tell me what is the benefit of
zeroing allocated memory here?

> @@ -216,7 +216,7 @@ int platform_device_add_data(struct plat
>  {
>         void *d;
> 
> -       d = kmalloc(size, GFP_KERNEL);
> +       d = kzalloc(size, GFP_KERNEL);
>         if (d) {
>                 memcpy(d, data, size);
>                 pdev->dev.platform_data = d;
> 

And here?

-- 
Dmitry
