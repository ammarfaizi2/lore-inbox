Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVCAJSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVCAJSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVCAJSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:18:54 -0500
Received: from gate.nucleusys.com ([217.79.38.164]:11936 "EHLO
	zztop.nucleusys.com") by vger.kernel.org with ESMTP id S261827AbVCAJSo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:18:44 -0500
Date: Tue, 1 Mar 2005 11:18:23 +0200 (EET)
From: Petko Manolov <petkan@nucleusys.com>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/net/pegasus.c: make some code static
In-Reply-To: <20050301003541.GA4021@stusta.de>
Message-ID: <Pine.LNX.4.61.0503011116430.2909@bender.nucleusys.com>
References: <20050301003541.GA4021@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's reasonable.  Thanks for the patch.


 		Petko



On Tue, 1 Mar 2005, Adrian Bunk wrote:

> This patch makes some needlessly global code static.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
> drivers/usb/net/pegasus.c |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)
>
> --- linux-2.6.11-rc4-mm1-full/drivers/usb/net/pegasus.c.old	2005-02-28 23:26:58.000000000 +0100
> +++ linux-2.6.11-rc4-mm1-full/drivers/usb/net/pegasus.c	2005-02-28 23:27:45.000000000 +0100
> @@ -956,7 +956,8 @@
> 	return 0;
> }
>
> -void pegasus_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
> +static void pegasus_get_drvinfo(struct net_device *dev,
> +				struct ethtool_drvinfo *info)
> {
> 	pegasus_t *pegasus = netdev_priv(dev);
> 	strncpy(info->driver, driver_name, sizeof (info->driver) - 1);
> @@ -1156,10 +1157,10 @@
> }
>
>
> -struct workqueue_struct *pegasus_workqueue = NULL;
> +static struct workqueue_struct *pegasus_workqueue = NULL;
> #define CARRIER_CHECK_DELAY (2 * HZ)
>
> -void check_carrier(void *data)
> +static void check_carrier(void *data)
> {
> 	pegasus_t *pegasus = data;
> 	set_carrier(pegasus->net);
>
>
