Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUDSNkC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUDSNjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:39:08 -0400
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:46346 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S264426AbUDSNiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:38:13 -0400
Date: Mon, 19 Apr 2004 15:37:59 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: fr
MIME-Version: 1.0
To: Jan Kasprzak <kas@informatics.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
References: <20040419120132.GP23938@fi.muni.cz>
In-Reply-To: <20040419120132.GP23938@fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Message-Id: <S264426AbUDSNiN/20040419133854Z+431@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak a écrit le 19.04.2004 14:01:
> 
> I have two systems with Tyan S2882 boards (K8S Pro). The sensors chip is
> Winbond w83627hf according to the mainboard documentation.  The w83627hf 
> driver can read values from the sensors, but apparently not all values. The
> board has six fan connectors (two labeled CPU1 fan and CPU2 fan, and four
> chassis fans). BIOS displays the fan status correctly for all fans, so all
> fans are connected to the sensors chip. However, there are only three fans
> listed in /sys/devices/platform/i2c-1/1-0290.


Probably unrelated to your problem, but isn't there a typo in 
drivers/i2c/chips/Kconfig ? maybe patch below ?

--
Fabian


diff -Nru drivers/i2c/chips/Kconfig.orig drivers/i2c/chips/Kconfig
--- drivers/i2c/chips/Kconfig.orig      Fri Apr 16 11:12:17 2004
+++ drivers/i2c/chips/Kconfig   Mon Apr 19 15:23:48 2004
@@ -158,7 +158,7 @@
           will be called via686a.

  config SENSORS_W83781D
-       tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
+       tristate "Winbond W83781D, W83782D, W83783S, W83682HF, Asus AS99127F"
         depends on I2C && EXPERIMENTAL
         select I2C_SENSOR
         help

