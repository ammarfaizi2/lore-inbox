Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267836AbUG3Uyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267836AbUG3Uyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUG3Uyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:54:37 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:22409 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S267844AbUG3Uye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:54:34 -0400
Date: Fri, 30 Jul 2004 22:54:36 +0200
From: Martin Mares <mj@ucw.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Jon Smirl <jonsmirl@yahoo.com>,
       Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730205436.GA5887@ucw.cz>
References: <20040730201052.GA5249@ucw.cz> <20040730203225.81054.qmail@web14926.mail.yahoo.com> <20040730204121.GA5718@ucw.cz> <200407301349.12020.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301349.12020.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think anyone wants an x86 emulator builtin to the kernel for this 
> purpose.

Well, most people probably do not want a x86 emulator running random ROMs
in the userspace, either :-)  But unfortunately the world is ugly (at least
these parts of it).

However, point taken.  (Although it will not be easy, since you have to avoid
kernel drivers touching the device until you can run the ROM in userspace.)

> We can get away without caching a copy of the ROM in the kernel if we require 
> userspace to cache it before the driver takes control of the card (i.e. at 
> POST time).  Otherwise, the kernel will have to take care of it.

In case of the video cards, it is probably the right path to go.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Maintenance-free:  When it breaks, it can't be fixed...
