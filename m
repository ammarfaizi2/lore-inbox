Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbUK0BgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbUK0BgC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUKZTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:39:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262361AbUKZTVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:21:48 -0500
Message-ID: <015701c4d351$802b4e70$0101140a@fortinet.com>
From: "Wenping  Luo" <wluo@fortinet.com>
To: "Roger Luethi" <rl@hellgate.ch>
Cc: <linux-kernel@vger.kernel.org>
References: <011801c4d270$cca65740$0101140a@fortinet.com> <20041125215413.GC1843@k3.hellgate.ch>
Subject: Re: ethernet Via-rhine driver 1.1.17 duplex detection issue in linux kernel 2.4.25
Date: Thu, 25 Nov 2004 16:47:26 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-Fortimail-Filter: processed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Roger Luethi" <rl@hellgate.ch>
To: "Wenping Luo" <wluo@fortinet.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, November 25, 2004 1:54 PM
Subject: Re: ethernet Via-rhine driver 1.1.17 duplex detection issue in
linux kernel 2.4.25


> On Wed, 24 Nov 2004 13:58:58 -0800, Wenping  Luo wrote:
> > I used crossed ethernet cable to connect one ethernet NIC to a Via Rhine
III
> > VT6105M NIC. I set the speed mode of Rhine Nic to be "auto" whereas I
forced
> > the peer NIC to be "100 Full Duplex". The Rhine NIC connected in mode of
> > "100 Half Duplex" , instead of "100 Full Duplex", after detecting the
peer.
> >
> > I searched the Internet and I found another reported for similiar issue
at
> > http://lunar-linux.org/pipermail/lunar/2004-April/003894.html. However,
> > there is no answer for this issue yet.
>
> Does it work with 2.6.10-rc? Do other card/driver combinations correctly
> detect the setting of your peer NIC?
Both of my NICs are running in 2.4.25. What I found out is that the Rhine
that sets to be "100 full duplex" doesn't send the advertisement correctly.
I made a fix to set the advertisement register accordingly and then to turn
on the autonegotiation bit. It worked for Via Rhine III.

It seems other NIC, like e100(Intel Pro 100M), has similiar issue. However,
the similiar fix doesn't work for it.

I don't have 2.6.10-rc installed so that I don't know. But I looked at the
patch related to via-rhine.c. It doesn't look like it has been fixed.
>
> Roger

