Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262229AbTCRIJN>; Tue, 18 Mar 2003 03:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbTCRIJN>; Tue, 18 Mar 2003 03:09:13 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6159 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262229AbTCRIJN>; Tue, 18 Mar 2003 03:09:13 -0500
Date: Tue, 18 Mar 2003 09:20:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Faster SWSUSP free page counting
Message-ID: <20030318082008.GC10472@atrey.karlin.mff.cuni.cz>
References: <1047944582.1713.5.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047944582.1713.5.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch improves the speed of SWSUSP's count_and_copy_data_pages
> function by generating a map of the free pages before iterating through
> the list of pages. The net result is to go from O(n^2) to O(n), if I
> remember my computer science correctly.

Is the speed difference noticable?

If yes than okay, but generate_free_page_map() should still be moved
into kernel/suspend.c.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
