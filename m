Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVLVGr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVLVGr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVLVGrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:47:55 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:64453 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S965071AbVLVGrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:47:55 -0500
Date: Thu, 22 Dec 2005 07:48:50 +0100
From: Alessandro Zummo <azummo-lists@towertech.it>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] RTC subsystem
Message-ID: <20051222074850.01d56f94@inspiron>
In-Reply-To: <43A9E2C9.7080300@hogyros.de>
References: <20051220220022.4e9ff931@inspiron>
	<43A94811.4010704@hogyros.de>
	<20051221160712.2d322f42@inspiron>
	<43A97CAF.50301@hogyros.de>
	<20051221184122.5253df01@inspiron>
	<43A9E2C9.7080300@hogyros.de>
Organization: Tower Technologies
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 00:18:33 +0100
Simon Richter <Simon.Richter@hogyros.de> wrote:

> A good ntpd will adjust the speed rather than write to the clock; the
> ntpd shipped by most distributions can already handle multiple time sources.

 Yes, but there's the kernel who writes to the clock,
 for example http://lxr.linux.no/source/arch/arm/kernel/time.c?a=arm#L103 .

> >  later. The /dev/rtc interface only supports one clock.
> >  It can either be extended to have /dev/rtcX or we
> >  can extend the sysfs one to allow clock updating.
> 
> /dev is the way to go IMO. As far as I've understood sysfs, it carries
> meta information about devices and drivers only, the actual
> communication then happens through device nodes still.

 Ok. We can use dynamic device numbers and go for the /dev
 interface. 

> 
> >  NTP mode could then be adjusted to update one or more
> >  of the rtcs. Maybe each RTC could have an attribute
> >  (let's say /sys/class/rtc/rtcX/ntp) which tells the
> >  kernel whether to update it or not.
> 
> That's entirely a userspace thing. What the userspace needs to know from
> the kernel is whether the clock is writable and whether its speed can be
> adjusted.

 agreed. there are are also some variables of interest in
 http://lxr.linux.no/source/include/linux/timex.h?a=arm#L188
 some of them may be usefully exported in sysfs.
 
 
-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

