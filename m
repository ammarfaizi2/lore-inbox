Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVFFXZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVFFXZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVFFXW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:22:58 -0400
Received: from [213.228.0.44] ([213.228.0.44]:19652 "EHLO postfix3-1.free.fr")
	by vger.kernel.org with ESMTP id S261777AbVFFXVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:21:34 -0400
Message-ID: <1118072623.42a46f2f472fd@imp1-q.free.fr>
Date: Mon,  6 Jun 2005 17:43:43 +0200
From: castet.matthieu@free.fr
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr> <42A46551.9010707@tls.msk.ru>
In-Reply-To: <42A46551.9010707@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 82.67.62.65
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Selon Michael Tokarev <mjt@tls.msk.ru>:

> matthieu castet wrote:
> > Michael Tokarev wrote:
> >

> In other message, you wrote:
>
> > In your bios, which mode is your parport ?
> >
> > Could you try LPPR mode (or something like that ?)
>
> Are you referring to ECP, EPP, Bi-Di etc modes?
> (note there's serial port too, which has exactly the same prob
> with (re)loading the driver).
>
Yes, but I don't know which LPPR is : there is one mode that use 1 ioport and
the other 2 ioports.
Try EPP ?

> > Have you try the patches ?
>
> Yes, tried the patches you sent last friday - from
> http://bugme.osdl.org/attachment.cgi?id=4504&action=view
> and from your message in this thread with MSGID = 429FF17C.9080902@free.fr
> (this last patch depends on the first).  Makes no (visible) difference
> on HP ML 150 box, the same stuff is shown in dmesg, and on reload neither
> parallel nor serial ports works.
>
> I'll try some more experiments later today (hopefully) when my co-workers
> (who are using this box right now so I can't freely reboot it as I wish)
> will go home... ;)
>
try to post
 cat /sys/bus/pnp/drivers/parport_pc/*/{options,resources}
and
cat /sys/bus/pnp/drivers/serial/*/{options,resources}

> BTW, looks like 8250_pnp module is also somewhat strange.  When loading
> 8250 alone, it detects (at least some) standard serial ports just fine,
> and when loading 8250_pnp, the same port is being "re-detected" again.
> But when unloading 8250_pnp, even when 8250 module is still loaded,
> that only port is disabled.  Looks somewhat.. assimetric to me, without
> counting issue with re-enabling of a pnp device.
yes there something strange...

Matthieu

