Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287781AbSBHV6I>; Fri, 8 Feb 2002 16:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291862AbSBHV6D>; Fri, 8 Feb 2002 16:58:03 -0500
Received: from guzzi.amazon.com ([209.191.164.151]:49642 "HELO
	guzzi.amazon.com") by vger.kernel.org with SMTP id <S287781AbSBHV5p>;
	Fri, 8 Feb 2002 16:57:45 -0500
Date: Fri, 8 Feb 2002 13:57:39 -0800 (PST)
From: Lamont Granquist <lamont@amazon.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux@sparker.net, <linux-kernel@vger.kernel.org>
Subject: Re: Sysrq enhancement: process kill facility
In-Reply-To: <200202081819.g18IJPa22033@devserv.devel.redhat.com>
Message-ID: <20020208134707.J47621-100000@synflood.amazon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Pete Zaitcev wrote:
> > You enter <alt>-<sysrq>-n ("nuke"), and then prompts for the pid.  It supports
> > backspace and control-U.  On serial ports, it retains the same semantics:
> > a break activates this as a sysrq sequence, but if more than 5-seconds pass
> > without any input, it drops out of processing input as a sysrq.
>
> I am afraid we'll have bash and perl in kernel before too long,
> if this avenue is to be pursued.
>
> Why don't you use something like SGI kdb for debugging kernels?

Its very useful to have adequate debugging tools for productions systems.
Something like SGIs kdb is too heavyweight and is not in the mainline
linux kernel and will never, ever get pushed out to any of the production
systems that I work on.  However, useful alt-sysrq tools to do post-mortem
analysis of crashed production kernels is something which is extremely
helpful.

What would be *really* useful would be to have crash dump functionality in
the mainline linux kernel.  That way you could take a dump and then do
your post-mortem offline with a debugger.  Until then I'm all in favor of
throwing bloat into alt-sysrq, since that seems to be Linus' preferred
interface for doing post-mortem analysis.

