Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbUJ0Wth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbUJ0Wth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUJ0WsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:48:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:18411 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262746AbUJ0Won (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:44:43 -0400
Subject: Re: Strange IO behaviour on wakeup from sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <417FAE3F.20908@vmware.com>
References: <417FAE3F.20908@vmware.com>
Content-Type: text/plain
Date: Thu, 28 Oct 2004 08:40:31 +1000
Message-Id: <1098916831.9478.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 07:18 -0700, Zachary Amsden wrote:

> I would tend to be very suspicious of DMA not being restored correctly 
> because on some systems, prior to or during suspend, DMA may be shutdown 
> to conserve power.  There are changes afloat that touch suspend/resume, 
> and there have been historical problems with DMA not being restored 
> properly after wakeup on some laptops.

DMA is restored, and the resulting is way slower than what PIO would
explain anyway. I get less than 100Kb/sec !

(I wrote the IDE suspend/resume code and the driver for this chipset, so
I'm fairly sure that side is ok, it didn't change for a while, but I'll
double check in case Bart latest updates broke something).

> Although this may be another shot in the dark, it might rule out the DMA 
> problem:  try cat /proc/ide/yourchipset before and after suspend and 
> note any changes.  Failing that, use hdparm to turn off DMA before 
> suspend and see if the performance suffers to the same degree as after 
> wakeup.

Tried all of that.

Ben.


