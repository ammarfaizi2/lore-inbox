Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbUKFVV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbUKFVV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbUKFVV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:21:58 -0500
Received: from mx.inch.com ([216.223.198.27]:25607 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261470AbUKFVVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:21:55 -0500
Date: Sat, 6 Nov 2004 16:23:27 -0500
From: John McGowan <jmcgowan@inch.com>
To: linux-kernel@vger.kernel.org
Subject: Re: (non) "bug" in 810 (kernel 2.6.9)
Message-ID: <20041106212327.GA3592@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: (non) "bug" in 810 (kernel 2.6.9)

I had reported a problem with getting a working screen in X with kernel
2.6.9. It is not a bug, but a change.

It may have annoyed you a bit, but it annoyed me far more, I assure you
(though I was sure one could use Knoppix to patch, recompile and reinstall a
kernel one had played around with on a hard disk and which would only boot
into a "panic"- now I know one can do it).

In Fedora Core2, the xorg-rpm has a dependency of "kernel-drm" and while I
like to configure and compile a kernel with my options, I left in the
DRI/drm item for the Intel 810 chip. I like 24 bit color and since kernel
2.2.? there was no problem. One might not have acceleration, but one could
use a 24 bit screen with drm compiled in. It was true in 2.4. In 2.6.[1-8].
It is not true in kernel 2.6.9. While it used to be that if the driver did
not support it, acceleration simply was not used. Now, even commenting out
any mention of dri in xorg.conf is not sufficient in 2.6.9 (at least for my
system) to get a workable screen. Adding the option,
 Option "NoAccel" "true",
however, does get me a working screen at 1024x768, 24 bit color.

However, I don't seem to get a working screen with acceleration enabled for
a 1024x768 16 bit screen.

On the other hand, I do get a working 1024x768 24 bit screen using the
Intel 8x0 framebuffer driver (with generalized timing to get better than a
60Hz refresh rate).

I had tried quite a bit, from modifying the 2.6.8->2.6.9 kernel patch (which
is how I wound up with a system with a single kernel which would only
"panic") through rebuilding the Xorg RPM.

I feel like rather a fool to find out that while there may be a problem (as
I don't seem to have a working 16 bit screen with DRI) what I use (24 bit)
was just a matter of the proper configuration (though a change from what
worked for all prior 2.x kernels I had used).
