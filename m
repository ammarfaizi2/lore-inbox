Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752557AbVHGSyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbVHGSyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbVHGSyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:54:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59597 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752558AbVHGSyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:54:52 -0400
Date: Sun, 7 Aug 2005 20:47:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>,
       Greg KH <greg@kroah.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050807184756.GA1024@openzaurus.ucw.cz>
References: <20050726015401.GA25015@kroah.com> <20050728190352.GA29092@kroah.com> <9e47339105072812575e567531@mail.gmail.com> <200507282310.23152.oliver@neukum.org> <9e47339105072814125d0901d9@mail.gmail.com> <20020101075339.GA467@openzaurus.ucw.cz> <9e47339105080506325d93f431@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105080506325d93f431@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Could you tell me why you don't just fail the operation if malformed
> > > > input is supplied?
> > >
> > > Leading/trailing white space should be allowed. For example echo
> > > appends '\n' unless you know to use -n. It is easier to fix the kernel
> > > than to teach everyone to use -n.
> > 
> > Please, NO! echo -n is the right thing to do, and users will eventually learn.
> > We are not going to add such workarounds all over the kernel...
> 
> It is not a work around. These are text attributes meant for human
> use.  Humans have a hard time cleaning up things they can't see. And
> the failure mode for this is awful, your attribute won't set but
> everything on the screen looks fine.

Kernel is not a place to be user friendly. Or do you propose stripping whitespace
for open(), too? File called "foo.txt    " certainly *is* going to be confusing, but it should be allowed at kernel level.

Now... echo foo > /sys/var does not properly report errors. Thats bad, but it needs to
be fixed in bash.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

