Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUIKPCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUIKPCR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUIKPCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:02:17 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15283 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268161AbUIKPCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:02:15 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409110009460.13921@skynet>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110009460.13921@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094911174.21082.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 14:59:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 00:24, Dave Airlie wrote:
> stop saying this, it isn't true and hasn't been for years, for the mach64
> type cards I'd agree, for something even like the i810 this isn't

Its true. Its still true whether you demand people stop saying it or
not.

> true, most cards have two paths (at least), an unaccelerated 2D path via
> programmed registers, and an accelerated path via some DMA mechanism, this
> isn't a 2d/3d split, you have to use the DMA mechanism for doing some 2d
> acceleration and you have to use it for all 3d acceleration normally,

And a CD ROM is a round thing with removable optical media, while a hard
disk has a different command set and is magnetic. They are juat as
different. Its simple a matter of correct architecture.

> Lots of X DDX drivers use the accelerator for 2d stuff, some fbs use it
> for accelerating scrolling, the DRM uses it, this is wrong wrong wrong
> wrong...X/DRM at least lock each other out, but the fb just tramps in
> wearing its size nines.. so in summary the 2D/3D split exists in peoples
> minds (graphics cards designers excepted...)

Thats a different issue. IDE has to stop the CD and disk drivers from
stomping on each other over a shared bus. This is the problem of them
knowing each other exist and interacting. This is the point you need to
be able to find DRI from FB and vice versa. The point they need to know
about each other being loaded.

Multiple registrations on the same object is exactly what the class code
in the kernel is for. 

You end up with a VGA class driver that knows all the video devices. 
That has the usual match/install functions to allow the frame buffer to
attach, but can also have other sets for attaching different client
classes.


