Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbUAGGqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUAGGqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:46:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:49608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265066AbUAGGqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:46:17 -0500
Date: Tue, 6 Jan 2004 22:45:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Andi Kleen <ak@colin2.muc.de>, Adam Belay <ambx1@neo.rr.com>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040107060842.GA22884@redhat.com>
Message-ID: <Pine.LNX.4.58.0401062243160.12602@home.osdl.org>
References: <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
 <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de>
 <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com>
 <Pine.LNX.4.58.0401062000490.12602@home.osdl.org> <20040107050256.GA4351@colin2.muc.de>
 <20040107055557.GA13812@redhat.com> <Pine.LNX.4.58.0401062203040.12602@home.osdl.org>
 <20040107060842.GA22884@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, Dave Jones wrote:
> 
> But PNPBIOS is an ISA relic isn't it ?

It still shows up. BIOSes use it exactly to tell the system about reserved 
magic IO regions (like the IO registers that are reserved for ACPI).

ISA may be gone, but the crap it left behind lingers on. The BIOS writers 
know that they can affect windows IO region allocation with it, so they 
still do - to make sure windows boots even when the hardware has some 
strange IO resource allocations. 

And yes, that is likely to be an issue on x86-64 too.. As far as windows 
is concerned, it's just another 32-bit CPU.

		Linus
