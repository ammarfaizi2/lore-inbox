Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268279AbRGWQB4>; Mon, 23 Jul 2001 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268275AbRGWQBq>; Mon, 23 Jul 2001 12:01:46 -0400
Received: from fungus.teststation.com ([212.32.186.211]:7946 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S268279AbRGWQBb>; Mon, 23 Jul 2001 12:01:31 -0400
Date: Mon, 23 Jul 2001 18:01:31 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Jaime Alexandre Bastos <JaimeAlex@DATINFOR.pt>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: RedHat 7.1 - Network messages
In-Reply-To: <5D478FF55EA3D311ACBF00062938832FFE51@DATPT01>
Message-ID: <Pine.LNX.4.30.0107231733020.7789-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001, Jaime Alexandre Bastos wrote:

> hi guys
> I have got a Pentium Celeron, 64Mb RAM, IDE Disk, 2 D-LINK FX-530 PCI
> Network´s installed with Linux RedHat 7.1 working as a firewall.
> I made a new kernel, and now I usually get some messages from the kernel
           ^^^^^^^^^^
So which version are you using now?

And which version of the DFE530-TX (not FX, I believe?) do you have?
The kernel output when it detects the cards (dmesg) or lspci output would 
answer that.

> which repeats a lot of times while the system is working.
> The messages are:
> 
> Jul 23 09:14:13 datdnn kernel: eth0: Oversized Ethernet frame spanned
> multiple buffers, entry 0xe length 0 status 00000600!
> Jul 23 09:14:13 datdnn kernel: eth0: Oversized Ethernet frame c37740e0 vs
> c37740e0.
> Jul 23 09:14:13 datdnn kernel: eth1: Oversized Ethernet frame spanned
> multiple buffers, entry 0x2 length 0 status 00000600!
> Jul 23 09:14:13 datdnn kernel: eth1: Oversized Ethernet frame c382c020 vs
> c382c020.

If you can figure out what is causing the messages I'd be interested to
know. Perhaps you can play with how your network looks, or examine network
traffic and see if there is some pattern (eg it only happens when machine
foo sends stuff to machine bar).

It's quite possible that the above warnings generate the errors below. But
I don't know what is going on.

> Jul 19 11:20:32 datdnn kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Jul 19 11:20:32 datdnn kernel: eth0: Transmit timed out, status 0000, PHY
> status 782d, resetting...
> 
> Please, I would like to know if this messages means everything bad in terms
> of fine function of the system and if so, what I should do to resolve the
> problem.
> I have the idea that specially when the last messages appear the system lose
> communication. 
> Sometimes I have to power off the system to get it fine again.

2.4.3 should be better than earlier versions, as that driver actually
resets the card when it gets "transmit timed out". There are some other
minor changes too from 2.4.3 to 2.4.7, so it could be worth testing the 
latest.

/Urban

