Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWCDRNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWCDRNP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWCDRNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:13:15 -0500
Received: from mx0.towertech.it ([213.215.222.73]:54705 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751883AbWCDRNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:13:14 -0500
Date: Sat, 4 Mar 2006 18:12:41 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] RTC Subsystem, library functions
Message-ID: <20060304181241.50894c49@inspiron>
In-Reply-To: <20060304165843.GD9295@stusta.de>
References: <20060304164247.963655000@towertech.it>
	<20060304164248.171528000@towertech.it>
	<20060304165843.GD9295@stusta.de>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Mar 2006 17:58:43 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> > +# RTC class/drivers configuration
> > +#
> > +
> > +config RTC_LIB
> > +	bool
> >...
> 
> What about
> 
> config RTC_LIB
>         tristate
> 
> and
> 
> obj-$(CONFIG_RTC_LIB)   += rtc-lib.o
> 
> ?

 The rtc library code is selected also by code that goes in
 arch specific code (arm, for example). I'm not sure it will appropriate
 to use it as a module.

> IOW:
> Is there anything besides adding a MODULE_LICENSE("GPL"); required for 
> allowing an rtc-lib module?

 I think MODULE_LICENSE("GPL") should be enough.

> > --- linux-rtc.orig/drivers/Makefile	2006-02-28 13:16:34.000000000 +0100
> > +++ linux-rtc/drivers/Makefile	2006-02-28 13:16:36.000000000 +0100
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> >  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> >  obj-$(CONFIG_INPUT)		+= input/
> >  obj-$(CONFIG_I2O)		+= message/
> > +obj-y				+= rtc/
> >...
> 
> obj-$(CONFIG_RTC_LIB)	+= rtc/
> 
> should be possible since RTC_CLASS select's RTC_LIB.

 probably yes. will change.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

