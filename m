Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTEETW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTEETW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:22:27 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:56286 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261245AbTEETW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:22:26 -0400
Message-ID: <3EB6BCDF.2020300@wmich.edu>
Date: Mon, 05 May 2003 15:34:55 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au> <20030505165848.GA1249@kroah.com> <3EB6AA01.30601@wmich.edu> <20030505182648.GA1826@kroah.com>
In-Reply-To: <20030505182648.GA1826@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, then the sensors program that is part of the lm_sensors package is 
just not up to date with the drivers since it complains about no 
i2c-proc and has no options for looking at sysfs.

My via686a sensors seem to be working just fine in .69


Greg KH wrote:
> On Mon, May 05, 2003 at 02:14:25PM -0400, Ed Sweetman wrote:
> 
>>hey guys.  Notice a missing proc driver? hint: i2c.    That's why 
>>sensors wont work even when you load the modules. At least that's what i 
>>can tell from what the lm_sensors page mentions and what not.
> 
> 
> Huh?
> The i2c code now interacts to userspace through sysfs, not /proc
> anymore.  CaT is properly looking for his sensors in sysfs.
> 
> Here's what happens when looking through sysfs on my box running 2.5.69:
> 
> # find /sys/ | grep -i i2c
> /sys/bus/i2c
> /sys/bus/i2c/drivers
> /sys/bus/i2c/drivers/lm75
> /sys/bus/i2c/drivers/lm75/0-0048
> /sys/bus/i2c/devices
> /sys/bus/i2c/devices/0-0048
> /sys/devices/pci0/00:1f.3/i2c-0
> /sys/devices/pci0/00:1f.3/i2c-0/0-0048
> /sys/devices/pci0/00:1f.3/i2c-0/0-0048/temp_input
> /sys/devices/pci0/00:1f.3/i2c-0/0-0048/temp_min
> /sys/devices/pci0/00:1f.3/i2c-0/0-0048/temp_max
> /sys/devices/pci0/00:1f.3/i2c-0/0-0048/power
> /sys/devices/pci0/00:1f.3/i2c-0/0-0048/name
> /sys/devices/pci0/00:1f.3/i2c-0/power
> /sys/devices/pci0/00:1f.3/i2c-0/name
> 
> Which is what should be showing up on CaT's machine (of the lm75 device
> is on his hardware.)
> 
> Hope this helps,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


