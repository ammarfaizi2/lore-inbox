Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbREaRzJ>; Thu, 31 May 2001 13:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbREaRzA>; Thu, 31 May 2001 13:55:00 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:17673 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S263123AbREaRyt>;
	Thu, 31 May 2001 13:54:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: <linux-kernel@vger.kernel.org>
Subject: Odd Problem with onboard 3com card
Date: Thu, 31 May 2001 09:56:20 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01053109562000.28900@summanulla.clueserver.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing an odd problem with a single processor board running a 3com 
chipset.

eth0: 3Com PCI 3c905C Tornado at 0xd800,  00:e0:18:0b:10:e3, IRQ 4
  product code ffff rev 00.14 date 15-31-127
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather enabled. h/w checksums enabled

It is an Intel chipset (i815 according to system messages.) 

Not certain why eth0 is attaching itself to IRQ 4. (The bios screen is weird 
for this chipset. I think it believes it is a modem.)

When running the stock kernel from Redhat 7.1 with IP firewalling, the card 
would stall out if there was no traffic on the card for 30 seconds or so.

I rebuilt the kernel and stripped it down to the bare bones, with a few 
exceptions.  I removed power management (thinking it might be a "finigan's 
wake on lan" issue) and the firewalling code (thinking it might be some other 
sort of chokage). That reduced the problem greatly, but I still get messages 
from the Netscreen router telling me that that machine is not responding.  (I 
get one message every few hours.) Serial and parallel ports should be 
disabled on that box.

I do have mtrr and the uniprocessor APIC code enabled. I am also using memory 
map on the network card.

This is pretty frustrating. I have NEVER seen this kind of weirdness from 
that chipset.  (Though this is the first time I have used the on-board 
version.)

Ideas?

Please Cc me on the message as I am over 3,000 messages behind on the kernel 
list and it will probably get buried in the mass.
