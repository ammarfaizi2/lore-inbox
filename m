Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTDXFbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTDXFbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:31:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264429AbTDXFa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:30:57 -0400
Date: Wed, 23 Apr 2003 22:43:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <20030424051510.GK8931@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0304232217550.19326-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 Apr 2003, William Lee Irwin III wrote:
> 
> I'm not particularly interested in the high-flown moral issues, but
> this DRM stuff smelled like nothing more than a transparent ploy to
> prevent anything but bloze from booting on various boxen to me.

Let's be honest - to some people that is _exactly_ what DRM is. No ifs, 
buts and maybes. 

And hey, the fact is (at least as far as I'm concerned), that as long as
you make the hardware, you can control what it runs.

The GPL requires that you make the software available - but it doesn't 
require that the hardware be made so that you can always upgrade it.

You could write a kernel binary into a ROM, and solder it to the
motherboard. That's fine - always has been. As long as you give out the
sources to the software, there's nothing that says that the hardware has
to be built to make it easy - or even possible - to change the binary
there.

The beauty of PC's is how _flexible_ they are, and I think a lot of us
take that kind of flexibility for granted. But the fact is, 99% of the
worlds CPU's tend to go into devices that are _not_ general-purpose or
flexible. And it shouldn't offend us (at most it might make us pity the
poor hobbled hardware).

And there are projects for doing "Open Hardware" (like opencores.org etc),
and that may well end up being a hugely important thing to do. But Linux
is about open source, not open hardware, and hardware openness has never 
been a requirement for running Linux.

> But I suppose it could be used to force particular versions of Linux
> to be used, e.g. ones with particular patches that do permissions
> checks or various things meant to prevent warezing.

Yes, that too. Or it could well be used to allow _running_ of any version 
of Linux at all, but maybe the firmware/hardware combination only gives 
the kernel the keys needed to decrypt incoming cable or satellite feeds if 
it trusts the kernel. 

So under such schenarios, you might have a machine that works as a regular 
PC, but the satellite company requires that only kernels _it_ trusts get 
to unscrambe the incoming feed.

Unfortunate? Yes. I suspect that almost all of us would rather have
unlimited feeds, and just take it on trust that people would do the right
thing. But I can understand why especially embedded Linux users may want
to control these things - and maybe my moral sense is lacking, but I just
can't see myself saying "no, you can't use Linux for that".

> I'm largely baffled as to what this has to do with Linux kernel
> hacking, as DRM appeared to me to primarily be hardware- and firmware-
> level countermeasures to prevent running Linux at all, i.e. boxen we're
> effectively forbidden from porting to.

It has almost zero to do with the kernel code itself, since in the end all
the DRM stuff ends up being at a much lower level (actual hardware, as you
say, along with things like firmware - bioses etc - that decide on whether
to trust what they run).

So in that sense I don't believe it has much of anything to do with the
kernel: you're very unlikely to see any DRM code show up in the "kernel
proper", if that's what you're asking. Although obviously many features in
the kernel can be used to _maintain_ DRM control (ie somehting as simple
as having file permissions is obviously nothing but a very specific form
of rights management).

HOWEVER. The discussion really does matter from a "developer expectation"  
standpoint. There are developers who feel so strongly about DRM that they
do not want to have anything to do with systems that could be "subverted"
by a DRM check. A long private thread I've had over this issue has 
convinced me that this is true, and that some people really do expect the 
GPL to protect them from that worry.

And I do not want to have developers who _think_ that they are protected 
from the kinds of controls that signed binaries together with a fascist 
BIOS can implement. That just leads to frustration and tears. So I want 
this issue brought out in the open, so that nobody feels that they are 
being "taken advantage" of.

Again, from personal email discussions I know that this is a real feeling. 

So I really want to set peoples _expectations_ right. I'd rather lose a 
developer over a flame-war here on Linux-kernel as a result of this 
discussion, than having somebody unhappy later on about having "wasted 
their time" on a project that then allowed things to happen that that 
developer felt was inherently morally _wrong_.

And this is where it touches upon kernel development. Not because I expect
to apply DRM patches in the near future or anything like that: but simply
because it's better to bring up the issue so that people know where they
stand, and not have the wrong expectations of how their code might be used
by third parties.

			Linus

