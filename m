Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316025AbSEJPmn>; Fri, 10 May 2002 11:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316027AbSEJPmm>; Fri, 10 May 2002 11:42:42 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:49678 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S316025AbSEJPmm>; Fri, 10 May 2002 11:42:42 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A44@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Steve Whitehouse'" <Steve@ChyGwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Fri, 10 May 2002 11:39:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The hang happens quickly after I start the test if using EXT3 or XFS,
it rarely happens when I use EXT2 filesystem. So I guess the behavior
is related to the file system buffer flush pattern.


xiangping

-----Original Message-----
From: Steven Whitehouse [mailto:steve@gw.chygwyn.com]
Sent: Friday, May 10, 2002 11:11 AM
To: chen, xiangping
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


Hi,

> 
> Hi,
> 
[deadlock conditions snipped]
> 
> The nbd_client get stuck in sock_recvmsg, and one other process stucks
> in do_nbd_request (sock_sendmsg). I will try to use kdb to give you
> more foot print.
> 
Anything extra you can send me like that will be very helpful.

> The system was low in memory, I started up 20 to 40 thread to do block
> write simultaneously.
> 
Ok. I'll have to try and set something similar up because I've not seen
any hangs with the latest nbd in 2.4 at all. Do you find that the hangs
happen relatively quickly after you start the I/O or is it something
which takes some time ?

Steve.
