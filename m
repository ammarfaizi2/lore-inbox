Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270345AbTHGTkR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270469AbTHGTkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:40:17 -0400
Received: from host81-136-142-241.in-addr.btopenworld.com ([81.136.142.241]:9963
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S270345AbTHGTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:40:07 -0400
Date: Thu, 7 Aug 2003 20:40:02 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: Fridtjof Busse <fbusse@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc1
Message-ID: <Pine.LNX.4.53.0308072035300.25633@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Hits: -0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I only see this with 2.4.22-pre/rc, so this is definitly not a
> hardware-problem, it runs just fine with 2.4.21 at 9950 kB/s.

Sounds exactly like the problem i was having. However the logical
thought behind it was that it must be either 1) a hardware specific
problem, or 2) a generic usb driver problem. Since only a handful
of people seen the problem, then this logically leads one to the
conclusion that our usb<->ide devices have some marginal timing
issues that are being triggered with the new code.

> And running my backup on USB 1.1 is not an option, way to slow.

Well in my case i opted for the slow backup rather than the no backup
if i wanted to move forward with the new kernels.

Cheers
Mitch

-------- Original Message --------
Subject: Re: Linux 2.4.22-rc1
Date: Thu, 7 Aug 2003 17:45:06 +0200
From: Fridtjof Busse <fbusse@gmx.de>
To: linux-kernel@vger.kernel.org
CC: Mitch@0Bits.COM
References: <Pine.LNX.4.53.0308071119200.27424@mx.homelinux.com>
<15050.1060270543@www56.gmx.net>

* <Mitch@0Bits.COM>:
> Not enough info.
>
> What usb controller do you have ? Which usb driver ?
> ohci ? uhci ? ehci ? usb 2.0 ?

nforce2 with the ehci-driver.

> I reported this a long time ago on the usb lists, but
> never got down to the bottom of the problem (my fault for
> not following thru).

I also reported this problem there, but didn't get a reply at all.

> However if i disable the usb 2.0
> driver (i.e. not loading the ehci driver) which my external
> storage is connected to, then everything works fine - albeit
> it much more slowly. Appears to be a timing issue on some
> usb <-> ide controller chips since not everyone is seeing this.

Well, I only see this with 2.4.22-pre/rc, so this is definitly not a
hardware-problem, it runs just fine with 2.4.21 at 9950 kB/s.
And running my backup on USB 1.1 is not an option, way to slow.

-- 
Fridtjof Busse
panic("Lucy in the sky....");
	2.2.16 /usr/src/linux/arch/sparc64/kernel/starfire.c

