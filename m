Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272238AbTHRSzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272242AbTHRSzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:55:05 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:32481 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272238AbTHRSy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:54:56 -0400
Date: Mon, 18 Aug 2003 20:55:07 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Paolo Ornati <javaman@katamail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
Message-ID: <20030818185507.GB8297@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Paolo Ornati <javaman@katamail.com>,
	linux-kernel@vger.kernel.org
References: <200308181127.43093.javaman@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200308181127.43093.javaman@katamail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 11:27:43AM +0200, Paolo Ornati wrote:
> Hi,
> (sorry for the OT but I think here someone will relpy :-)
> 
> Problem: I'm interested on PC architecture and looking for documentation I've 
> found al lot of good doc for the CPU (Intel manuals...) but about the basic 
> hardware that surround it I've found only a lot of "pieces of a puzzle"!
> 
> IOW: there is an (un)official document spoking about general PC architecture?
> 
> In this document I want to find some basic things about PC hardware and 
> especially about these themes (from the logical point of view):
> 
> 1) communication between CPU, memory, I/O devices:
> Example:
> If I write byte 'A' to physical address 0xb8000 how does this go to video 
> memory instead of RAM?
> I know about memory mapped I/O but I don't know who "decides" WHAT must go 
> WHERE.
> Since the CPU can't know if it's writing to memory or some memory mapped I/O 
> device I suppose that is the "BUS CONTROLLER" (PCI BRIDGE in case of a PCI 
> BUS) to write the byte 'A' to the right device.
> But how does the "BUS CONTROLLER" do this association?
> For now I think in this simple way:
> - all the devices are on the BUS and anyone has his own memory mapped I/O 
> addresses;
> - if no devices own the address that the CPU ask for the request go to real 
> memory.

google for 'IBM' 'PC' 'architecture' ...
and variants of 'Upper Memory' 'Shadow' 'VGA' ...

(for example ...)
http://www.pcguide.com/ref/ram/logicOverview-c.html
http://www.infokomp.no/techinfo/doc/DosMemory.htm
http://world.std.com/~swmcd/steven/rants/pc.html

> Curiosity: since the memory addresses from 640KB to 1MB are reserved for 
> memory mapped I/O (video memory) and BIOS ROM... the corrispondent range in 

uh oh ...

> the REAL MEMORY isn't usable and so we lost 384KB of memory. Is this right?

for DOS, withouth upper memory manager yes ;)

> And what about the I/O address space (IN, OUT x86 instructions)?
> I know this is a separate address space but...
> - how are the addresses assigned? In a static way?
> - for these instructions the CPU uses the same address (and data) lines that 
> when it try to acces to memory, how does this work?

there is a line (signal) telling if it is memory or I/O ...

> 2) Compatibilty issues:
> for example something about A20 line... is it possible that I found 
> information about this only in unofficial docs?
> I didn't know about it before. A day I've found on a web page something like 
> "enabling A20 line" and I've said: "A20 line? What is it?" ;-)
> 
> ...
> 
> Must I search info for any "piece of the puzzle"? This is OK for me but I want 
> to know AT LEAST which are the pieces!

HTH,
Herbert

> 
> 
> Bye,
> 	Paolo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
