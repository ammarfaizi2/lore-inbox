Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264232AbTE0WQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTE0WQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:16:09 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:60323 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264232AbTE0WQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:16:07 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 27 May 2003 15:29:08 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
In-Reply-To: <3ED3CDA9.5090605@winischhofer.net>
Message-ID: <Pine.LNX.4.55.0305271519210.1362@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net> 
 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com> 
 <3ED32BA4.4040707@winischhofer.net>  <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
 <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk> <3ED3CDA9.5090605@winischhofer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Thomas Winischhofer wrote:

> I patched the kernels of my 3 650 variants today (using a simpler
> variant than submitted by Davide), and it works well. They are running a
> webcam permanently, one is copying from and to a USB floppy in a loop,
> and I am using a USB mouse on all of them.
>
> The issue is that the 0x6x register hack seems to be required for _all_
> 96x variants. These come with the 740 as well as all 650 versions, and
> probably many of the older chips (645, etc), too.
>
> Unfortunately, I know of no way how to find out about these south
> bridges. They have the same PCI ID like the IRQ controller and ISA
> bridge of the 620, 530, 630 and the old 5595... and partly even the same
> revision number. Typical SiS stuff, lines up exactly with their graphics
> hardware...
>
> Vojtech recommended doing it like the IDE drivers, but - as I said to
> him - it feels a bit inappropriate to poke around in the IDE config
> space for IRQ reasons... But anyone interested should take a look into
> the newest 5513 ide driver (in the bk tree).

It does not look right to me either to poke the IDE controller. Another
solution might be to parse the routing table and gather informations from
there. Example, the findings of 0x61,...,0x63 will tell us that we're
dealing with newer chipsets that uses those for values for the 3 OHCI and
the EHCI. The revision ID trick seems not effective, at least looking at
your machine with rev-id 0 that has 0x61..63. Martin, was the revision id
0, that you suggested to be handled with the old router, minded ?



- Davide

