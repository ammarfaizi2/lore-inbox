Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUIJXYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUIJXYa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUIJXYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:24:30 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:730 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268030AbUIJXYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:24:22 -0400
Date: Sat, 11 Sep 2004 00:24:21 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1094853588.18235.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409110009460.13921@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet> <1094853588.18235.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> 2D and 3D _are_ to most intents and purposes different functions. They
> are as different as IDE CD and IDE disk if not more so.

stop saying this, it isn't true and hasn't been for years, for the mach64
type cards I'd agree, for something even like the i810 this isn't
true, most cards have two paths (at least), an unaccelerated 2D path via
programmed registers, and an accelerated path via some DMA mechanism, this
isn't a 2d/3d split, you have to use the DMA mechanism for doing some 2d
acceleration and you have to use it for all 3d acceleration normally,

Lots of X DDX drivers use the accelerator for 2d stuff, some fbs use it
for accelerating scrolling, the DRM uses it, this is wrong wrong wrong
wrong...X/DRM at least lock each other out, but the fb just tramps in
wearing its size nines.. so in summary the 2D/3D split exists in peoples
minds (graphics cards designers excepted...)

> multiple pci device registration problem, it allows DRI/fbdev
> co-existance, it fixes hotplugging. It's about using the kernel tools we
> already have and implementing it the way the kernel wants to think. If
> you fight the kernel you get a mess, if you move with it then it ends up
> where you want it. Kind of like Aikido source management.

I'm with this, I want to see this stuff stay working on the way, I think
doing this might be a good step on the way, and it shouldn't break
anything too badly, I was going to start hacking something up myself but
the real world job just kicked me to get something done :-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

