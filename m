Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTLAHYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTLAHYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:24:39 -0500
Received: from fmr04.intel.com ([143.183.121.6]:11920 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263504AbTLAHYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:24:36 -0500
Subject: Re: acpi poweroff problem (kernel > 2.4.23-rc1)
From: Len Brown <len.brown@intel.com>
To: Jan Bernatik <bernatik@kn.vutbr.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184CEA9@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184CEA9@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070263443.2513.4.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Dec 2003 02:24:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan,

Probably best to file a bug against this one.

thanks,
-Len


How to file a bug against ACPI:

http://bugzilla.kernel.org/
Category: Power Management
Component: ACPI

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz

Please attach dmesg output showing the failure, if possible.


On Sun, 2003-11-30 at 11:11, Jan Bernatik wrote:
> I upgraded (after some time) from
> 2.4.23-rc1 to 2.4.23 and encountered problem with poweroff (I think)
> similar to:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=1456
> 
> but difference is it worked for me with 2.4.23-rc1.
> I located problem to change from rc1 to rc2 finally.
> I tried then also all 2.6.0-test4 and newer kernels, same problem.
> 
> I think it has somethink to do with this mentioned in rc2 release:
>   o [ACPI] If ACPI is disabled by DMI BIOS date, then turn it off
> completely, \
> (taken from: http://lkml.org/lkml/2003/11/19/44)
> but couldn't find out more.
> 
> what happenes is that after "power off", monitor is switched off, hdd
> semms to be switched off too, but leds indicating "power on" are still
> "shining", and fan is working.
> I have to swith laptop manually and then turn it on again.
> I searched the logs, but didn't found anything interesting.
> One thing have to be mentioned, I have to use
> acpi="force" boot option
> (ACPI disabled because your bios is from 92 and too old)
> 
> 
> using:
> Linux version 2.4.23-rc2 (gcc version 2.95.4 20011002)
> 
> compiled with acpi options:
> 
> CONFIG_ACPI=y
> CONFIG_ACPI_BOOT=y
> CONFIG_ACPI_BUS=y
> CONFIG_ACPI_INTERPRETER=y
> CONFIG_ACPI_EC=y
> CONFIG_ACPI_POWER=y
> CONFIG_ACPI_PCI=y
> CONFIG_ACPI_SLEEP=y
> CONFIG_ACPI_SYSTEM=y
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_FAN=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_THERMAL=y
> # CONFIG_ACPI_ASUS is not set
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_ACPI_DEBUG=y
> CONFIG_ACPI_RELAXED_AML=y
> 
> hardware:
> centrino laptop without Intel wireless card :)
> (4-months old)
> pentium-M, intel 855PM chipset
> phoenix bios (could't found any real information at support), but
> maual
> to laptop says "BIOS corresponding to ACPI".
> 
> I can provide logs, dmesg's from rc1 & rc2 kernel, or some more
> information, if You need more.
> I'm new to linux kernel, sorry I couldn't find more.
> 
> Honza
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

