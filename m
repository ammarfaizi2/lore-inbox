Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWJDWpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWJDWpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJDWpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:45:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37052 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751201AbWJDWo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:44:58 -0400
Date: Thu, 5 Oct 2006 00:44:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error to be returned while suspended
Message-ID: <20061004224448.GL8440@elf.ucw.cz>
References: <200610031323.00547.oliver@neukum.org> <20061004111933.GA8297@elf.ucw.cz> <200610041834.57639.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610041834.57639.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > which error should a character device return if a read/write cannot be
> > > serviced because the device is suspended? Shouldn't there be an error
> > > code specific to that?
> > 
> > If you are talking system suspend, then userspace should not run while
> > devices are suspended.
> > 
> > If you are talking runtime suspend, you should probably just wake the
> > device up on first access.
> 
> Do you really think a device driver should override an explicitely
> selected power state?

(So we are talking runtime suspend?)

No, I do not know what the right interface is. I started to suspect
that drivers should suspend/resume devices automatically, without
userland help. Maybe having autosuspend_timeout in sysfs is enough.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
