Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVFFHRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFFHRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVFFHR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:17:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:25295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261183AbVFFHRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:17:22 -0400
Date: Sun, 5 Jun 2005 23:14:31 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Yani Ioannou <yani.ioannou@gmail.com>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-ID: <20050606061430.GA6240@kroah.com>
References: <2538186705051703479bd0c29@mail.gmail.com> <20050605105146.6f68fc94.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605105146.6f68fc94.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 10:51:46AM +0200, Jean Delvare wrote:
> Hi Yani, all,
> 
> > Finally (phew!) this patch demonstrates how to adapt the adm1026 to
> > take advantage of the new callbacks, and the i2c-sysfs.h defined
> > structure/macros. Most of the other sensor/hwmon drivers could be
> > updated in the same way. The odd few exceptions (bmcsensors for
> > example) however might be better off with their own custom attribute
> > structure.
> 
> I just noticed that this patch has a repeated coding style error:
> 
> +	struct sensor_device_attribute *sensor_attr= to_sensor_dev_attr(attr);
> 
> should be:
> 
> +	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> 
> Can we apply this modified version instead? Or is an incremental patch
> preferred?

I've replaced the version in my tree with this one, thanks.

greg k-h
