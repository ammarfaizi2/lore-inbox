Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVIQLlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVIQLlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVIQLlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:41:31 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:772 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751079AbVIQLlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:41:31 -0400
X-ME-UUID: 20050917114123631.9A35D1C001CB@mwinf0809.wanadoo.fr
Message-ID: <432C00C6.20305@zarb.org>
Date: Sat, 17 Sep 2005 13:40:54 +0200
From: trem <trem@zarb.org>
User-Agent: Mozilla Thunderbird 1.0.6-5mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dependance loop on 2.6.14-rc1-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've tried to compile a 2.6.14-rc1-mm1 on my amd64. When I do the make 
modules_install,
I have this warning:

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F 
System.map  2.6.14-rc1-mm1; fi
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/serial_cs.ko ignored, 
due to loop
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/serial_core.ko 
ignored, due to loop
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250_pnp.ko ignored, 
due to loop
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250_pci.ko ignored, 
due to loop
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250_acpi.ko ignored, 
due to loop
WARNING: Loop detected: 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250.ko needs 
serial_core.ko which needs 8250.ko again!
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250.ko ignored, due 
to loop
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/parport/parport_serial.ko 
ignored, due to loop
WARNING: Module 
/lib/modules/2.6.14-rc1-mm1/kernel/drivers/char/mwave/mwave.ko ignored, 
due to loop



You can found the .config I've used here : 
http://www.zarb.org/~trem/config_loop.txt

It's a allmodconfig config with  all ISDN and "Digi International NEO 
PCI Support" set to OFF.
I've "removed" both option because they generate error when compiling.

I don't understand why I have this warning.

Thanks for any help,
trem




