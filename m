Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVHKMKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVHKMKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVHKMKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:10:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16594 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932351AbVHKMKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:10:23 -0400
Date: Thu, 11 Aug 2005 14:10:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Howard <ghoward@sgi.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: Standardize shutdown of the system from enviroment control modules
Message-ID: <20050811121017.GA2810@elf.ucw.cz>
References: <20050809211003.GA29361@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809211003.GA29361@lst.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Currently snsc_event for Altix systems sends SIGPWR to init (and abuses
> tasklist_lock..) while the sbus drivers call execve for /sbin/shutdown
> (which is also ugly, it should at least use call_usermodehelper)
> With normal sysvinit both will end up the same, but I suspect the
> shutdown variant, maybe with a sysctl to chose the exact path to call
> would be cleaner.  What do you guys think about adding a common function
> to do this.  Could you test such a patch for me?

ACPI does some exec (in thermal), too. Yes, I think it is worth
standartizing. Easy to test, btw, just echo too low trippoints.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
