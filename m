Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVKRE2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVKRE2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 23:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVKRE2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 23:28:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964828AbVKRE2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 23:28:14 -0500
Date: Thu, 17 Nov 2005 20:27:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1  - immediate system reset at boot
Message-Id: <20051117202751.2a6c2fc3.akpm@osdl.org>
In-Reply-To: <200511180423.jAI4NiT5003598@turing-police.cc.vt.edu>
References: <200511172130.jAHLUCP0010033@turing-police.cc.vt.edu>
	<20051117111807.6d4b0535.akpm@osdl.org>
	<8752.1132265686@warthog.cambridge.redhat.com>
	<200511172223.jAHMNUEt014746@turing-police.cc.vt.edu>
	<200511180423.jAI4NiT5003598@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Thu, 17 Nov 2005 17:23:30 EST, Valdis.Kletnieks@vt.edu said:
> 
> > Am chasing another issue - once I got past that, it wouldn't boot at all.
> > Grub would act like it was loading, then 2 seconds or so later, grub would
> > start up again.  My first guess was CONFIG_DEBUG_RODATA=y, but I ruled that
> > out.  More detail once I've done some more binary searching and ruled out
> > self-inflicted idiocy....
> 
> Rebuilt from a completely new and clean tree, 2.6.14-mm1 is fine, 2.6.15-rc1
> will start booting OK, -rc1-mm1 chokes up almost instantly.  It doesn't live
> long enough for either/both earlyprintk=vga or initcall_debug to output
> anything - grub says "loading", clears the screen, and 2 seconds later the
> laptop gives the 'ka-chunk' noise it does on a system reset, and I'm looking at
> the BIOS splash screen.
> 
> Any obvious places to look, or time to play bisection on the 600 patches
> in -mm?

Can't think of anything, sorry.  The obvious area to probe is around the
x86 and mm patch subserieses.

