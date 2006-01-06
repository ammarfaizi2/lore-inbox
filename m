Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752520AbWAFRq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbWAFRq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbWAFRq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:46:58 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:44491 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752527AbWAFRq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:46:57 -0500
Date: Fri, 6 Jan 2006 20:46:52 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fix W1_MASTER_DS9490_BRIDGE dependencies
Message-ID: <20060106174651.GB16266@2ka.mipt.ru>
References: <20060106174101.GT12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106174101.GT12131@stusta.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 06 Jan 2006 20:46:52 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:41:01PM +0100, Adrian Bunk (bunk@stusta.de) wrote:
> W1_DS9490 was renamed to W1_MASTER_DS9490, but the entry in the 
> dependencies of W1_MASTER_DS9490_BRIDGE was forgotten.
> 
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

You are 100% correct.
Thank you.

> --- linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig.old	2006-01-06 18:17:23.000000000 +0100
> +++ linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig	2006-01-06 18:17:53.000000000 +0100
> @@ -26,7 +26,7 @@
>  
>  config W1_MASTER_DS9490_BRIDGE
>  	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
> -	depends on W1_DS9490
> +	depends on W1_MASTER_DS9490
>  	help
>  	  Say Y here if you want to communicate with your 1-wire devices
>  	  using DS9490R USB bridge.

-- 
	Evgeniy Polyakov
