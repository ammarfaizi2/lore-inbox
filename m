Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUIKImV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUIKImV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUIKImV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:42:21 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:18879 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267772AbUIKImT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:42:19 -0400
Message-ID: <4142BA62.6020609@tungstengraphics.com>
Date: Sat, 11 Sep 2004 09:42:10 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@linux.ie>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>  <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet> <1094853588.18235.12.camel@localhost.localdomain> <Pine.LNX.4.58.0409110009460.13921@skynet>
In-Reply-To: <Pine.LNX.4.58.0409110009460.13921@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
>>2D and 3D _are_ to most intents and purposes different functions. They
>>are as different as IDE CD and IDE disk if not more so.
> 
> 
> stop saying this, it isn't true and hasn't been for years, for the mach64
> type cards I'd agree, for something even like the i810 this isn't
> true, most cards have two paths (at least), an unaccelerated 2D path via
> programmed registers, and an accelerated path via some DMA mechanism, this
> isn't a 2d/3d split, you have to use the DMA mechanism for doing some 2d
> acceleration and you have to use it for all 3d acceleration normally,
> 
> Lots of X DDX drivers use the accelerator for 2d stuff, some fbs use it
> for accelerating scrolling, the DRM uses it, this is wrong wrong wrong
> wrong...X/DRM at least lock each other out, but the fb just tramps in
> wearing its size nines.. so in summary the 2D/3D split exists in peoples
> minds (graphics cards designers excepted...)

Yes, it is closest to the truth to believe there is one acceleration engine 
that does all drawing, and this should ideally have a single owner.

But that doesn't mean that mode-setting, etc, has to be moved into the DRM - 
for my money that stuff can stay where it is, provided there are some sensible 
interfaces put in place between the two components.

Keith
