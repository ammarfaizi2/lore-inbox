Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752744AbVHGVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbVHGVGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbVHGVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:06:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25992 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752744AbVHGVGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:06:50 -0400
Date: Sun, 7 Aug 2005 23:06:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050807210643.GD3100@elf.ucw.cz>
References: <20050726015401.GA25015@kroah.com> <20050728190352.GA29092@kroah.com> <9e47339105072812575e567531@mail.gmail.com> <200507282310.23152.oliver@neukum.org> <9e47339105072814125d0901d9@mail.gmail.com> <20020101075339.GA467@openzaurus.ucw.cz> <9e47339105080506325d93f431@mail.gmail.com> <20050807184756.GA1024@openzaurus.ucw.cz> <9e4733910508071317a8f0eb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910508071317a8f0eb6@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It is not a work around. These are text attributes meant for human
> > > use.  Humans have a hard time cleaning up things they can't see. And
> > > the failure mode for this is awful, your attribute won't set but
> > > everything on the screen looks fine.
> > 
> > Kernel is not a place to be user friendly. Or do you propose stripping whitespace
> > for open(), too? File called "foo.txt    " certainly *is* going to be confusing, but it should be allowed at kernel level.
> 
> open is not made for human use, it is used by programs and only
> indirectly by humans. sysfs variables are used by directly humans.

Both are kernel interfaces; I can use open() by hand just fine...

> > Now... echo foo > /sys/var does not properly report errors. Thats bad, but it needs to
> > be fixed in bash.
> 
> It is going to take a lot more code to return an error that a
> parameter didn't match because of extra white space that it would take
> to simply remove the whitespace.

I believe we do correctly report errors in write() calls already. Bash
not reporting them to the user is different problem.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
