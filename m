Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275709AbRJUIun>; Sun, 21 Oct 2001 04:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275720AbRJUIue>; Sun, 21 Oct 2001 04:50:34 -0400
Received: from shake.vivendi.hu ([213.163.0.180]:17538 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S275709AbRJUIuZ>; Sun, 21 Oct 2001 04:50:25 -0400
Date: Sun, 21 Oct 2001 10:50:56 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Jonathan Morton <chromi@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Message-ID: <20011021105056.B17786@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <20011021093728.A17786@vega.digitel2002.hu> <a05100314b7f8369cf7cd@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <a05100314b7f8369cf7cd@[192.168.239.101]>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 09:33:34AM +0100, Jonathan Morton wrote:
> > > Boots up with X, that means.
> >
> >I've never understood why people want X, StarOffice (OpenOffice) etc to be
> >moved into kernel space :) IMHO it's strictly user space issue. You can
> >start X or gdm/xdm/kdm from a boot script and so on. No kernel modification
> >is needed for this.
> 
> Probably because they don't know the difference between kernel and 
> user space.  Kinda understandable when you come from a Mac or Windows 
> background, where (in the former) there is no distinction or (in the 
> latter) it's so blurred as to make little difference.

Hmmm, I don't know Windows very well but AFAIK it's something microkernel
architecture (well this makes me laughing always though :), HAL, and so on.
But even the GUI of windows can be changed but it's more hard to implement.

> And if they *do* understand it, from a dispassionate point of view, 
> it does seem to make sense to put graphics drivers in the kernel - 
> they're implemented as "device drivers" in every other desktop OS. 
> Except MacOS X, where's it's an application layer like glibc, but 
> nobody understand OS X yet beyond the hardest of developers.

:) It would be interesting to learn more on it (if infomartion is available).
afaik it's a unix like system in its core.
 
> But they don't realise that XFree86 has an *enormous* amount of 
> developer time behind it, which would need to be duplicated to make 
> it work in kernel space with full backwards compatibility.  Oh, and 
> did I mention this would all be for one platform - XFree86 is 
> designed to run on many!  It would also bloat the kernel tremendously.

Hmmm. It quite complex question. Let's think about direct rendering kernel
modules ... XFree 4 went a step closer to the "right solution(TM)" because
it can cooperate with low level rendering capabilities of direct rendering
modules can be found in newer Linux kernels. And I think it's right to
split functions of a driver into "kernel level" and "user level" parts based
on functionality and hw access needs of particular parts of the whole gfx cloud.
However this "splitted" design can cause problems. Nowdays, XFree4 uses
OS independent, separated drivers (on a different OS but with the same CPU
the driver module is the same for XFree. afaik this technique was donated by
Metro). But kernel rendering modules are VERY kernel related stuffs and it's
quite hard for a video hardware vendor to release binary only drivers for
almost every kernels and so on. Of course the perfect solution would be open
source (let's dream a bit: GPL) drivers but our world is far from being perfect :(

Also it would be nice if frame buffer can support 3D hw accelerated gfx functions.
And so on. So probably a better interaction should be implemented between
various gfx elements of a tipical Linux system. [I don't know GGI very well
but AFAIK its goals are very interesting]

But this is far from the original topic of this thread so I must say: sorry :)

- Gabor
