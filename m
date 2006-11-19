Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933320AbWKSVRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933320AbWKSVRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWKSVRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:17:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29373 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933320AbWKSVRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:17:15 -0500
Date: Sun, 19 Nov 2006 22:16:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 1/4] swsusp: Untangle thaw_processes
Message-ID: <20061119211651.GD23230@elf.ucw.cz>
References: <200611182335.27453.rjw@sisk.pl> <200611182347.05656.rjw@sisk.pl> <20061119020445.GB15873@elf.ucw.cz> <200611191301.56978.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611191301.56978.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Ah, good idea.  In fact I prefer if (is_user_space(p) == !thaw_user_space),
> because it will work even if thaw_user_space is different to 1 and 0.
> 
> Revised patch follows.
> 
> ---
> Move the loop from thaw_processes() to a separate function and call it
> independently for kernel threads and user space processes so that the order
> of thawing tasks is clearly visible.
> 
> Drop thaw_kernel_threads() which is never used.

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
