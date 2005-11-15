Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVKOWDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVKOWDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVKOWDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:03:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38570 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751164AbVKOWDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:03:15 -0500
Date: Tue, 15 Nov 2005 23:03:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051115220304.GI1749@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115213229.GB11776@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115213229.GB11776@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is prototype of userland swsusp. I'd like kernel parts to go in,
> > probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
> > slightly ugly, OTOH it would be probably overkill to introduce
> > syscalls just for this. (I'll need to add an ioctl for freeing memory
> > in future).
> 
> What's wrong with 4 new syscalls?  It seems the cleanest way.

I'd need about 7 of them, and that is on at least 3 architectures
(i386, x86-64, ppc, not sure about ppc64/arm). And it does not fix the
interface -- userland parts will still need to read/write /dev/kmem
:-(.

Yep, I can do it...
								Pavel
-- 
Thanks, Sharp!
