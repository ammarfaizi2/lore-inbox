Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129142AbRBLXRc>; Mon, 12 Feb 2001 18:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBLXRX>; Mon, 12 Feb 2001 18:17:23 -0500
Received: from [209.81.55.2] ([209.81.55.2]:39433 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129142AbRBLXRH>;
	Mon, 12 Feb 2001 18:17:07 -0500
Date: Mon, 12 Feb 2001 15:17:04 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <Pine.LNX.4.31.0102121147390.25638-100000@lairdtest1.internap.com>
Message-ID: <Pine.LNX.4.10.10102121456380.3761-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Feb 2001, Scott Laird wrote:
> 
> On 12 Feb 2001, H. Peter Anvin wrote:
> >
> > Just checked my own code, and SYSLINUX does indeed support 115200 (I
> > changed this to be a 32-bit register ages ago, apparently.)  Still
> > doesn't answer the question "why"... all I think you do is increase
> > the risk for FIFO overrun and lost characters (flow control on a boot
> > loader console is vestigial at the best.)
> 
> It's simple -- we want the kernel to have its serial console running at
> 115200, and we don't want to have to change speeds to talk to the
> bootloader. 

Exactly.

Then HPA may ask: but why do you want to run the serial console at
115200?? The answer is simple: because we can (or more precisely, because
the HW can ;).

If the hardware is supposed to support 115.2Kbps, why can't / shouldn't 
we use it?? Remember, this is not a modem connection, there is no
compression involved, both sides are running 115.2Kbps, so there should
NOT be a risk for FIFO overruns (unless you have buggy hardware). And in
this case, you can then decrease your baud rate. But at least you have the
_option_! :)


> Some boot processes, particularaly fsck, can be *REALLY*
> verbose on screwed up systems.  I've seen systems take hours to run fsck,
> even on small filesystems, simply because they were blocking on a 9600 bps
> console.

This is true!!

Another one (not as critical as the fsck though): when compiling the
kernel, sometimes the kernel compilation is done, but the console output
isn't finished yet (I'm serious).

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
