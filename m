Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269859AbRHDTlt>; Sat, 4 Aug 2001 15:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269858AbRHDTlk>; Sat, 4 Aug 2001 15:41:40 -0400
Received: from [194.205.184.45] ([194.205.184.45]:41226 "EHLO infradead.org")
	by vger.kernel.org with ESMTP id <S269857AbRHDTl2>;
	Sat, 4 Aug 2001 15:41:28 -0400
Date: Sat, 4 Aug 2001 20:35:37 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
cc: Chris Wedgwood <cw@f00f.org>, Mark Atwood <mra@pobox.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <996888738.24442.1.camel@tduffy-lnx.afara.com>
Message-ID: <Pine.LNX.4.33.0108042028320.16941-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas.

 >> the kernel calls modprobe asking for the network device 'eth0',
 >> modprobe uses the configuration file to map this to a module

 > so, what happens when you have two eth cards that use the same
 > module? in the isa land, the order you pass the io=0x300,0x240
 > would determine which order the eth?'s go to...how about in the
 > pci world?

One of my systems has SIX ethernet cards, these being three ISA and
two PCI NE2000 clones and a DEC Tulip. Here's the relevant section of
modules.conf on the system in question:

 Q> alias eth0 ne
 Q> options eth0 io=0x340
 Q> alias eth1 ne
 Q> options eth1 io=0x320
 Q> alias eth2 ne
 Q> options eth2 io=0x2c0
 Q> alias eth3 ne2k-pci
 Q> alias eth4 ne2k-pci
 Q> alias eth5 tulip

Best wishes from Riley.

