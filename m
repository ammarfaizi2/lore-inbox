Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUGRWEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUGRWEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUGRWEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:04:13 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4781 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261405AbUGRWEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:04:09 -0400
Date: Mon, 19 Jul 2004 00:04:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: [0/25] Merge pmdisk and swsusp
Message-ID: <20040718220408.GA31958@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0407171449200.28258-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In the end, these patches remove pmdisk from the kernel and clean up the
> swsusp code base. The result is a single code base with greatly improved
> code, that will hopefully help others underestand it better.

Thanks a lot for the patches.

> Please pull from
> 
> 	bk://kernel.bkbits.net:/home/mochel/linux-2.6-power

Unfortuanetly I can't just pull (I'm not allowed to use bitkeeper). I
could roll them into one big patch and then push them to akpm on my
own, but that would loose history :-(.

Patches #1 .. #4 are trivial enough to go in as soon as you want. I'd
prefer the rest of the patches to be tested in -mmX kernels a bit (for
a testing and so that I can do x86-64 support).. Comments to specific
patches follow.

								Pavel

> <mochel@digitalimplant.org> (04/07/17 1.1846)
>    [Power Mgmt] Share variables between pmdisk and swsusp.
> 
>    - In pmdisk, change pm_pagedir_nosave back to pagedir_nosave, and
>      pmdisk_pages back to nr_copy_pages.
>    - Mark them, and other page count/pagedir variables extern.
>    - Make sure they're not static in swsusp.
>    - Remove mention from include/linux/suspend.h, since no one else needs them.
> 
> <mochel@digitalimplant.org> (04/07/17 1.1845)
>    [Power Mgmt] Remove more duplicate code from pmdisk.
> 
>    - Use read_swapfiles() in swsusp and rename to swsusp_swap_check().
>    - Use lock_swapdevices() in swsusp and rename to swsusp_swap_lock().
> 
> <mochel@digitalimplant.org> (04/07/17 1.1844)
>    [Power Mgmt] Remove duplicate relocate_pagedir() from pmdisk.
> 
>    - Expose and use version in swsusp.
> 
> <mochel@digitalimplant.org> (04/07/17 1.1843)
>    [Power Mgmt] Make pmdisk dependent on swsusp.


-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
