Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAQIxB>; Wed, 17 Jan 2001 03:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRAQIwv>; Wed, 17 Jan 2001 03:52:51 -0500
Received: from mspool.gts.cz ([212.47.0.11]:41995 "EHLO mspool.gts.cz")
	by vger.kernel.org with ESMTP id <S129835AbRAQIwe>;
	Wed, 17 Jan 2001 03:52:34 -0500
Date: Wed, 17 Jan 2001 09:52:21 +0100
From: Martin Mares <mj@suse.cz>
To: Adam Lackorzynski <al10@inf.tu-dresden.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
Message-ID: <20010117095221.A553@albireo.ucw.cz>
In-Reply-To: <20010116181207.A1325@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116181207.A1325@inf.tu-dresden.de>; from al10@inf.tu-dresden.de on Tue, Jan 16, 2001 at 06:12:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The patch below (against vanilla 2.4.0) makes Linux recognize
> PCI-Devices sitting in another PCI bus than 0 (or 1).
> 
> This was tested on a Netfinity 7100-8666 using a ServerWorks chipset.

I don't have the ServerWorks chipset documentation at hand, but I think your
patch is wrong -- it doesn't make any sense to scan a bus _range_. The registers
0x44 and 0x45 are probably ID's of two primary buses and the code should scan
both of them, but not the space between them.

Anyway, could you send me a `lspci -MH1 -vvx' and `lspci -vvxxx -s0:0', please?
 
				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
System going down at 5 pm to install scheduler bug.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
