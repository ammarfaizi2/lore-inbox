Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTDGM5b (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTDGM5b (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:57:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26893 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263402AbTDGM5a (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:57:30 -0400
Date: Mon, 7 Apr 2003 15:09:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.5.66 incremental (#4: Discontiguous patches & Dynamic PageFlag Bitmap)
Message-ID: <20030407130904.GB16919@atrey.karlin.mff.cuni.cz>
References: <1049685473.13733.4.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049685473.13733.4.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is pretty much the same as the original discontiguous pagedirs
> patch that you've already seen, except that instead of using real
> pageflags, bitmaps are made on the fly and discarded (as previously
> discussed). I've left the NoSave flag as a real pageflag so that drivers
> etc can mark pages Nosave if need be (is this a real possibility?).

Drivers should never ever need to set themselves nosave....

It contains the same double pointers and the same
hard-limit-on-#pages-to-be-saved.

Can't you solve the problem (too big alocations) without going to the
tree? Like linklist of pages containing pointers? Or maybe vmallocing
that pgdir so it can be larger?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
