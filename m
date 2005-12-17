Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVLQUiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVLQUiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVLQUiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:38:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964943AbVLQUiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:38:02 -0500
Date: Sat, 17 Dec 2005 12:37:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patch Devil <lkpatches@paypc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] i8xx_tco - Add SuperMicro ICH[56] Pentium 4
 watchdog support
Message-Id: <20051217123729.498c7919.akpm@osdl.org>
In-Reply-To: <1134600697.43a0a1f9de94e@www.paypc.com>
References: <1134600697.43a0a1f9de94e@www.paypc.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch Devil <lkpatches@paypc.com> wrote:
>
> Hello friends of LK:
> 
> It seems that SuperMicro P4-based motherboards DO actually have working
> watchdog hardware (be sure jumpers *and* BIOS settings are configured
> appropriately), however the setup of their internal ports and registers
> deviate from canonical Intel specification.
> 
> Because it seems impossible/difficult to do a proper auto-detection for these
> deviations, I've added a module_param to the TCO module to provide minor
> changes to the existing i8xx TCO code.  I've given it some testing on i845
> (Northwood P4) and E7520 (Nacona/EM64T SMP-Xeon) and it does indeed activate
> watchdog (reset/reboot) functionality and provide WDT resets to keep the
> system up.
> 
> SuperMicro had provided me with some documentation for their Pentium III
> motherboards, however I was not able to ever get it functioning on my SSE370+,
> however I've incorporated the logic as documented as a bit of a "bookmark" for
> future implementors who MAY be lucky to have P3 SuperMicros with working WDT
> functionality.
> 
> My patch activates the watchdog even if the BIOS setting disables it, however
> it cannot override the jumper on the motherboard.
> 
> Naturally, users should do two-way testing before deploying this on production
> hardware: 1) Verify that the watchdog IS actually able to reset the machine --
> so you'll need to deliberately lockup or kill the WDT refresh and make sure
> the machine reboots, and then 2) Verify that the watchdog timer is being
> properly reset.
> 
> This patch was made against 2.6.13.2, and I provide some background detail in
> the patched source.
> 
> I've had this working in production for a couple of months now without any
> issues.  Of course, these very reliable systems never lockup (typical uptimes
> are over 300-400 days, and are rebooted for kernel upgrades only).  But hey, I
> was a bit annoyed that an advertised feature wasn't available to me.
> 
> Cheers,
> Robert
> 

Thanks for doing this work.

Unfortunately we shouldn't be merging nontrivial patches from new
contributors with names like "Robert the Patch Devil" ;)

Please review Section 11 of Documentation/SubmittingPatches.txt and, if you
find the terms there to be acceptable, resend the patch with a
Signed-off-by: and your real name, thanks.

