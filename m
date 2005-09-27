Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVI0Xnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVI0Xnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVI0Xnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:43:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7318 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965236AbVI0Xnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:43:49 -0400
Date: Wed, 28 Sep 2005 01:43:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][Fix] Fix Bug #4959 (take 2)
Message-ID: <20050927234329.GC2381@elf.ucw.cz>
References: <200509241936.12214.rjw@sisk.pl> <200509272300.37197.rjw@sisk.pl> <20050927210821.GF2040@elf.ucw.cz> <200509280126.26701.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509280126.26701.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I can reserve the static buffer (10 pages) in suspend.c and mark it as nosave.
> > > The code that creates the mappings can stay in suspend.c either except it
> > > won't need to call get_usable_page() and free_eaten_memory() any more
> > > (__next_page() can be changed to get pages from the static buffer instead
> > > of allocating them).  The code can also be simplified a bit, as we assume that
> > > there will be only one PGD entry in the direct mapping.
> > > 
> > > If that sounds good to you, please confirm.
> > 
> > 8GB limit seems good to me -- as long as it makes code significantly
> > simpler. It would be nice if it was <20 lines.
> 
> It is more than that, but it seems to be quite simple anyway.
> 
> The new patch follows.

Thanks, seems okay to me. 

								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
