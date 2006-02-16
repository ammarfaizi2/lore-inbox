Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWBPLde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWBPLde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBPLde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:33:34 -0500
Received: from smtp.net4india.com ([202.71.129.73]:10724 "EHLO
	smx2.net4india.com") by vger.kernel.org with ESMTP id S932198AbWBPLdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:33:33 -0500
Message-ID: <43F46319.9090400@designergraphix.com>
Date: Thu, 16 Feb 2006 17:03:45 +0530
From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Organization: Designer Graphix
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, philippe.seewer@bfh.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: Stuck creating sysfs hooks for a driver..
References: <43F2DE34.60101@designergraphix.com> <20060215221301.GA25941@kroah.com>
In-Reply-To: <20060215221301.GA25941@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Seewer Philippe wrote:

>Hmmm...
>
>I don't know if this'll really help, but have a look at
>drivers/firmware/edd.c

 >Greg KH wrote:

>Have you read Documentation/hwmon/sysfs-interface?  I think that,
>combined with using the hwmon class code is what you want to use here.
>
>Hope this helps,
>
>greg k-h
>
>  
>
Thanks, yes I shall look up both these..at first glance they do look 
promising.

One thing i'd like to point out though, Greg: the LM70 is an 
SPI/Microwire based system and not i2c; so straight away, the i2c 
interface by itself will not be used...; also, the specific board 
(LM70CILD-3, which i've written the 2.4 driver for & am now porting to 
2.6), comes with a built-in parport interface..so that's what the driver 
takes into account of course..

Also it's a relatively simple temperature sensor - it does not seem to 
support hysteresis temperature, i/p voltages, etc. I'm saying all this 
as the sysfs interface i envision is just a simple read-only hook: the 
o/p value (after a little userspace massaging) is the temperature in 
Celsius correct to 0.25 degrees. So it looks to me that this particular 
driver necessitates a kind-of "custom" entry under /sys/class/hwmon with 
it's own userspace support. Do I move ahead in this direction?

Regards,
kaiwan.

