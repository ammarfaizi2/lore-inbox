Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRCTQ6W>; Tue, 20 Mar 2001 11:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRCTQ6N>; Tue, 20 Mar 2001 11:58:13 -0500
Received: from [213.97.45.174] ([213.97.45.174]:60936 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S130448AbRCTQ6I>;
	Tue, 20 Mar 2001 11:58:08 -0500
Date: Tue, 20 Mar 2001 17:56:47 +0100 (CET)
From: Pau <linuxnow@terra.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA serial CardBus support vanished in 2.4.3-pre3 and later
In-Reply-To: <Pine.LNX.4.31.0103200815250.1503-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0103201753590.1701-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Linus Torvalds wrote:

>
>
> On Tue, 20 Mar 2001, Alessandro Suardi wrote:
> >
> >  2.4.3-pre3 and synced-up versions of the -ac series remove support for
> >  PCMCIA serial CardBus. In drivers/char/pcmcia the Makefile and Config.in
> >  files are modified to exclude serial_cb and the serial_cb.c file itself
> >  is removed by the patch. As a net result, my Xircom modem port becomes
> >  invisible to the kernel and I can't dial out through it.
>
> The regular serial.c should handle it natively. Just make sure you have
> CONFIG_SERIAL enabled, along with hotplugging support etc.

In fact it does. I discovered it last weekend when my modem -them same one
than Alessandro's- stopped working.

Removing "alias char-major-4 serial_cb" from modules.conf did the trick
and the serial driver worked flawlessly. Modules serial got loaded
instead.

Pau

