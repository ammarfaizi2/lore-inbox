Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268014AbUIJXTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268014AbUIJXTr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUIJXTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:19:47 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40370 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268014AbUIJXTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:19:38 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Ian Romanick <idr@us.ibm.com>
In-Reply-To: <9e47339104091016104c966eb7@mail.gmail.com>
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
	 <9e47339104091016104c966eb7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094854621.18282.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 23:17:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 00:10, Jon Smirl wrote:
> I'm counting on Ian to provide the memory management code. I haven't
> even looked at it very much. The point is simply that we have to have
> something, you just can't support multiple heads without minimal
> memory management and fbdev doesn't currently have any memory
> management. Since the plan is for a mode setting command to take a
> path unto user space via hotplug it may be possible for all memory
> management code to exist in user space. The basic point is that the
> memory management code must be unified.

DRI's memory allocator needs are very different to the others. That
probably means the kernel API should be very simple and push most of the
allocation to user space for rendering work. You want
"give me 4Mb" in kernel , but you don't want allocation for textures in
kernel (just profile the via driver).

fbdev does btw have memory management, quite a bit of it for some
multihead cards.
