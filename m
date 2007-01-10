Return-Path: <linux-kernel-owner+w=401wt.eu-S965225AbXAJW4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbXAJW4k (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbXAJW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:56:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43218 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965225AbXAJW4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:56:39 -0500
Date: Wed, 10 Jan 2007 23:56:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
Message-ID: <20070110225629.GK3700@elf.ucw.cz>
References: <200701102054.57303.oliver@neukum.org> <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701101732160.5563-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The obvious change with this device is that usb_set_configuration() is never
> > called, but that should not matter.
> 
> No, I think you're barking up the wrong tree.
> 
> Pavel, did you have CONFIG_USB_MULTITHREAD_PROBE turned on?  I bet you did 
> -- there's no other way to generate the messages in your syslog.

Yep, you are right.

> Don't use that kconfig option.  It's broken (as you saw) and needs to be
> either removed or replaced.

Perhaps it should be disabled before 2.6.20? This is actually
regression...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
