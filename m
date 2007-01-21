Return-Path: <linux-kernel-owner+w=401wt.eu-S1750942AbXAUAXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXAUAXr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 19:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXAUAXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 19:23:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:2258 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbXAUAXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 19:23:46 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kY3mulFc2PP9PIpP6m1SQrkeZm7CF5/dVITAg6YER+D0NkJpoDhhAOVBIm768qtP0GMQI1KwfaQQyI75E3JqbZZfZk2ynawE49vwGFM4nKSf90wjkd38cbGKRomuht/udE9Dht/XEk9hP7aKNnOgrjf5B4aJPF5TXxrZ6vtVzV0=
Message-ID: <8d158e1f0701201623q1519c6e7m334f0c702553b666@mail.gmail.com>
Date: Sun, 21 Jan 2007 01:23:44 +0100
From: "Patrick Ale" <patrick.ale@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: pata_sil680 module, udev and changing drive node order
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am using kernel 2.6.19 with the new pata and sata drivers.
First of all, the drivers work great, no crashes nothing.

There is one downside i found by using these drivers, and i am not
sure how i can fix this.

The drivers load correctly but my drives seem to be in a different
order all the time, which is not very convinient when your run md
devices.

I have a pata_via driver, which is built-in to the kernel since it
serves my primary and secundary ATA controller.
I have a pata_pdc2027x driver, serving the 3rd and 4th ATA controller
on the motherboard. (as module)
I have a pata_sil680 driver serving 2 PCI add-in cards (as module)
I have a sata_sil driver for the onboard sata controller. (as module)

What seems to happen is that either the modules are auto-loaded and
that the pata_sil680 driver changes the order of the two PCI cards
every reboot or that udev gets different events from different
controllers as first after every reboot and therefor creates the
device nodes different.

So, my question is: how do I force a fixed order for a module handling
two PCI cards, or how do I tell udev to always use the same mapping
for the device nodes in /dev?

Thanks,
