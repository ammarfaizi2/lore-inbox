Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130433AbRCPIJ5>; Fri, 16 Mar 2001 03:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRCPIJr>; Fri, 16 Mar 2001 03:09:47 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:25231 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S130433AbRCPIJi> convert rfc822-to-8bit;
	Fri, 16 Mar 2001 03:09:38 -0500
Date: Fri, 16 Mar 2001 09:08:06 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Mårten Wikström <Marten.Wikstrom@framfab.se>
cc: Rik van Riel <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: RE: How to optimize routing performance
In-Reply-To: <E6D22E487D45D411931B00508BCF93E75C0329@storeg001.framfab.se>
Message-ID: <Pine.LNX.4.21.0103160859580.32076-100000@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Mårten Wikström wrote:

[much text] 
> Thanks! I'll try that out. How can I tell if the driver supports
> CONFIG_NET_HW_FLOWCONTROL? I'm not sure, but I think the cards are
> tulip-based, can I then use Robert & Jamal's optimised drivers?
> It'll probably take some time before I can do further testing. (My employer
> thinks I've spent too much time on it already...).

I don't really know how to tell except
'grep CONFIG_NET_HW_FLOWCONTROL driverfiles'

You said that the cards where 100Mbit DEC cards, I assumed that by that
you meant that the cards use DECchip 21143 or similar chips.
If that's true you can use Robert & Jamal's optimised drivers.

Sorry to hear that your employer doesn't see the importance in such a test
:)

> FYI, Linux had _much_ better delay variation characteristics than FreeBSD.
> Typically no packet was delayed more than 100usec, whereas FreeBSD had some
> packets delayed about 2-3 msec.

This sounds promising. So Linux had nice variations until it broke down
completely and stopped routing because of all the interrupts. I can almost
guarantee that with the optimised driver and CONFIG_NET_HW_FLOWCONTROL
you'll see a _big_ improvement in routingperformance.

/Martin

