Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTLWDSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 22:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTLWDSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 22:18:17 -0500
Received: from bay8-dav33.bay8.hotmail.com ([64.4.26.90]:47116 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264930AbTLWDSF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 22:18:05 -0500
X-Originating-IP: [194.236.130.199]
X-Originating-Email: [nikomail@hotmail.com]
From: "Nicklas Bondesson" <nikomail@hotmail.com>
To: "'Walt H'" <waltabbyh@comcast.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Error mounting root fs on 72:01 using Promise FastTrak TX2000 (PDC20271)
Date: Tue, 23 Dec 2003 04:18:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <3FE7A35E.9090507@comcast.net>
Thread-Index: AcPI+gi1zCk2AukiSkaGh2jAGUI14wACRdvg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY8-DAV33OyDc41W2u00002b2b@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2003 03:18:04.0539 (UTC) FILETIME=[60F6FCB0:01C3C903]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch did not work for me, in fact there was no change at all (anything
affected to me). The Promise ataraid driver never gets loaded.

/Nicke 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Walt H
Sent: den 23 december 2003 03:07
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
(PDC20271)

Nicklas Bondesson wrote:
> Actually the 2.4.18 seems to be the only one working. I'm sure someone 
> out there have the proper fix for this. Who should I talk to in order 
> to get this fixed? I'm willing to help out in any way I can.
> 
> /Nicke

Well, not really sure. I thought Alan Cox did the original pdcraid.c for
linux some time back, but it really hasn't seen many changes. There were two
general Linux changes that took place back around 2.4.22 that might affect
you. The first, was the addition of the new Promise IDE driver, which you've
got configured. The second,  has to do with how Linux reports the geometry
of a drive. This change affected my setup which is why I wrote the patch for
the pdcraid driver. If your system makes it all the way through kernel
booting (which it seems to do), but can't mount the filesystem on the raid,
it seems to indicate the latter change affecting you also. The only other
thing I can think of, is to use my patch (attached) with patch -p1 <
pdcraid.patch from your /usr/src/linux and make sure that you've got both
Promise drivers compiled in your kernel. Recompile and see what happens.
Outside of that, I'm stuck. Good luck,

-Walt
