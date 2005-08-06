Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVHFJtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVHFJtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 05:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVHFJtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 05:49:33 -0400
Received: from mail1.kontent.de ([81.88.34.36]:20369 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261351AbVHFJtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 05:49:32 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Sat, 6 Aug 2005 11:39:27 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
References: <20050726015401.GA25015@kroah.com> <200508052207.49270.oliver@neukum.org> <9e47339105080513335e2674fa@mail.gmail.com>
In-Reply-To: <9e47339105080513335e2674fa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508061139.27249.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Stupid users are not a reason for kernel bloat.
> 
> You have a very wrapped sense of kernel bloat. This is nine lines of
> code whose absence is guaranteed to generate a bunch of bug reports.

They are supposed to be present, but not in the kernel.

> Not having it is also causing various implementers to implement
> attribute processing differently. Some are stripping white space in
> their implementations and some are not. If you want to attack kernel
> bloat there are much more productive areas.

If somebody is stripping whitespace in the kernel, find and destroy.
 
> If whitespace cleanup is rejected I believe we should eliminate text
> based sysfs attributes in general and make them all binary. I'll
> probably remove the fbdev sysfs interface because I don't want to deal
> with the bug reports reporting the same problem over and over.

You are seeing this wrong. The problem is not binary vs. text.
If binary were the problem we'd have a generic ioctl tool that takes
arguments in any number format you'd want. The problem is untyped
data. ASCII-strings without leading or trailing whitespece is a clearly
defined datatype. Requiring a tool ensuring this format is met or care
is used if other tools are used is perfectly in order. The kernel does
not guess what an input is supposed to mean. Anything else is bloat.

	Regards
		Oliver
