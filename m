Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUHKWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUHKWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUHKWZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:25:25 -0400
Received: from holomorphy.com ([207.189.100.168]:56454 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268278AbUHKWYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:24:07 -0400
Date: Wed, 11 Aug 2004 15:23:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040811222349.GS11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com> <20040811215915.GA21812@elf.ucw.cz> <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Pavel Machek wrote:
>> Fine, so perhaps we do not want config option?

On Wed, Aug 11, 2004 at 03:13:15PM -0700, Linus Torvalds wrote:
> The inline spinlocks are _wonderful_ for seeing where the contention is in 
> a simple profile.
> In contrast, in a profile the out-of-lines ones will show "x% was spent on 
> spinlocks". Which doesn't help much when you want to see where the problem 
> is.
> This was _hugely_ useful, at least for me, for seeing what locks were 
> problematic.

Well, one trick with the kinda-sorta inline spinlocks is that they need
additional diagnostics (which are *REALLY* painful to get out of users)
to find where the overhead was, hence there were CONFIG_SPINLINE
patches to get rid of the lock section bits.


-- wli
