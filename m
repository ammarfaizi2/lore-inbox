Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbTJCFf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 01:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263682AbTJCFf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 01:35:27 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:50647 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263663AbTJCFfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 01:35:21 -0400
Message-ID: <3F7D0A96.7040902@wmich.edu>
Date: Fri, 03 Oct 2003 01:35:18 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Philippe_Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [2.6.0-test5-mm2] no /proc/bus/i2c but i2c-core module loaded
 + small oops
References: <20031003043053.367eb89c.philippe.gramoulle@mmania.com>
In-Reply-To: <20031003043053.367eb89c.philippe.gramoulle@mmania.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Go check out sysfs.  i2c no longer uses proc. AFAIK system related proc 
entries will all move to sysfs.


No idea about the rmmod error.


Philippe Gramoullé wrote:
>  Hello,
> 
> Symptoms: modprobe i2c-core works fine but /proc/bus/i2c doesn't exist
> 
> Kernel  : Stock 2.6.0-test5-mm2
> Distro  : Debian Sid + 2.8 lm-sensors user space utilities
> Hardware: Dell WS 530MT SMP Xeon 1.5 Ghz, Intel Motherboard Chipset: 82801BA , ADM1023
> 	  00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
> 
> Also while rmmoding  i2c-dev module, i got the following message:
> 
> 
> Device class 'i2c-0' does not have a release() function, it is broken and must be fixed.
> Badness in class_dev_release at drivers/base/class.c:200
> 
> Call Trace:
>  [<c0227ef5>] kobject_cleanup+0x75/0x80
>  [<e0b42c3a>] i2cdev_detach_adapter+0x2a/0x40 [i2c_dev]
>  [<e0b3b7e9>] i2c_del_driver+0x1d9/0x230 [i2c_core]
>  [<e0b42c92>] i2c_dev_exit+0x12/0x37 [i2c_dev]
>  [<c013ac33>] sys_delete_module+0x133/0x160
>  [<c0152274>] sys_munmap+0x44/0x70
>  [<c0386e13>] syscall_call+0x7/0xb
> 
> 
> Thanks,
> 
> Philippe
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


