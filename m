Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281203AbRKLXri>; Mon, 12 Nov 2001 18:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281213AbRKLXrS>; Mon, 12 Nov 2001 18:47:18 -0500
Received: from ns.caldera.de ([212.34.180.1]:7650 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S281203AbRKLXrK>;
	Mon, 12 Nov 2001 18:47:10 -0500
Date: Tue, 13 Nov 2001 00:47:02 +0100
Message-Id: <200111122347.fACNl2I13494@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] crc32 cleanups
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <71714C04806CD5119352009027289217022C3F15@ausxmrr502.us.dell.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <71714C04806CD5119352009027289217022C3F15@ausxmrr502.us.dell.com> you wrote:
> More crc32 cleanups.  I think this is pretty close to being finished, and
> would appreciate people taking a look at the drivers they use regularly.
> I've built all the drivers I can on x86, and have hand-verified the rest.
>
> Changes since last time:
> * remove all the request_module() calls I added last time.  If a driver
> needs crc32.o and it's a module, modprobe pulls it in automatically.
> * Create {fs,drivers/net,drivers/usb}/Makefile.lib.  In each, list modules
> as obj-$(CONFIG_FOO) += crc32.o.  In lib/Makefile, include each
> Makefile.lib.  This allows drivers to update the list local to themselves
> and not have to patch lib/Makefile.  This should satisfy Keith Owens'
> concern in this regard.
> * Added a whole new set of drivers, those based on 8390.o, to the list.

Do you really need that complicated conditional compilation?
IMHO it's a much better idea to always compile the crc routines in,
maybe a way to disable it explicitly could be added, though I'm
not sure about that one.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
