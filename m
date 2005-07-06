Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVGFT6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVGFT6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVGFT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:27 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:52130 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262239AbVGFP6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:58:30 -0400
Message-ID: <42CBFF9E.30500@mesatop.com>
Date: Wed, 06 Jul 2005 09:58:22 -0600
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 0x29A (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.13-rc2 (build error with no CONFIG_HOTPLUG_PCI)
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok,
>  -rc3 is pretty small, with the bulk of the diff being some defconfig
> updates, and cleanup of xtensa (notably removal of another copy of zlib).
> 

> Greg Kroah-Hartman:
>   PCI: clean up dynamic pci id logic
>   PCI: Fix up PCI routing in parent bridge

Without CONFIG_HOTPLUG and CONFIG_HOTPLUG_PCI, I got this:

   CC      drivers/pci/pci-driver.o
drivers/pci/pci-driver.c: In function `pci_match_device':
drivers/pci/pci-driver.c:156: error: dereferencing pointer to incomplete type
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `type name'
drivers/pci/pci-driver.c:156: error: request for member `node' in something not a structure or union
drivers/pci/pci-driver.c:156: warning: type defaults to `int' in declaration of `__mptr'
drivers/pci/pci-driver.c:156: warning: initialization from incompatible pointer type
[snipped similar errors/warnings]
make[2]: *** [drivers/pci/pci-driver.o] Error 1
make[1]: *** [drivers/pci] Error 2
make: *** [drivers] Error 2

Setting CONFIG_HOTPLUG=y and CONFIG_HOTPLUG_PCI=y allowed 2.6.13-rc2 to build/boot/run.

Steven

-- 
This e-mail contains no programmatic content requiring independent ADC review.

