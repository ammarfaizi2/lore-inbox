Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTHSIBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTHSIBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 04:01:46 -0400
Received: from mid-2.inet.it ([213.92.5.19]:60622 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S263637AbTHSIBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 04:01:44 -0400
From: Paolo Ornati <javaman@katamail.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [OT] Documentation for PC Architecture
Date: Tue, 19 Aug 2003 10:01:42 +0200
User-Agent: KMail/1.5.2
References: <200308181127.43093.javaman@katamail.com> <20030818225422.GA23927@www.13thfloor.at> <20030819010205.GE11081@mail.jlokier.co.uk>
In-Reply-To: <20030819010205.GE11081@mail.jlokier.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308191001.42094.javaman@katamail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 August 2003 03:02, Jamie Lokier wrote:
>
> The MMU _is_ used to remap memory addresses.  It is part of the CPU itself.
> But it translates what's called "virtual address" space to "physical
> address space".  Physical addresses seemingly map directly to RAM and
> memory-mapped I/O.

I know...

>
> Paolo's question is, what happens to the 384k of _physical_ addresses
> starting at 0xa0000, which should correspond with 384k of actual
> physical RAM?

It seems that only you have understand my question! :-)

>
> If you use the MMU to map a virtual address to the physical addresses from
> 0xa0000..0xfffff, then whichever virtual addresses you chose will map to
> video memory, ROM, BIOS etc.
>
> The answer is that after the MMU has translated, a _second_ address
> translation takes place, outside the CPU, which maps the physical addresses
> so that a hole is created in the RAM without any RAM going missing.  This
> second translation is done by the motherboard chipset.

OK.

>
> Enjyo,
> -- Jamie


VERY [OT]:

Why do I do all these questions?
At present I'm working on a very small kernel (PabloX :):
- it's very simple: it only uses segmentation and has drivers only for stupid 
things like AT-PS/2 keyboard (do you have USB keyboard? I'm sorry!)
- some (a lot of) code is taken from linux 0.01 / 1.0 / ... 

If anyone want to see this stupid thing:
http://members.xoom.virgilio.it/javaman/

NOTE: don't read the comments in source code! They are a mix of pseudo-English 
and Italian!

To try it:
tar xzf pablox.tar.gx
cd pablox/
make

now you should have a floppy image in ./IMAGE, I suggest insert a floppy and 
do "make disk", than reboot and see keyboard leds! (if you have an AT or PS/2 
keyboard)

press (1,2,3,4) to switch to console (1,2,3,4): the consoles are stupid! All 
the programs write to the current console...
press "ESC" to reboot!


Bye,
	Paolo

