Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWAES2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWAES2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWAES2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:28:00 -0500
Received: from mail.gmx.net ([213.165.64.21]:29916 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750796AbWAES17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:27:59 -0500
X-Authenticated: #453372
Message-ID: <43BD6572.9090100@gmx.net>
Date: Thu, 05 Jan 2006 19:29:06 +0100
From: Daniel Paschka <monkey20181@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ipw2200] add monitor and qos entries to Kconfig
References: <5rHzm-7c4-21@gated-at.bofh.it>
In-Reply-To: <5rHzm-7c4-21@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Happe wrote:

> Add the following config entries for the ipw2200 driver to
> drivers/net/wireless/Kconfig
>  * IPW2200_MONITOR
>    enables Monitor mode
>  * IPW2200_QOS
>    enables QoS feature - this is under development right now, so it depends 
>    upon EXPERIMENTAL
> 
> driver compiles and enters monitor mode.
> 
> Signed-off-by: Andreas Happe <andreashappe@snikt.net>
> --- drivers/net/wireless/Kconfig.orig	2006-01-05 18:30:10.000000000 +0100
> +++ drivers/net/wireless/Kconfig	2006-01-05 18:30:13.000000000 +0100
> @@ -217,6 +217,19 @@ config IPW2200
>            say M here and read <file:Documentation/modules.txt>.  The module
>            will be called ipw2200.ko.
>  
> +config IPW2200_MONITOR
> +        bool "Enable promiscuous mode"
> +        depends on IPW2200
> +        ---help---
> +	  Enables promiscuous/monitor mode support for the ipw2200 driver.
> +	  With this feature compiled into the driver, you can switch to 
> +	  promiscuous mode via the Wireless Tool's Monitor mode.  While in this
> +	  mode, no packets can be sent.
> +
> +config IPW2200_MONITOR
> +        bool "Enable QoS support"
> +        depends on IPW2200 && EXPERIMENTAL
> +
>  config IPW_DEBUG
>  	bool "Enable full debugging output in IPW2200 module."
>  	depends on IPW2200

I think you made a copy&paste error here. QoS is enabling monitor mode.
You probably meant IPW_QOS.
