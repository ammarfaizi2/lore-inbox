Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTENQ2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTENQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:28:18 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:15239 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S262562AbTENQ2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:28:16 -0400
Date: Wed, 14 May 2003 09:41:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6 must-fix list, v3
Message-ID: <20030514164101.GD830@ip68-0-152-218.tc.ph.cox.net>
References: <20030514032712.0c7fa0d1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514032712.0c7fa0d1.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 03:27:12AM -0700, Andrew Morton wrote:

> +drivers/char/rtc/
> +-----------------
> +
> +- rmk: I think we need a generic RTC driver (which is backed by real RTCs).
> +   Integrator-based stuff has a 32-bit 1Hz counter RTC with alarm, as has the
> +  SA11xx, and probably PXA.  There's another implementation for the RiscPC
> +  and ARM26 stuff.  I'd rather not see 4 implementations of the RTC userspace
> +  API, but one common implementation so that stuff gets done in a consistent
> +  way.
> +
> +  We postponed this at the beginning of 2.4 until 2.5 happened.  We're now
> +  at 2.5, and I'm about to add at least one more (the Integrator
> +  implementation.) This isn't sane imo.

I know Geert asked, but what's wrong with the current generic RTC
driver (drivers/char/genrtc.c), and why couldn't the additional features be
added to it, ala the battery bits that went in semi-recently?

-- 
Tom Rini
http://gate.crashing.org/~trini/
