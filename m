Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbULMMnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbULMMnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbULMMnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:43:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52444 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262244AbULMMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:43:14 -0500
Date: Mon, 13 Dec 2004 13:43:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213124313.GB29426@atrey.karlin.mff.cuni.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213112853.GS16322@dualathlon.random>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well most x86(64) these days have local APICs and that provides a 
> > relatively inexpensive one shot timer mode.
> 
> I doubt a one shot is appropriate. The irq latency is variable and we
> won't be able to atomically read tsc and rearm the one-shot timer. The
> intemediate error will propagate over time.

But that does not matter, right? Yes, one-shot timer will not fire
exactly at right place, but as long as you are reading TSC and basing
next shot on current time, error should not accumulate.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
