Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTIXQES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTIXQES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:04:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:20915 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261440AbTIXQEQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:04:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sysfs - which driver for a device?
Date: Wed, 24 Sep 2003 09:03:21 +0000
User-Agent: KMail/1.4.1
References: <20030924020344.55460.qmail@web14905.mail.yahoo.com>
In-Reply-To: <20030924020344.55460.qmail@web14905.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309240903.22042.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday 24 September 2003 02:03 am, Jon Smirl wrote:
> In sysfs it is easy to see which devices a driver is supporting.
> For example /sys/bus/pci/drivers/e1000 links to 0000:02:0c.0 in my system.
>
> But how do you go the other way; starting from 0000:02:0c.0 to determine
> the driver? Is the best solution to loop though the drivers directories
> searching for the device? Or would it be better to change sysfs to add an
> attribute to each device containing the driver name?
>
> In /proc/bus/pci/devices the driver name is the last field.


Have you looked at libsysfs? You can query for a sysfs_device, which includes 
the name of the driver. Libsysfs' goal is to provide an easy interface for 
retrieving such information. The library should also reduce the need for 
adding extra references or attributes in the kernel. 

Libsysfs is included in the sysfsutils package that also contains systool, a 
command to view system information exposed through sysfs. 

Sysfsutils can be found at:

http://linux-diag.sourceforge.net/

Thanks,

Dan



> =====
> Jon Smirl
> jonsmirl@yahoo.com
>
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site design software
> http://sitebuilder.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

