Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSHaQht>; Sat, 31 Aug 2002 12:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSHaQht>; Sat, 31 Aug 2002 12:37:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48653 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317616AbSHaQhs>; Sat, 31 Aug 2002 12:37:48 -0400
Date: Sat, 31 Aug 2002 09:49:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
In-Reply-To: <1030806402.3490.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208310940510.2129-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 Aug 2002, Alan Cox wrote:
>
> Related question while we are on the subject of bridges. I'm trying to
> work out a clean way to initialize a new subtree of devices given a
> bridge that suddenely has devices behind it.
> 
> This occurs in three cases I know about now 
> - Easidock cardbus->PCI extender
> - IBM Thinkpad hot docking bridge
> - Magma PCI extended split bridge

pci_do_scan_bus() should do almost everything for you. Pat Mochel had some
code that made the cardbus driver basically do just this on cardbus
insertion, you might ask him.

		Linus

