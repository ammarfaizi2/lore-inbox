Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275336AbRIZRDI>; Wed, 26 Sep 2001 13:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275337AbRIZRC7>; Wed, 26 Sep 2001 13:02:59 -0400
Received: from chiara.elte.hu ([157.181.150.200]:3596 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275336AbRIZRCm>;
	Wed, 26 Sep 2001 13:02:42 -0400
Date: Wed, 26 Sep 2001 19:00:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alfred Munnikes <munnikes@cistron.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: spurious 8259A interrupt: IRQ7. AND VM: killing process
 ..
In-Reply-To: <3BB200C2.7D7E84B4@cistron.nl>
Message-ID: <Pine.LNX.4.33.0109261855220.6377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, Alfred Munnikes wrote:

> first is gives the message "spurious 8259A interrupt: IRQ7." and I
> don't think that is normal for a PCI clock generator.

unless you see lockups or a high number of these messages, this is nothing
to worry about.

> eth0: RealTek RTL-8029 found at 0xe000, IRQ 10, 00:00:B4:B6:73:BC.

> spurious 8259A interrupt: IRQ7.
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=26.
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=23.

apparently interrupt 10 got lost and was delivered as a spurious
interrupt. This can be the result of out-of-spec hardware. (card or
board.)

	Ingo

