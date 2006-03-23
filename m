Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbWCWWdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWCWWdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWCWWdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:33:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:38599 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932518AbWCWWdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:33:04 -0500
Message-ID: <4423221D.6020109@garzik.org>
Date: Thu, 23 Mar 2006 17:33:01 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lower e100 latency
References: <20060323014046.2ca1d9df.akpm@osdl.org>	<20060323220711.28fcb82f@werewolf.auna.net> <20060323221342.2352789d@werewolf.auna.net>
In-Reply-To: <20060323221342.2352789d@werewolf.auna.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
>  	if (unlikely(!i)) {
> -		printk("e100.mdio_ctrl(%s) won't go Ready\n",
> +		DPRINTK(PROBE, ERR, "e100.mdio_ctrl(%s) won't go Ready\n",
>  			nic->netdev->name );

NAK.  Its already unlikely, and if this fails, you SHOULD print 
something out.  The rest seems mostly OK.

	Jeff


