Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbULPNum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbULPNum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbULPNul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:50:41 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:386 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261385AbULPNuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:50:37 -0500
Subject: Re: Time goes crazy in 2.6.9 after long cli [was Re: USB making
	time drift]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216111343.GI28286@dualathlon.random>
References: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
	 <20041213112853.GS16322@dualathlon.random>
	 <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
	 <20041213125844.GY16322@dualathlon.random>
	 <20041213191249.GB1052@elf.ucw.cz>
	 <20041214023651.GT16322@dualathlon.random>
	 <20041214095939.GC1063@elf.ucw.cz>
	 <20041214152558.GB16322@dualathlon.random>
	 <20041214220239.GA19221@elf.ucw.cz> <20041216011549.GD6285@elf.ucw.cz>
	 <20041216111343.GI28286@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103201365.3804.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 12:49:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 11:13, Andrea Arcangeli wrote:
> Well, I was pretty sure it was reproducible since the PIT and TSC are
> standard hw in all machines, it's just the excessive usb irq latency

TSC is not by any means standard hw in all machines and it has a whole
pile of issues on some of them with the way it varies rate and/or stops.

> My suggestion is that first we fix the accuracy of this, and *then* we
> consider switching to a one-short timer.

Agreed - one shot timers are going to be nearly impossible to use for
system time accounting because we keep losing time resetting it.



