Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUIJXKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUIJXKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIJXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:10:23 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:54330 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268004AbUIJXKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:10:21 -0400
Message-ID: <9e47339104091016104c966eb7@mail.gmail.com>
Date: Fri, 10 Sep 2004 19:10:20 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: radeon-pre-2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Ian Romanick <idr@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409102254250.13921@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 23:19:42 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> Also I don't think what Jon has in mind is going to be truly possible and
> IMHO an efficient flexible graphics card memory management system is
> something worthy of multiple PhDs (maybe I'll go back to college), Ians
> work is going to exist mainly in userspace using the DRM for paging things
> and locking, I think the only way we can really do this is with a simple
> fb memory manager in the kernel that the userspace one overrides and then
> tells the fb drivers the new settings - and the fb drivers use those
> settings until told otherwise..

I'm counting on Ian to provide the memory management code. I haven't
even looked at it very much. The point is simply that we have to have
something, you just can't support multiple heads without minimal
memory management and fbdev doesn't currently have any memory
management. Since the plan is for a mode setting command to take a
path unto user space via hotplug it may be possible for all memory
management code to exist in user space. The basic point is that the
memory management code must be unified.

-- 
Jon Smirl
jonsmirl@gmail.com
