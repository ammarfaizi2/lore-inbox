Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUIRGBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUIRGBr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 02:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269139AbUIRGBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 02:01:47 -0400
Received: from holomorphy.com ([207.189.100.168]:42161 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269136AbUIRGBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 02:01:45 -0400
Date: Fri, 17 Sep 2004 23:01:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040918060134.GL9106@holomorphy.com>
References: <20040916024020.0c88586d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:40:20AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm1/
> - Added lots of Ingo's low-latency patches
> - Lockmeter doesn't compile.  Don't enable CONFIG_LOCKMETER.
> - Several architecture updates

Tested this on my laptop, which is a shoddy testing environment because
it lacks serial devices... no, not all of my boxen are UltraEnterprise,
AlphaServer, and Altix systems (the Altix isn't even mine, it's werk's).
But anyway, I got some kind of backtrace in yenta_interrupt, that said
"stack pointer is garbage, not dumping" or some such, followed by an
interrupts-off deadlock later in some unclear location (looks like ICH
scanning or some such; while legible, I couldn't make heads or tails of
it). ISTR PCMCIA IRQ/etc. stack consumption issues; this may be related.

Russell, I didn't know whom to cc:; if you could redirect this in the
proper direction (e.g. PCMCIA maintainer) I'd be much obliged.


-- wli
