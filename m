Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbVICIWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbVICIWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbVICIWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 04:22:15 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:49167 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1161186AbVICIWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 04:22:14 -0400
Date: Sat, 3 Sep 2005 10:22:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Greg KH <greg@kroah.com>, LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: i2c via686a.c: save at least 0.5k of space by long v[256] ->
 u16 v[256]
Message-Id: <20050903102227.03312247.khali@linux-fr.org>
In-Reply-To: <200509020854.37192.vda@ilport.com.ua>
References: <200509010910.14824.vda@ilport.com.ua>
	<20050901155915.GB1235@kroah.com>
	<200509020854.37192.vda@ilport.com.ua>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

> --- linux-2.6.12.src/drivers/i2c/chips/via686a.c.orig	Sun Jun 19 16:10:10 2005
> +++ linux-2.6.12.src/drivers/i2c/chips/via686a.c	Tue Aug 30 00:21:39 2005
> @@ -205,7 +205,7 @@ static inline u8 FAN_TO_REG(long rpm, in
>   but the function is very linear in the useful range (0-80 deg C), so 
>   we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
>   is the temp at via register values 0-255: */
> -static const long tempLUT[] =
> +static const s16 tempLUT[] =
>      { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
>  	    -503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
>  	    -362, -350, -339, -327, -316, -305, -295, -285, -275, -265,

This patch doesn't apply on top of my stack, first because the hardware
monitoring drivers have been moved to drivers/hwmon, second because the
via686a driver had indentation cleanups since 2.6.12.

Could you please provide this patch against 2.6.13-mm1?

Thanks,
-- 
Jean Delvare
