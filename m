Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTHUThb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTHUThb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 15:37:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50911 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262882AbTHUTha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 15:37:30 -0400
Date: Thu, 21 Aug 2003 20:37:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: Lou Langholtz <ldl@aros.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <willy@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
Message-ID: <20030821193728.GB19630@parcelfarce.linux.theplanet.co.uk>
References: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk> <3F44E2EB.6020508@pobox.com> <3F44F88F.9010106@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F44F88F.9010106@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 10:51:27AM -0600, Lou Langholtz wrote:
> Jeff Garzik wrote:
> >. . . removing the messages outright might not serve the best 
> >interests the developer.  Since even KERN_DEBUG still spams dmesg, in 
> >these situations I usually change these type of messages to be 
> >conditionally printed iff a debug macro is enabled.
> 
> How about using KERN_DEBUG and augmenting the dmesg store so that the 
> level that is saved is configurable? Even compile time configurable 
> seems reasonable to start. But axeing out even the possibility of boot 
> time info seems bad to me.

But why is it interesting to have this information at boot time?  As a
user, I certainly don't care.  As a developer, I don't find it interesting
information.  Maybe the maintainer of this particular piece of code finds
it useful (Do you, Jens?), but does it need to be reported at boot time?

Perhaps it would be more useful to add some kind of reporting to
mm/mempool.c along the same lines as /proc/slabinfo so we can get the
dynamic information about pools at runtime rather than knowing their
initial state at boot time.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
