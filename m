Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265817AbSKAXdU>; Fri, 1 Nov 2002 18:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbSKAXdU>; Fri, 1 Nov 2002 18:33:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26555 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265817AbSKAXdT>;
	Fri, 1 Nov 2002 18:33:19 -0500
Date: Fri, 1 Nov 2002 15:35:49 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45 ipmr.c compile failure
In-Reply-To: <3DC2578E.999E569C@aitel.hist.no>
Message-ID: <Pine.LNX.4.33L2.0211011525300.28320-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| net/ipv4/ipmr.c: In function `ipmr_forward_finish':
| net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
| net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
| net/ipv4/ipmr.c:1170: structure has no member named `pmtu'

Several people reported this problem in 2.5.45.

I don't know how tough it is to check all combinations of config
options for such build problems, and I don't know how much code
and/or options there are in linux/net/ compared to linux/drivers/usb/,
but when I was the USB maintainer, before sending patches to Linus,
I would	use a script to build all of USB in-kernel and then build all
of USB as loadable modules.  This helped me make sure that easy-to-catch
problems didn't happen.

just an idea...
-- 
~Randy
(OK, net/ is about double the size of usb/)

