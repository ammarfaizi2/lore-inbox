Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271341AbTHRJ3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 05:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTHRJ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 05:29:12 -0400
Received: from mid-1.inet.it ([213.92.5.18]:64978 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S271341AbTHRJ3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 05:29:09 -0400
From: Paolo Ornati <javaman@katamail.com>
Subject: [OT] Documentation for PC Architecture
Date: Mon, 18 Aug 2003 11:27:43 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308181127.43093.javaman@katamail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
(sorry for the OT but I think here someone will relpy :-)

Problem: I'm interested on PC architecture and looking for documentation I've 
found al lot of good doc for the CPU (Intel manuals...) but about the basic 
hardware that surround it I've found only a lot of "pieces of a puzzle"!

IOW: there is an (un)official document spoking about general PC architecture?

In this document I want to find some basic things about PC hardware and 
especially about these themes (from the logical point of view):

1) communication between CPU, memory, I/O devices:
Example:
If I write byte 'A' to physical address 0xb8000 how does this go to video 
memory instead of RAM?
I know about memory mapped I/O but I don't know who "decides" WHAT must go 
WHERE.
Since the CPU can't know if it's writing to memory or some memory mapped I/O 
device I suppose that is the "BUS CONTROLLER" (PCI BRIDGE in case of a PCI 
BUS) to write the byte 'A' to the right device.
But how does the "BUS CONTROLLER" do this association?
For now I think in this simple way:
- all the devices are on the BUS and anyone has his own memory mapped I/O 
addresses;
- if no devices own the address that the CPU ask for the request go to real 
memory.

Curiosity: since the memory addresses from 640KB to 1MB are reserved for 
memory mapped I/O (video memory) and BIOS ROM... the corrispondent range in 
the REAL MEMORY isn't usable and so we lost 384KB of memory. Is this right?

And what about the I/O address space (IN, OUT x86 instructions)?
I know this is a separate address space but...
- how are the addresses assigned? In a static way?
- for these instructions the CPU uses the same address (and data) lines that 
when it try to acces to memory, how does this work?

2) Compatibilty issues:
for example something about A20 line... is it possible that I found 
information about this only in unofficial docs?
I didn't know about it before. A day I've found on a web page something like 
"enabling A20 line" and I've said: "A20 line? What is it?" ;-)

...

Must I search info for any "piece of the puzzle"? This is OK for me but I want 
to know AT LEAST which are the pieces!


Bye,
	Paolo

