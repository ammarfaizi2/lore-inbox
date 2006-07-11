Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWGKTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWGKTFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWGKTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:05:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30734 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751186AbWGKTFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:05:50 -0400
Date: Tue, 11 Jul 2006 20:05:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711190544.GB1240@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	torvalds@osdl.org, akpm@osdl.org
References: <20060711160639.GY13938@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711160639.GY13938@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:06:39PM +0200, Adrian Bunk wrote:
> My plan is to create a git tree where I'll work on this that will be 
> included in -mm.
> 
> Is this OK for everyone?

Sure, provided it's also tested on non-x86 architectures as well.

At the moment, someone did a "clean up" of linux/tty.h includes
which has broken the 99% of the ARM defconfigs, and despite this
patch being in -mm and allegedly fixed by akpm for ARM, the result
is still massive breakage.

Hence, -mm is probably far too different from mainline for include
cleanups to be properly tested before they're sent to Linus - iow
they need an additional level of testing against Linus' tree _prior_
to being submitted to Linus.

Apart from that, I've no problem with anyone who wants to clean up
the include mess.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
