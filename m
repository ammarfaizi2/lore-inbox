Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTEUWga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEUWg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:36:29 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:13440 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S262299AbTEUWg2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:36:28 -0400
Date: Wed, 21 May 2003 15:49:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: must-fix list, v5
Message-ID: <20030521224928.GA774@ip68-0-152-218.tc.ph.cox.net>
References: <20030521152255.4aa32fba.akpm@digeo.com> <20030521152334.4b04c5c9.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521152334.4b04c5c9.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 03:23:34PM -0700, Andrew Morton wrote:

> drivers/char/rtc/
> ~~~~~~~~~~~~~~~~~
> 
> o rmk: I think we need a generic RTC driver (which is backed by real RTCs).
>    Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as has the
>   SA11xx, and probably PXA.  There's another implementation for the RiscPC
>   and ARM26 stuff.  I'd rather not see 4 implementations of the RTC userspace
>   API, but one common implementation so that stuff gets done in a consistent
>   way.
> 
>   We postponed this at the beginning of 2.4 until 2.5 happened.  We're now
>   at 2.5, and I'm about to add at least one more (the Integrator
>   implementation.) This isn't sane imo.

I talked with RMK on IRC a bit about this.  After reading
drivers/char/rtc.c, I think this can be vastly simplied to:
Add support for alarms to the existing generic rtc driver
(drivers/char/genrtc.c).

Does this sound like a plan?

-- 
Tom Rini
http://gate.crashing.org/~trini/
