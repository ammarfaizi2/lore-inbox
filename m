Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVDDQtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDDQtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVDDQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:49:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29964 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261273AbVDDQte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:49:34 -0400
Date: Mon, 4 Apr 2005 17:49:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix u32 vs. pm_message_t in arm
Message-ID: <20050404174923.B12975@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050329191543.GA8309@elf.ucw.cz> <20050403113804.A921@flint.arm.linux.org.uk> <20050403104414.GE1357@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050403104414.GE1357@elf.ucw.cz>; from pavel@ucw.cz on Sun, Apr 03, 2005 at 12:44:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 12:44:14PM +0200, Pavel Machek wrote:
> > > This fixes u32 vs. pm_message_t confusion in arm. I was not able to
> > > even compile it, but it should not cause any problems. Please apply,
> > 
> > On testing this patch, it doesn't build.  You need to include
> > linux/pm.h into linux/sysdev.h for starters, and fix sysdev.h
> > to also use pm_message_t in it's function pointers.
> > 
> > Therefore, I'd like the following patch either to be in mainline first,
> > or in my ARM tree for Linus to pull so ARM doesn't completely break
> > on my next merge.
> 
> That patch was recently merged into -mm, so I hope its okay... Thanks
> for testing. (And sorry, I did not realize patches depend on each
> other this way).

Grumble.  So it hasn't been merged before the ARM changes, which means
mainline is now broken for ARM.  I knew I should've just thrown it
straight in along with the stuff depending on it. ;(

Linus - is the pm.h included in sysdev.h in -rc2?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
