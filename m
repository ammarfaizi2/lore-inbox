Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263272AbVCKK36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbVCKK36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVCKK36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:29:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29313 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263259AbVCKK3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:29:42 -0500
Date: Fri, 11 Mar 2005 11:29:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Message-ID: <20050311102920.GB30252@elf.ucw.cz>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As many of you will be aware, we've been working on infrastructure for
> user-mode PCI and other drivers.  The first step is to be able to
> handle interrupts from user space. Subsequent patches add
> infrastructure for setting up DMA for PCI devices.
> 
> The user-level interrupt code doesn't depend on the other patches, and
> is probably the most mature of this patchset.

Okay, I like it; it means way easier PCI driver development.

But... how do you handle shared PCI interrupts?

> This patch adds a new file to /proc/irq/<nnn>/ called irq.  Suitably 
> privileged processes can open this file.  Reading the file returns the 
> number of interrupts (if any) that have occurred since the last read.
> If the file is opened in blocking mode, reading it blocks until 
> an interrupt occurs.  poll(2) and select(2) work as one would expect, to 
> allow interrupts to be one of many events to wait for.
> (If you didn't like the file, one could have a special system call to
> return the file descriptor).

This should go into Documentation/ somewhere.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
