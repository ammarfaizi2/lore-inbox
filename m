Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLAEUz>; Thu, 30 Nov 2000 23:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQLAEUq>; Thu, 30 Nov 2000 23:20:46 -0500
Received: from mail.du.gtn.com ([194.77.9.57]:65499 "EHLO mail.du.gtn.com")
	by vger.kernel.org with ESMTP id <S129345AbQLAEUd>;
	Thu, 30 Nov 2000 23:20:33 -0500
>Received: (from bj@localhost)
	by warp.zuto.de (8.9.3/8.9.3/Debian 8.9.3-6) id VAA22747
	for linux-kernel@vger.kernel.org; Thu, 30 Nov 2000 21:45:29 +0100
Date: Thu, 30 Nov 2000 21:45:28 +0100
From: Rainer Clasen <bj@zuto.de>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bonding...
Message-ID: <20001130214528.E24351@zuto.de>
Reply-To: bj@zuto.de
Mail-Followup-To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0011291619440.22577-100000@asdf.capslock.lan> <975575796.3a261af501379@imp.free.fr>
Mime-Version: 1.0
User-Agent: Mutt/1.0.1i
In-Reply-To: <975575796.3a261af501379@imp.free.fr>; from wtarreau@free.fr on Thu, Nov 30, 2000 at 10:16:37AM +0100
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 10:16:37AM +0100, Willy Tarreau wrote:
> > When using ethernet bonding, does it divide the load between the
> > two based on connection, or packet by packet?
> 
> packet by packet, so you can use both links to aggregate your bandwidth. I've
> used it at 200 Mbps with success.

Linux distributes outgoing outgoing packets in a round robin manner.

Ciscos are supposed to do this based on the XOr value of the last two bits
of source AND destination MAC. 

I was astonished to see a Catalyst2924EN distribute traffic EITHER by
source OR by destination MAC address (configurable). 

My BayStack450 seems to do roind robin, too.

Ciscos MAC based distribution limits each TCP connection to 100 Mbps.

 Rainer


PS: Thanks to Willy for his work on the bonding driver. 

-- 
KeyID=58341901 fingerprint=A5 57 04 B3 69 88 A1 FB  78 1D B5 64 E0 BF 72 EB

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
