Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKOVLL>; Wed, 15 Nov 2000 16:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKOVLA>; Wed, 15 Nov 2000 16:11:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37906 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129148AbQKOVKs>;
	Wed, 15 Nov 2000 16:10:48 -0500
Message-ID: <3A12F4AD.6BA039B3@mandrakesoft.com>
Date: Wed, 15 Nov 2000 15:40:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: randy.dunlap@intel.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_USB_HOTPLUG (was Patch(?): 
 linux-2.4.0-test11-pre4/drivers/sound/yss225.c  compile failure)
In-Reply-To: <200011151745.JAA02400@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> You were right: the
> __devinitdata being used in the USB drivers will probably crash the
> kernel if CONFIG_HOTPLUG is not defined and the USB code attempts to
> recover from an error by faking disconnect/reconnect.
[...]
>         Until there is __usbdev{init,exit}{,data}, the incorrect
> __devinitdata qualifiers should be removed from the USB device
> drivers (but not from the host controller drivers, which are PCI drivers).

If a user hotplugs a device into a kernel which does not support
CONFIG_HOTPLUG, they are shooting themselves in the foot.

I don't see that __devinitdata should be removed.

*plonk*

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
