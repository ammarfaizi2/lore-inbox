Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbQLRSjv>; Mon, 18 Dec 2000 13:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbQLRSjm>; Mon, 18 Dec 2000 13:39:42 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:61492 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130325AbQLRSjf>; Mon, 18 Dec 2000 13:39:35 -0500
Date: Mon, 18 Dec 2000 20:16:22 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Michael Illgner <fillg1@web.de>
cc: andrewm@uow.edu.au, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Problem with 3c59x and 3C905B
In-Reply-To: <JDEJLKPAIGJAKBJPIALIIEKOCBAA.fillg1@web.de>
Message-ID: <Pine.LNX.4.21.0012182012210.8296-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Michael Illgner wrote:

> Hi folks,
> I have some trouble using a 3COM NIC905B and the 3c59x driver with kernel
> 2.2.x
> and 2.4.0.testx. First of all the card works fine with Windows or with linux
> 2.2.18
> using the 3c90x driver supplied by 3COM. But with the 3c59x driver I get
> transfer rates

This kernel is a stock 2.2.17 with acl patches (doesn't change anything
network-related).

Bootup msg :

3c59x.c 16Aug00 Donald Becker and others
http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905B Cyclone 100baseTx at 0x6c00,  00:10:5a:68:ea:ad, IRQ 11
8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
MII transceiver found at address 24, status 786d.
MII transceiver found at address 0, status 786d.
Enabling bus-master transmits and whole-frame receives.

> below 10k/s or even lower. The card is connected to a 10/100 Hub (Netgear
> DS104).

You're sure that hub can handle full-fuplex mode ? Because that's what the
card uses in your case.

> Here are some informations
> 
> Kernel version
> 
> 2.2.18 SMP and 2.4.0.test12 SMP (latest kernel) but the problem seems
> to be independent of the kernel version.
> 
> 
> Banner message
> 
> Dec 17 19:44:48 ganerc kernel: 3c59x.c:LK1.1.11 13 Nov 2000  Donald Becker
> and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
> Dec 17 19:44:48 ganerc kernel: See Documentation/networking/vortex.txt
> Dec 17 19:44:48 ganerc kernel: eth0: 3Com PCI 3c905B Cyclone 100baseTx at
> 0xdc00,  00:10:5a:d8:25:f1, IRQ 19
> Dec 17 19:44:48 ganerc kernel: Full duplex capable
> Dec 17 19:44:48 ganerc kernel:   8K byte-wide RAM 5:3 Rx:Tx split,
> autoselect/Autonegotiate interface.
> Dec 17 19:44:48 ganerc kernel:   MII transceiver found at address 24, status
> 786d.
> Dec 17 19:44:48 ganerc kernel:   MII transceiver found at address 0, status
> 786d.
> Dec 17 19:44:48 ganerc kernel:   Enabling bus-master transmits and
> whole-frame receives.
> Dec 17 19:44:48 ganerc kernel: eth0: using NWAY autonegotiation

Ik hate everything that has the word 'auto' in it. Usually means problems.

<snip>

I suggest you start at that hub. The fact that you state that is is kernel
independant makes me think it's not a kernel / driver bug, but that your
network chokes on the autoconfig.




	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
