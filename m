Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWHECdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWHECdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 22:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161516AbWHECdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 22:33:42 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:19868 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161513AbWHECdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 22:33:42 -0400
From: David Brownell <david-b@pacbell.net>
To: anemo@mba.ocn.ne.jp, ab@mycable.de, mgreer@mvista.com
Subject: Re: RTC: add RTC class interface to m41t00 driver
Date: Fri, 4 Aug 2006 19:33:39 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041933.39930.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, it'd be worth trying drivers/rtc/rtc-ds1307.c ... the M41T00 is
one of a family of mostly-compatible RTC chips, and the ds1307 driver
should be pretty much the least-common-denominator there.  They all use
the same I2C address, and the same register layout for the calendar/time
function.

I'd expect rtc-ds1307 to handle the m41t00 already, or with at most minor
tweaks to recognize whatever's different.  It should already be ignoring
the bits in the clock/calendar registers that vary, as well as the SRAM
and (for some other chips) the alarm.  (Not that I2C has ways to tell us
what IRQ the alarm would use, but that's a different tale!)

- Dave
