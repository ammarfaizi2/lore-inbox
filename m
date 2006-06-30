Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWF3Ugu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWF3Ugu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWF3Ugu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:36:50 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:27318 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1751208AbWF3Ugt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:36:49 -0400
Date: Fri, 30 Jun 2006 22:36:30 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Message-ID: <20060630203630.GB12812@linuxtv.org>
References: <Pine.LNX.4.64.0606300037010.9361@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606300037010.9361@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.230.162
Subject: Re: [v4l-dvb-maintainer] [PATCH] DVB Needs I2C Core
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006, Parag Warudkar wrote:
> DVB seems to be using i2c ( i2c_transfer() mainly ) all over the place but 
> it is possible to build DVB without having I2C selected. This results in 
> undefined symbol i2c_transfer in DVB module.
> 
> This patch makes I2C Core selected automatically if DVB is selected.
> Is it the right thing to do?

No. There are DVB drivers which don't use I2C
(e.g. some of the USB ones). dvb-core doesn't use
I2C at all.
I think most of the dependencies have been corrected
in git already.

Johannes

> --- linux-2.6.17/drivers/media/dvb/Kconfig.orig	2006-06-30 00:15:13.000000000 -0400
> +++ linux-2.6.17/drivers/media/dvb/Kconfig	2006-06-30 00:10:15.000000000 -0400
> @@ -7,6 +7,7 @@ menu "Digital Video Broadcasting Devices
>  config DVB
>  	bool "DVB For Linux"
>  	depends on NET && INET
> +	select I2C
>  	---help---
>  	  Support Digital Video Broadcasting hardware.  Enable this if you
>  	  own a DVB adapter and want to use it or if you compile Linux for

> _______________________________________________
> v4l-dvb-maintainer mailing list
> v4l-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer

