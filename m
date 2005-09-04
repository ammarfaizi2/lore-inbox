Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVIDVR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVIDVR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVIDVRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:17:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17161 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751118AbVIDVRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:17:55 -0400
Date: Sun, 4 Sep 2005 22:17:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050904221742.C11265@flint.arm.linux.org.uk>
Mail-Followup-To: Nishanth Aravamudan <nacc@us.ibm.com>,
	Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050904203755.GA25856@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050904203755.GA25856@us.ibm.com>; from nacc@us.ibm.com on Sun, Sep 04, 2005 at 01:37:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:37:55PM -0700, Nishanth Aravamudan wrote:
> That looks great! So I guess I'm just suggesting moving this from
> include/asm-arch/mach/time.h to arch-independent headers? Perhaps
> timer.h is the best place for now, as it already contains the
> next_timer_interrupt() prototype (which probably should be in the #ifdef
> with timer_dyn_reprogram()).

Sounds great!

> Overall, though, do you agree it would be best to have the common code
> in a common file? If so, I'll work harder on getting some patches out.

Absolutely, with the proviso that ARM doesn't (yet) use the generic IRQ
code.  I say "(yet)" there because there are some folk working in this
area, and I've recently merged a couple of bits which reduce the impact
of their patches.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
