Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269157AbUIRISN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269157AbUIRISN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 04:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUIRISN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 04:18:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:783 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269157AbUIRISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 04:18:12 -0400
Date: Sat, 18 Sep 2004 09:18:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040918091807.A11880@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040916024020.0c88586d.akpm@osdl.org> <20040918060134.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040918060134.GL9106@holomorphy.com>; from wli@holomorphy.com on Fri, Sep 17, 2004 at 11:01:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:01:34PM -0700, William Lee Irwin III wrote:
> Tested this on my laptop, which is a shoddy testing environment because
> it lacks serial devices... no, not all of my boxen are UltraEnterprise,
> AlphaServer, and Altix systems (the Altix isn't even mine, it's werk's).
> But anyway, I got some kind of backtrace in yenta_interrupt, that said
> "stack pointer is garbage, not dumping" or some such, followed by an

As far as "stack pointer is garbage", ISTR that I've seen that some
bug reports, and it looked like the test for that was wrong - ESP
seemed to be within 4K or 8K (I don't remember which) of the reported
stack base.

I think the first step is for someone to check whether the stack
pointer validation code is correct or not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
