Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUAXVRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUAXVRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:17:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33764 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262055AbUAXVR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:17:27 -0500
Message-ID: <4012E0DA.7050808@pobox.com>
Date: Sat, 24 Jan 2004 16:17:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bryan Whitehead <driver@megahappy.net>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       tulip-users@lists.sourceforge.net
Subject: Re: [PATCH 2.6.2-rc1-mm2] drivers/net/tulip/tulip_core.c
References: <20040124080217.ED53113A354@mrhankey.megahappy.net>
In-Reply-To: <20040124080217.ED53113A354@mrhankey.megahappy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Whitehead wrote:
> This fixes a warning if CONFIG_NET_POLL_CONTROLLER is NOT set.
> 
> --- drivers/net/tulip/tulip_core.c.orig 2004-01-23 23:53:17.484261904 -0800
> +++ drivers/net/tulip/tulip_core.c      2004-01-23 23:53:53.675759960 -0800
> @@ -253,7 +253,9 @@
>  static struct net_device_stats *tulip_get_stats(struct net_device *dev);
>  static int private_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
>  static void set_rx_mode(struct net_device *dev);
> +#ifdef CONFIG_NET_POLL_CONTROLLER
>  static void poll_tulip(struct net_device *dev);
> +#endif


Hum... doesn't apply here, and also it breaks my automated
"patch -sp1 < patch" script :/


