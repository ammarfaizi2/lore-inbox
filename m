Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUDSPSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUDSPSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:18:21 -0400
Received: from zone3.gcu-squad.org ([217.19.50.74]:19986 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261378AbUDSPST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:18:19 -0400
Message-ID: <1082387882.4083edaa52780@imp.gcu.info>
Date: Mon, 19 Apr 2004 17:18:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Fabian Fenaut <fabian.fenaut@free.fr>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors (W83627HF) in Tyan S2882
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabian,

> Probably unrelated to your problem, but isn't there a typo in 
> drivers/i2c/chips/Kconfig ? maybe patch below ?
> 
> diff -Nru drivers/i2c/chips/Kconfig.orig drivers/i2c/chips/Kconfig
> --- drivers/i2c/chips/Kconfig.orig      Fri Apr 16 11:12:17 2004
> +++ drivers/i2c/chips/Kconfig   Mon Apr 19 15:23:48 2004
> @@ -158,7 +158,7 @@
>            will be called via686a.
> 
>  config SENSORS_W83781D
> -       tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus
AS99127F"
> +       tristate "Winbond W83781D, W83782D, W83783S, W83682HF, Asus
AS99127F"
>          depends on I2C && EXPERIMENTAL
>          select I2C_SENSOR
>          help

Nice catching. However the fix is not correct. "W83627HF" is the correct
name and "W83682HF" is the typo.

Care to send the correct fix to Greg? Please CC: me or the lm_sensors
mailing-list so that I can enqueue the patch on my side.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

