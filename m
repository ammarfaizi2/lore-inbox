Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWJEI5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWJEI5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWJEI5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:57:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44679 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751507AbWJEI5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:57:14 -0400
Date: Thu, 5 Oct 2006 10:57:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: error to be returned while suspended
Message-ID: <20061005085706.GB27594@elf.ucw.cz>
References: <200610031323.00547.oliver@neukum.org> <200610041834.57639.oliver@neukum.org> <20061004224448.GL8440@elf.ucw.cz> <200610050907.27035.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610050907.27035.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (So we are talking runtime suspend?)
> 
> Yes. Otherwise the patch would have been ready two days ago.
> But if I am implenting this, I'll do a full implementation.
> 
> > No, I do not know what the right interface is. I started to suspect
> > that drivers should suspend/resume devices automatically, without
> > userland help. Maybe having autosuspend_timeout in sysfs is enough.
> 
> If you do this at kernel level, you'll screw up any demon implementing
> a power policy to stay within the budget.

Well, in case of machine where "must get approval before you can use
printer"... just do exactly that. Make userland ask approval of
powerbudgetd before it opens /dev/lp0.

It will only be neccessary on very small machines, anyway.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
