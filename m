Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318281AbSGRRlV>; Thu, 18 Jul 2002 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSGRRlV>; Thu, 18 Jul 2002 13:41:21 -0400
Received: from breeze.research.telcordia.com ([192.4.6.9]:55177 "EHLO
	breeze.research.telcordia.com") by vger.kernel.org with ESMTP
	id <S318281AbSGRRlU>; Thu, 18 Jul 2002 13:41:20 -0400
Date: Thu, 18 Jul 2002 13:44:07 -0400
From: Allen McIntosh <mcintosh@research.telcordia.com>
Message-Id: <200207181744.NAA24845@mc-pc.research.telcordia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 and 19-rc1 IDE lockup on Dell Latitude
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.18 and 2.4.19-rc1 lock up after a suspend/resume on my Dell Latitude
CPi D300XT.

To recreate:  Suspend (using the suspend key, by closing the top, or
using the apm command), then hit the power button for resume.  When the
system wakes up some IDE I/O occurs (with flashing disk light and
audible head motion), then the disk light comes on and stays on.
Switching consoles is possible, and typed characters echo, but
no commands run.  The system can be powered down by holding the power
button down for 10 seconds, but that's about it.

The system seems stable otherwise.  It stayed up all last weekend, for
example.

If you wait in the locked state long enough, the 2.4.14 and 2.4.18 kernels
usually (but not always) output the following to the console:

hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14

Kernel versions I've tried this on:

2.4.14, 2.4.18 (vanilla), 2.4.18-3 (RedHat), 2.4.19-rc1, 2.4.19-rc1-ac5


4-year old stuff on http://www.pihl.org/linux/linux-dell.html associates
a similar problem with pcmcia being active; however I get the same
symptoms without loading any pcmcia related modules.

I can provide more details to interested parties; willing to apply/try
patches.

