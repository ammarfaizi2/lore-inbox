Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279984AbRKDJf7>; Sun, 4 Nov 2001 04:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279985AbRKDJfw>; Sun, 4 Nov 2001 04:35:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54543 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279984AbRKDJfk>; Sun, 4 Nov 2001 04:35:40 -0500
Message-ID: <3BE50ABF.B51F7590@zip.com.au>
Date: Sun, 04 Nov 2001 01:30:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Meadors <clubneon@hereintown.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c556 basicly not working.
In-Reply-To: <3BE4BFA0.4DBF213F@zip.com.au> <Pine.LNX.4.33.0111040418050.28366-100000@clubneon.clubneon.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> 
> 
> Anything else you can think of?
> 

Yeah, but nothing which'll make your NIC work ;)

Please send me a copy of the `lspci -xxx' output for the device.
To do this, first run `lspci' with no args, to get this:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:03.0 Ethernet controller: 3Com Corporation 3c556B Laptop Hurricane (rev 20)
00:03.1 Communication controller: 3Com Corporation: Unknown device 1007 (rev 20)
00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion 
...

And then run

	lspci -xxx -s 00:03.0

Where the bus/slot/function identifiers refer to the 3com
device.  (Running lspci -xxx against all PCI devices is risky.)

-
