Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVLUWEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVLUWEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVLUWEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:04:46 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:49931 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932217AbVLUWEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:04:46 -0500
Date: Wed, 21 Dec 2005 23:07:25 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Gene Heskett <gene.heskett@verizononline.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
Message-Id: <20051221230725.4a4851fa.khali@linux-fr.org>
In-Reply-To: <200512211551.39092.gene.heskett@verizon.net>
References: <200512201505.43199.gene.heskett@verizon.net>
	<20051220151616.c8bdc00c.akpm@osdl.org>
	<20051221191955.408c5151.khali@linux-fr.org>
	<200512211551.39092.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

Please keep this conversation on the LKML, where it started.

> > Are you getting the temperature value from ACPI, or from a hwmon
> > driver? If the latter, which driver is this, and which hardware
> > monitoring chip do you have?
> 
> Its coming from whatever source gkrellm-2.1.28 uses as the default src 
> for this, selecting other src's results in -200F or more readings.  
> Rebooting back to -rc5, the readings are normal but creeping up, about 
> 152F right now.

That's hardly helpful. If gkrellm doesn't tell you where the data comes
from, we just can't use it to debug any issue. Please use "sensors"
instead.

> >From sensors-detect:
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Success!
>     (confidence 8, driver `w83781d')
> 
> What else?

This is only one part of sensors-detect. I guess it then suggests the
w83627hf driver instead. Which driver are you using, w83627hf or
w83781d?

Please provide:

1* The complete output of sensors-detect.

2* The output of "sensors" in 2.6.15-rc5.

3* The output of "sensors" in 2.6.15-rc6.

4* The diff of your 2.6.15-rc5 kernel config file and 2.6.15-rc6
kernel config file.

Thanks,
-- 
Jean Delvare
