Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbULNP0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbULNP0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbULNP0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:26:22 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:30689 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261521AbULNP0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:26:15 -0500
Date: Tue, 14 Dec 2004 16:25:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041214152558.GB16322@dualathlon.random>
References: <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random> <20041214095939.GC1063@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214095939.GC1063@elf.ucw.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 10:59:39AM +0100, Pavel Machek wrote:
> Are you using CONFIG_HPET_TIMER by chance? It seems to be missing some
> strategic -1, TSC (etc) get it right.

I'm not using hpet because it's an old hardware, this is with timer_tsc.
It must be reproducible in any machine out there, especially with
machines with usb it should be reproducible even without any userspace
testcase doing iopl/cli/sti. Time will go silenty in the future at every
usb irq (they often last 3/4msec).
