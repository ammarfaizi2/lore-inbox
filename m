Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSGEQzn>; Fri, 5 Jul 2002 12:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317504AbSGEQzm>; Fri, 5 Jul 2002 12:55:42 -0400
Received: from ua247d38hel.dial.kolumbus.fi ([62.248.235.247]:63495 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S317503AbSGEQzk>; Fri, 5 Jul 2002 12:55:40 -0400
Message-ID: <3D25D019.ED2C703E@kolumbus.fi>
Date: Fri, 05 Jul 2002 19:58:01 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20 (also 
 withUltra133-TX2)
References: <3D14C06F.6010906@fabbione.net> <3D24A475.9CD70BE0@kolumbus.fi> <3D253A46.6050805@fabbione.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Massimo Di Nitto wrote:
> 
>         I found out that the problem was not the Promise controller
> but a bug in the ALI chipset. Disabling the specific driver for that
> chipset (and DMA as well :/ ) gives me atleast the possibility to work.
> The bug for the ALI was discussed in another thread.
> 
> What makes me worried now is that 2/3 people are reporting a similar
> problem but using different chipsets. Can be a problem located somewhere
> else???? Dunno..... just a guess.

In fact, I believe I found out that it's some weird driver interaction
problem.

I have an IDE controller on VIA 686B southbridge on motherboard and PDC20269
as a PCI card. Now, I had Linux on a drive attached to the VIA controller
without any problems. The drive became too small so I added the U133TX2 card
and a new drive and installed Linux on that one. No matter which one of the
installations is booted, the system will lock up if the VIA controller is in
use at the same time as the PDC. However, system seems to be stable (short
test priod though) if only the PDC controller is in use. (I left the old
drives attached to the VIA controller unmounted.)

Does this problem sound similar to yours?


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

