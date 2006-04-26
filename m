Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWDZILo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWDZILo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 04:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDZILo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 04:11:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29670 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751182AbWDZILn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 04:11:43 -0400
Date: Wed, 26 Apr 2006 10:10:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <nigel@suspend2.net>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Message-ID: <20060426081053.GA6676@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl> <200604252312.26249.rjw@sisk.pl> <200604260718.42681.nigel@suspend2.net> <200604260021.08888.rjw@sisk.pl> <444ED9EB.5060205@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444ED9EB.5060205@yahoo.com.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 26-04-06 12:24:43, Nick Piggin wrote:
> Rafael J. Wysocki wrote:
> 
> >This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> >except for the pages mapped by the current task, without copying.  I think 
> >we
> >can try to do this, but we'll need a patch to freeze bdevs for this 
> >purpose. ;-)
> >
> 
> Why not the current task? Does it exit the kernel? Or go through some
> get_uesr_pages path?

It does exit kernel, and does writing to devices in userspace (so it
can compress, etc).
								Pavel
-- 
Thanks for all the (sleeping) penguins.
