Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWGWNLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWGWNLE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 09:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWGWNLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 09:11:04 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:34564 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750881AbWGWNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 09:11:03 -0400
Message-ID: <44C37565.6090009@superbug.co.uk>
Date: Sun, 23 Jul 2006 14:11:01 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.4 (X11/20060609)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cross platform method for detecting hot unplug in irq handler
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am writing a driver for a PCMCIA device.
When the card is removed, the driver's IRQ handler is called.
The first thing the IRQ handler does is read a status register from the
card's IOPORT. On the ia32 (i386) platform, the resulting status read
will return 0xffffffff. If the driver reads this value, it assumes the
card has been removed and acts accordingly.

Is this a reliable way of detecting PCMCIA or Hotplug card removal
inside an IRQ handler?
Is it consistent cross platforms. E.g. ia64, amd64, PPC, MIPS etc.?
Does a more reliable detection method exist in the kernel?

James
