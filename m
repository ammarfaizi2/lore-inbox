Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbULNWLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbULNWLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULNWIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:08:38 -0500
Received: from gprs214-149.eurotel.cz ([160.218.214.149]:33664 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261691AbULNWDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:03:02 -0500
Date: Tue, 14 Dec 2004 23:02:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: USB making time drift [was Re: dynamic-hz]
Message-ID: <20041214220239.GA19221@elf.ucw.cz>
References: <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com> <20041213112853.GS16322@dualathlon.random> <20041213124313.GB29426@atrey.karlin.mff.cuni.cz> <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <20041214023651.GT16322@dualathlon.random> <20041214095939.GC1063@elf.ucw.cz> <20041214152558.GB16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214152558.GB16322@dualathlon.random>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, Dec 14, 2004 at 10:59:39AM +0100, Pavel Machek wrote:
> > Are you using CONFIG_HPET_TIMER by chance? It seems to be missing some
> > strategic -1, TSC (etc) get it right.
> 
> I'm not using hpet because it's an old hardware, this is with timer_tsc.
> It must be reproducible in any machine out there, especially with
> machines with usb it should be reproducible even without any userspace
> testcase doing iopl/cli/sti. Time will go silenty in the future at every
> usb irq (they often last 3/4msec).

How much drift do you see?

I have machine with UHCI here, and am using usb most of the time
(bluetooth for gprs connection), and did not notice too bad
drift. ntpdate does some adjustment each time I connect to the
network, but it 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
