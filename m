Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVAZCky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVAZCky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 21:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVAZCkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 21:40:53 -0500
Received: from holomorphy.com ([66.93.40.71]:2507 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262105AbVAZCkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 21:40:45 -0500
Date: Tue, 25 Jan 2005 18:40:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050126024042.GH10843@holomorphy.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> - Lots of updates and fixes all over the place.
> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.

Someone who sent you a patch needs to learn how to use grep(1). There are
18 patches listed by grep -l it_timer patches/*; giving up.


-- wli

drivers/char/mmtimer.c: In function `reschedule_periodic_timer':
drivers/char/mmtimer.c:423: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:429: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:429: error: structure has no member named `it_incr'
drivers/char/mmtimer.c:435: error: structure has no member named `it_timer'
drivers/char/mmtimer.c: In function `mmtimer_interrupt':
drivers/char/mmtimer.c:471: error: structure has no member named `it_timer'
drivers/char/mmtimer.c: In function `mmtimer_tasklet':
drivers/char/mmtimer.c:508: error: structure has no member named `it_incr'
drivers/char/mmtimer.c:516: error: structure has no member named `it_timer'
drivers/char/mmtimer.c: In function `sgi_timer_create':
drivers/char/mmtimer.c:527: error: structure has no member named `it_timer'
drivers/char/mmtimer.c: In function `sgi_timer_del':
drivers/char/mmtimer.c:538: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:539: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:547: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:548: error: structure has no member named `it_timer'
drivers/char/mmtimer.c: In function `sgi_timer_get':
drivers/char/mmtimer.c:561: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:569: error: structure has no member named `it_incr'
drivers/char/mmtimer.c:570: error: structure has no member named `it_timer'
drivers/char/mmtimer.c: In function `sgi_timer_set':
drivers/char/mmtimer.c:643: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:644: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:645: error: structure has no member named `it_incr'
drivers/char/mmtimer.c:646: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:652: error: structure has no member named `it_timer'
drivers/char/mmtimer.c:655: error: structure has no member named `it_timer'
make[4]: *** [drivers/char/mmtimer.o] Error 1
make[3]: *** [drivers/char] Error 2
make[2]: *** [drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
