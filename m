Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTK3QJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTK3QJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:09:24 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:49679 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id S264933AbTK3QJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:09:21 -0500
Message-ID: <3FCA16AD.7090809@kn.vutbr.cz>
Date: Sun, 30 Nov 2003 17:11:25 +0100
From: Jan Bernatik <bernatik@kn.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: andrew.grover@intel.com
Subject: acpi poweroff problem (kernel > 2.4.23-rc1)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded (after some time) from
2.4.23-rc1 to 2.4.23 and encountered problem with poweroff (I think) 
similar to:

http://bugzilla.kernel.org/show_bug.cgi?id=1456

but difference is it worked for me with 2.4.23-rc1.
I located problem to change from rc1 to rc2 finally.
I tried then also all 2.6.0-test4 and newer kernels, same problem.

I think it has somethink to do with this mentioned in rc2 release:
  o [ACPI] If ACPI is disabled by DMI BIOS date, then turn it off 
completely, \
(taken from: http://lkml.org/lkml/2003/11/19/44)
but couldn't find out more.

what happenes is that after "power off", monitor is switched off, hdd 
semms to be switched off too, but leds indicating "power on" are still 
"shining", and fan is working.
I have to swith laptop manually and then turn it on again.
I searched the logs, but didn't found anything interesting.
One thing have to be mentioned, I have to use
acpi="force" boot option
(ACPI disabled because your bios is from 92 and too old)


using:
Linux version 2.4.23-rc2 (gcc version 2.95.4 20011002)

compiled with acpi options:

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_RELAXED_AML=y

hardware:
centrino laptop without Intel wireless card :)
(4-months old)
pentium-M, intel 855PM chipset
phoenix bios (could't found any real information at support), but maual 
to laptop says "BIOS corresponding to ACPI".

I can provide logs, dmesg's from rc1 & rc2 kernel, or some more 
information, if You need more.
I'm new to linux kernel, sorry I couldn't find more.

Honza

