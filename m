Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRBLXkX>; Mon, 12 Feb 2001 18:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbRBLXkN>; Mon, 12 Feb 2001 18:40:13 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:15357 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129723AbRBLXkA>;
	Mon, 12 Feb 2001 18:40:00 -0500
Date: Tue, 13 Feb 2001 00:39:20 +0100
From: David Weinehall <tao@acc.umu.se>
To: Ivan Passos <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: LILO and serial speeds over 9600
Message-ID: <20010213003920.A21164@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.31.0102121147390.25638-100000@lairdtest1.internap.com> <Pine.LNX.4.10.10102121456380.3761-100000@main.cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10102121456380.3761-100000@main.cyclades.com>; from lists@cyclades.com on Mon, Feb 12, 2001 at 03:17:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 03:17:04PM -0800, Ivan Passos wrote:
> 
> On Mon, 12 Feb 2001, Scott Laird wrote:
> > 
> > On 12 Feb 2001, H. Peter Anvin wrote:
> > >
> > > Just checked my own code, and SYSLINUX does indeed support 115200 (I
> > > changed this to be a 32-bit register ages ago, apparently.)  Still
> > > doesn't answer the question "why"... all I think you do is increase
> > > the risk for FIFO overrun and lost characters (flow control on a boot
> > > loader console is vestigial at the best.)
> > 
> > It's simple -- we want the kernel to have its serial console running at
> > 115200, and we don't want to have to change speeds to talk to the
> > bootloader. 
> 
> Exactly.
> 
> Then HPA may ask: but why do you want to run the serial console at
> 115200?? The answer is simple: because we can (or more precisely, because
> the HW can ;).
> 
> If the hardware is supposed to support 115.2Kbps, why can't / shouldn't 
> we use it?? Remember, this is not a modem connection, there is no
> compression involved, both sides are running 115.2Kbps, so there should
> NOT be a risk for FIFO overruns (unless you have buggy hardware). And in
> this case, you can then decrease your baud rate. But at least you have the
> _option_! :)
> 
> 
> > Some boot processes, particularaly fsck, can be *REALLY*
> > verbose on screwed up systems.  I've seen systems take hours to run fsck,
> > even on small filesystems, simply because they were blocking on a 9600 bps
> > console.
> 
> This is true!!
> 
> Another one (not as critical as the fsck though): when compiling the
> kernel, sometimes the kernel compilation is done, but the console output
> isn't finished yet (I'm serious).

Dunno about others, but I always pipe stdout to /dev/null when compiling
kernels. This way, everything important is still shown (warnings/errors)
as those go to stderr anyway, and all non-interesting stuff goes down
the drain.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
