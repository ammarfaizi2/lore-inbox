Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030584AbWAHJlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbWAHJlB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWAHJlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:41:00 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:51332 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030582AbWAHJk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:40:59 -0500
Date: Sun, 8 Jan 2006 12:40:54 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Patrick McHardy <kaber@trash.net>
Cc: Kernel Netdev Mailing List <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       GregKH <greg@kroah.com>
Subject: Re: [W1]: Remove incorrect MODULE_ALIAS
Message-ID: <20060108094054.GA21124@2ka.mipt.ru>
References: <43C0524F.1030602@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C0524F.1030602@trash.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 08 Jan 2006 12:40:55 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:44:15AM +0100, Patrick McHardy (kaber@trash.net) wrote:

> [W1]: Remove incorrect MODULE_ALIAS
> 
> The w1 netlink socket is created by a hardware specific driver calling
> w1_add_master_device, so there is no point in including a module alias
> for netlink autoloading in the core.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>

ACK.
Thanks, Patrick.

> ---
> commit a8657adb8c04bbe30544306ec55005a635ba65fd
> tree 2c029cf104239958220629d34c76c7290bd99e43
> parent b73952761225e41cb81afe157cb312a594a95693
> author Patrick McHardy <kaber@trash.net> Sun, 08 Jan 2006 00:42:42 +0100
> committer Patrick McHardy <kaber@trash.net> Sun, 08 Jan 2006 00:42:42 +0100
> 
>  drivers/w1/w1_int.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
> index c3f67ea..e2920f0 100644
> --- a/drivers/w1/w1_int.c
> +++ b/drivers/w1/w1_int.c
> @@ -217,5 +217,3 @@ void w1_remove_master_device(struct w1_b
>  
>  EXPORT_SYMBOL(w1_add_master_device);
>  EXPORT_SYMBOL(w1_remove_master_device);
> -
> -MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_W1);


-- 
	Evgeniy Polyakov
