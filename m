Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275255AbTHSAxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275268AbTHSAxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:53:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21121 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275255AbTHSAxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:53:51 -0400
Date: Tue, 19 Aug 2003 01:53:45 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Paolo Ornati <javaman@katamail.com>
Cc: herbert@13thfloor.at, linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
Message-ID: <20030819005345.GD11081@mail.jlokier.co.uk>
References: <200308181127.43093.javaman@katamail.com> <20030818185507.GB8297@www.13thfloor.at> <200308182244.01727.javaman@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308182244.01727.javaman@katamail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> So I THINK YOU mean: "you can use more than 640KB in real mode using a memory 
> manager that "remap" 0xC0000 (for example) to 0x100000 or something like it"

As with all things PC, you cannot easily tell what RAM address it is
mapped to, but yes, it is remapped somewhere by the memory controller
so that it isn't wasted.

Perhaps on machines with lots of RAM this isn't done any more.

Also, these days there are other regions of RAM which you cannot see,
because they are only available to the BIOS, when the CPU is in SMM
mode :)

Your larger question, about how addresses are matched by the hardware,
is a complex one and it is different on different PC systems.  That is
some 20 years of computing history; it has changed a lot even though
many of the old programming methods continue to be supported.

Your best bet is to learn about PCI, PCI configuration space, PCI
transactions, PCI bridges and additive/subtractive decoding,
northbridge and southbridge chipsets (just what they are), PCI to ISA
bridge, legacy I/O controller (what provides most of the ISA space I/O
ports), AGP and GART, MTRR registers, and get some idea of how the
L1/L2/L3 cache hierarchy works.

And of course read all the big x86 manuals from developer.intel.com :-)

Your other large question, How does a PC work?, is huge because there
is much variety.  For example, on every other architecture in the
world, interrupts are quite simple, easy to program and easy to
understand.  On a modern PC they are extraordinarily complicated, to
the point where even the top kernel developers are still changing the
code, year on year, to workaround new surprises in different PCs.  As
you see, there is no readily available answer to your question
that is definitive for all the PCs out there.  Unfortunately.

-- Jamie
