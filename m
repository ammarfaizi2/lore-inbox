Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWEROJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWEROJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 10:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWEROJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 10:09:52 -0400
Received: from math.ut.ee ([193.40.36.2]:55251 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750798AbWEROJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 10:09:52 -0400
Date: Thu, 18 May 2006 17:09:47 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: How to enable bios-disabled soundcard?
Message-ID: <Pine.SOC.4.61.0605181650080.4469@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Context: IBM X20 laptop with integrated PCI CS4281 soundcard. Loading 
snd_cs4281 gives these messages and registers no alsa device:

ACPI: PCI interrupt for device 0000:00:0b.0 disabled
CS4281: probe of 0000:00:0b.0 failed with error -5

Error -5 seems to be -EIO.

There is no option ib bios to enable/disable the soundcard and the bios 
is almost the latest (2.23, latest 2.25 fixes only unrelated things by 
changelog).

lspci identifies the card as follows (pci ID is the same as in the 
driver):
0000:00:0b.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI Audio (rev 01)

I tried pci=routeirq. It distributed the interrupts differently but this 
problem did remain.

I tried acpi=ogg and the ACPI line disappeared but probe failure stayed.

So how can I enable the soundcard?

-- 
Meelis Roos (mroos@linux.ee)
