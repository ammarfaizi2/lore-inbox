Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316254AbSEKSVW>; Sat, 11 May 2002 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316257AbSEKSVW>; Sat, 11 May 2002 14:21:22 -0400
Received: from fungus.teststation.com ([212.32.186.211]:16398 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S316254AbSEKSVU>; Sat, 11 May 2002 14:21:20 -0400
Date: Sat, 11 May 2002 20:21:00 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Rui Sousa <rui.sousa@laposte.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Via-rhine problems (2.4.19-pre8)
In-Reply-To: <Pine.LNX.4.44.0205111651070.1365-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0205111911360.18398-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Rui Sousa wrote:

> kernel: eth0: reset did not complete in 10 ms.
> kernel: NETDEV WATCHDOG: eth0: transmit timed out
> kernel: eth0: Transmit timed out, status 0000, PHY status 782d, 
> resetting...
> 
> Removing the ethernet cable, unloading/loading the module doesn't change a
> thing, only a cold reboot fixes the problem (until next time).
> 
> Is this a known problem? Any fixes?

The effect (the timeout) can be caused by lots of things. Here it sounds
like the chip has locked up (more or less) since you need a cold boot to
recover. Why? Well ...

"Ivan G" has posted recently on via-rhine problems. For him it is only
that the driver stalls but not the need for a full reboot (IIRC).

Simple things you could try is to test some other variants of the driver:
 + Donald Becker's original
   http://www.scyld.com/network/via-rhine.html
 + VIAs modified version
   http://www.viaarena.com/?PageID=71#lan

If either works better then the next step would be to find out why (and 
copy those bits).

The diff between the VIA version and the other is large. I started looking
at merging what they have done to the in-kernel driver.

/Urban

