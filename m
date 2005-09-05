Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVIEHhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVIEHhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVIEHhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:37:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44306 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932275AbVIEHhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:37:41 -0400
Date: Mon, 5 Sep 2005 08:37:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905083728.A24051@flint.arm.linux.org.uk>
Mail-Followup-To: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905053225.GA4294@in.ibm.com>; from vatsa@in.ibm.com on Mon, Sep 05, 2005 at 11:02:25AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 11:02:25AM +0530, Srivatsa Vaddagiri wrote:
> I don't see provisions for all these in the current ARM implementation.

That's because, like x86, we've been ignoring each other.  ARM
doesn't handle dyntick SMP yet - ARM is fairly young as far as
SMP issues goes, and as yet doesn't include a full SMP
implementation in mainline.

Despite that, the timers as implemented on the hardware are not
suitable for dyntick use - attempting to use them, you lose long
term precision of the timer interrupts.

> 5. Don't see how DYN_TICK_SKIPPING is being used. In SMP scenario,
>    it doesnt make sense since it will have to be per-cpu. The bitmap
>    that I talked of exactly tells that (whether a CPU is skipping
>    ticks or not).

What's DYN_TICK_SKIPPING and what's it used for?  It looks like
a redundant definition left over from Tony's original implementation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
