Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270553AbRHNKy3>; Tue, 14 Aug 2001 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270557AbRHNKyU>; Tue, 14 Aug 2001 06:54:20 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:26036 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S270553AbRHNKyC>; Tue, 14 Aug 2001 06:54:02 -0400
Date: Tue, 14 Aug 2001 11:54:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c905b works with 10bt hub - not with 10/100 switch
Message-ID: <20010814115413.B23566@flint.arm.linux.org.uk>
In-Reply-To: <20010814021445.A7454@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010814021445.A7454@vitelus.com>; from aaronl@vitelus.com on Tue, Aug 14, 2001 at 02:14:45AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 02:14:45AM -0700, Aaron Lehmann wrote:
> eth2: 3Com PCI 3c905B Cyclone 100baseTx at 0xe000,  00:10:4b:79:46:76, IRQ 12
>   product code 4e4b rev 00.9 date 04-17-98
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
>   MII transceiver found at address 24, status 786d.
>   Enabling bus-master transmits and whole-frame receives.
> eth2: scatter/gather enabled. h/w checksums enabled
>
> This morning, the connection between these two machines (and a few
> others which were idle or powered down) was a very simple 5 port 10
> base T hub. This makes NFS pretty miserable, which is why I installed
> a CentreCOM FS704 Fast Ethernet switch in place of the hub today. At
> first, it worked great. The machines negotiated full duplex and were
> on the network. I was able to get expected speeds out of the network.

Interesting point here - did you check whether the 3c905B was in 10bT
or 100bTx mode?

The reason I ask is that I have a FH705 hub at home, with a 3c905C Tornado
card.  It normally negociates 100bTx with the hub at power on, but
if for whatever reason it drops down to 10bT, the only way of getting
it back to 100bTx is with a power cycle of the 3c905C (and hence the
machine).

No amount of prodding with mii-diag (forcing media selections, resetting
the mii transceiver) will recover it - only a power cycle solves it.

Luckily, it doesn't do it spontaneously, and has been running at 100bTx
for the past months.  Since it is my main server, and works, I'm not too
eager to investigate futher.  You might be interested in this data point
however.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

