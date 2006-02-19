Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWBSW1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWBSW1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWBSW1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:27:15 -0500
Received: from mx0.towertech.it ([213.215.222.73]:25319 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1751104AbWBSW1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:27:14 -0500
Date: Sun, 19 Feb 2006 23:26:43 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Alessandro Zummo <azummo-vger@towertech.it>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] RTC subsystem, sysfs interface
Message-ID: <20060219232643.122b4aab@inspiron>
In-Reply-To: <200602132247.17653.dtor_core@ameritech.net>
References: <20060213225416.865078000@towertech.it>
	<20060213225417.706366000@towertech.it>
	<200602132247.17653.dtor_core@ameritech.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 22:47:17 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> > +	struct rtc_time tm;
> > +
> > +	if ((retval = rtc_read_time(dev, &tm)) == 0) {
> 
> Retval is set unconditionally here so there is no point in initializing
> it to -ENODEV above.

> > +static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
> > +					   struct class_interface *class_intf)
> > +{
> > +	class_device_create_file(class_dev, &class_device_attr_name);
> > +	class_device_create_file(class_dev, &class_device_attr_date);
> > +	class_device_create_file(class_dev, &class_device_attr_time);
> > +	class_device_create_file(class_dev, &class_device_attr_since_epoch);
> 
> Maybe using attribute group here will help and also allow easier error
> hanling?

 done, thanks.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

