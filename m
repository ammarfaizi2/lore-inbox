Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130498AbQLINjH>; Sat, 9 Dec 2000 08:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130773AbQLINi5>; Sat, 9 Dec 2000 08:38:57 -0500
Received: from gadolinium.btinternet.com ([194.73.73.111]:61913 "EHLO
	gadolinium.btinternet.com") by vger.kernel.org with ESMTP
	id <S130498AbQLINiz>; Sat, 9 Dec 2000 08:38:55 -0500
Date: Sat, 9 Dec 2000 13:08:21 +0000 (GMT)
From: davej@suse.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <E144jVc-0005Lk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012091303080.556-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2000, Alan Cox wrote:

> > Or is there borked hardware out there that require drivers to say
> > "This cacheline size must be xxx bytes, anything else will break" ?
> If there is surely the driver can override it again before enabling the
> master bit or talking to the device ?

The pdev_enable_device() stuff is marked __init, so done once at boottime.
So yes, a driver could then fix up during initialisation if necessary.
I was curious whether there are any known cases, or can the stuff
in the existing drivers be nuked if/when x86 calls pdev_enable_device().

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
