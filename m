Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130821AbRBNTBn>; Wed, 14 Feb 2001 14:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130950AbRBNTB3>; Wed, 14 Feb 2001 14:01:29 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:51924 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130821AbRBNTBS>; Wed, 14 Feb 2001 14:01:18 -0500
Message-ID: <3A8AD550.87898BB0@sympatico.ca>
Date: Wed, 14 Feb 2001 13:58:24 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Vojkovich <mvojkovich@nvidia.com>
CC: xpert@xfree86.org, linux-kernel@vger.kernel.org
Subject: Re: [Xpert]Video drivers and the kernel
In-Reply-To: <Pine.LNX.4.21.0102131937590.1564-100000@mvojkovich1.nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me if sending to xpert list.

This is a big topic.  I think I can contribute a whole two cents worth
though...
Interesting to note that NT's windowing system moved from being originally
in userland to inside the kernel between V3.? and 4.0.  Remember mom saying
"If your friends all jump off a bridge..."

The issue I understand is that context switching kernel<>user slows things
down.
And then there's trying to make an api...  XFree just maps mmio/framebuffer
and ioports
into it's own address space and bangs the hardware, so it's fast and can do
anything.
DRI extends this to client 3D code in a sense.

Bottom line for me, I don't care; as long as I still can use remote X apps,
and Quake3 uses
my 3D hardware, I'm happy to have people spend their time improving X how
they see fit,
and they're done an incredible job so far.

My only complaint is when there's a problem with X:  It's cool that I can
just restart it
rather than reboot like windows.  (so you can play from console of a server
right? :)
This is a benefit of it being in userspace.  But it would be nice
if I didn't have to do it via telnet; sometimes I don't have a box on a
network.
(Aside, is this because X uses keyboard in raw mode?  would be nice to still
be able to ctrl-alt-del to rebood from console)  Anyone know about
using alt-sysrq to restore console?

So, if the kernel had a card specific module that just knew enough
to put the card back into text mode, or if it used the card's bios
to do it like the int10.a module in XFree 4.0, we would lack for nothing.
(hmm vesafb could be extended?)

> On Tue, 13 Feb 2001, Louis Garcia wrote:
>
> > I was wondering why video drivers are not part of the kernel like every
> > other piece of hardware. I would think if video drivers were part of the
> > kernel and had a nice API for X or any other windowing system, would not
> > only improve performance but would allow competing windowing systems
> > without having to develop drivers for each. Has anyone thought or
> > rejected this idea.

