Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281067AbRKKVBO>; Sun, 11 Nov 2001 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281068AbRKKVBE>; Sun, 11 Nov 2001 16:01:04 -0500
Received: from jgateadsl.cais.net ([205.252.5.196]:14881 "EHLO
	tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S281067AbRKKVAq>; Sun, 11 Nov 2001 16:00:46 -0500
Date: Sun, 11 Nov 2001 15:56:26 -0500 (EST)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Disk Performance
In-Reply-To: <Pine.LNX.4.10.10111111336030.13115-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0111111553220.17893-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Andre Hedrick wrote:

> The significance of the tuning code is not just for init events.
> Linux is the first and only OS to have the autodma down grade feature
> (Intel borrowed my model, approved by me).  This allows for kernel to auto
> reconfigure the drive to stablize the transfer rates to protect the data.
> Of course the ATA hardware has iCRC's un Ultra modes, but excessive
> retries which are/will be successfully defeat the power of Ultra
> transfers.  Therefore the tuning code in conjunction the the
> auto-down-grade functions will reduce the transfer rates until the iCRC's
> go away.  This is the 0x84/0x51 error pairs.  There are various reasons
> that can cause this error to occur; however, the first stage is to
> stablize the transport data path and then allow the SA or EU to examine
> the problems.

So the system will boot at ATA100, for example, and if errors are seen,
downgrade step by step until a satisfactory level is reached.  Perhaps, ATA66
or ATA33 and the system would continue proper operation still at a "somewhat
fast" (as compared to PIO) speed level AND in DMA mode, not PIO.  My situation
with the 6.31 driver has DMA being disabled by the driver when errors are
seen, as I think you have clearly stated.

?? I'm assuming no to this, but I'm curious: Is there any chance the driver
would "speed up" the transfers?  Ie: after a period of time at ATA33, would it
try ATA66, 100 again?  I suppose this makes more sense for things like
serial/modem communications where problems could come and go, but if one is
experiencing problems between the ATA circuitry, cable and drive, they'll
start good, get worse and never recover..?

-------------------------------------------------------------------------------
Maxwell Spangler
Program Writer
Greenbelt, Maryland, U.S.A.
Washington D.C. Metropolitan Area

