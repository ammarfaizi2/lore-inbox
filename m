Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273935AbRIXPOV>; Mon, 24 Sep 2001 11:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273936AbRIXPOL>; Mon, 24 Sep 2001 11:14:11 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:59657 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S273935AbRIXPOB>; Mon, 24 Sep 2001 11:14:01 -0400
Date: Mon, 24 Sep 2001 11:14:21 -0400
Message-Id: <200109241514.f8OFEL005589@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
X-Newsgroups: linux.dev.kernel
In-Reply-To: <3BA8DF59.B9F536B4@candelatech.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BA8DF59.B9F536B4@candelatech.com> greearb@candelatech.com wrote:
| Andrew Morton wrote:
| 
| > nmi_watchdog will force an oops if the machine locks up
| > with interrupts disabled (as I suspect mine did).  But
| > it requires an SMP kernel or IO-APIC-on-UP.
| 
| I just built a 2.4.8 kernel with the APIC enabled.  It locked
| hard and printed no OOPS.  I had set the boot cmd line as:
| nmi_watchdog=1

This only works if you have a lock with no response. If keyboard input
is echoed or ping still works, that's not the tight lockup. May I
suggest the software watchdog feature as an alternative. It's much
better at finding cases where the system is only braindead rather than
locked up.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
