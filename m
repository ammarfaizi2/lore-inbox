Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270648AbRHJV0Q>; Fri, 10 Aug 2001 17:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270649AbRHJV0G>; Fri, 10 Aug 2001 17:26:06 -0400
Received: from imladris.infradead.org ([194.205.184.45]:18193 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270648AbRHJVZz>;
	Fri, 10 Aug 2001 17:25:55 -0400
Date: Fri, 10 Aug 2001 22:25:51 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <3B737FE4.3D0998D3@yahoo.com>
Message-ID: <Pine.LNX.4.33.0108102221050.20472-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

 >> One of my systems has SIX ethernet cards, these being three ISA
 >> and two PCI NE2000 clones and a DEC Tulip. Here's the relevant
 >> section of modules.conf on the system in question:
 >>
 >>  Q> alias eth0 ne
 >>  Q> options eth0 io=0x340
 >>  Q> alias eth1 ne
 >>  Q> options eth1 io=0x320
 >>  Q> alias eth2 ne
 >>  Q> options eth2 io=0x2c0
 >>  Q> alias eth3 ne2k-pci
 >>  Q> alias eth4 ne2k-pci
 >>  Q> alias eth5 tulip

 > You have six drivers loaded, when you only need three (i.e.
 > io=0x340,0x320,0x2c0 for ne options etc. etc). So you end up
 > wasting some memory, and a worse icache behaviour as well.

Are you sure of this? My understanding (both from reading the code and
from what others I respect have said) is that it is impossible to load
any given module more than once, so the above will result in one copy
each of the ne, ne2k-pci and tulip drivers being loaded.

 > (the latter is probably a non-issue if you are happy with ISA)

It's not so much a case of being "happy with ISA" as of needing six
interfaces on the same box, and it only has the three PCI slots...

Best wishes from Riley.

