Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264475AbTE1BWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 21:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTE1BWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 21:22:47 -0400
Received: from kaneda.boo.net ([216.200.67.189]:44417 "EHLO kaneda.boo.net")
	by vger.kernel.org with ESMTP id S264475AbTE1BWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 21:22:46 -0400
Message-Id: <5.2.1.1.2.20030527211552.00a47190@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 27 May 2003 21:41:12 -0400
To: linux-kernel@vger.kernel.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
In-Reply-To: <20030527180403.A2292@jurassic.park.msu.ru>
References: <20030527123152.GA24849@alpha.home.local>
 <5.2.1.1.2.20030526232835.00a468e0@boo.net>
 <20030527045302.GA545@alpha.home.local>
 <20030527134017.B3408@jurassic.park.msu.ru>
 <20030527123152.GA24849@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:04 PM 5/27/03 +0400, you wrote:
 >
 >Perhaps not that weird. From my experience, ALi DMA is sensitive to
 >some of "PIO timings". That is, if SRM hasn't initialized the chipset
 >properly (on Nautilus it has, BTW), DMA won't work. When you boot with
 >DMA disabled, driver has to set right PIO mode, so you can safely
 >enable DMA later.
 >
 >Can you (and Jason) try this patch with CONFIG_IDEDMA_PCI_AUTO=y?

Sorry, no change. I do get behavior that matches Willy's though: use
hdparm and you can get DMA turned on. Another clue is that the ALI
controller is capable of udma2 (and older kernels achieve that) but even
with hdparm the best I can get seems to be mode mdma2.

Also, I've found that lately I have to attempt to boot from the hard
drive (dqa0) about three times before the kernel finally gets pulled
off of disk. SRM reports a bootstrap failure each time, but otherwise
the system seems to work fine. Has anyone seen this behavior?

Anything else I can do?
jasonp

