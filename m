Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274853AbVBFKf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274853AbVBFKf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275133AbVBFKf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:35:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:62596 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S275687AbVBFKfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:35:45 -0500
Subject: Re: 2.6.11-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m3d5vengs2.fsf@telia.com>
References: <20050204103350.241a907a.akpm@osdl.org>
	 <m3d5vengs2.fsf@telia.com>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 21:33:44 +1100
Message-Id: <1107686024.30303.52.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 11:07 +0100, Peter Osterlund wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> 
> It gives me a kernel panic at boot if I have CONFIG_FB_RADEON
> enabled. If I also have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get this
> output:
> 
>         Unable to handle kernel NULL pointer dereference at virtual address 00000000
>         ...
>         PREEMPT
>         ...
>         EIP is a strncpy_from_user+0x33/0x47
>         ...
>         Call Trace:
>          getname+0x69/0xa5
>          sys_open+0x12/0xc6
>          sysenter_past_esp+0x52/0x75
>         ...
>         Kernel panic - not syncing: Attempted to kill init!
> 
> If I don't have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get a screen
> with random junk and some blinking colored boxes, and the machine
> hangs.

That's very strange... I don't see what in radeonfb could cause this.
Just in case, can you try commenting out the call to radeon_pm_init() in
radeon_base.c, see if it makes any difference (though I don't think so).

Ben.


