Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUA3KYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 05:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUA3KYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 05:24:36 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:6673 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261784AbUA3KY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 05:24:29 -0500
Message-ID: <401A33CA.4050104@aitel.hist.no>
Date: Fri, 30 Jan 2004 11:36:58 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com>
In-Reply-To: <40195AE0.2010006@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> John Bradford wrote:
> 
[...]
>>> What I'm describing is a PC console graphics card that will let 
>>> someone play Quake III at a reasonable framerate.
>>>
>>> Isn't that what most people want?
>>
>>
>>
>> In the embedded and server markets, I don't see it being a major
>> requirement, actually.
>>
>> Just because a standard graphics card is going to do all they want and
>> be cheaper to develop, doesn't make it a requirement.
> 
> 
> Have you ever used a graphics card in VESA mode?  Dragging a window 
> around the screen and watching it repaint can be a very unenjoyable 
> thing to watch.  From what you've described, this is the sort of thing 
> you'd get.
> 
I run X on an unaccelerated framebuffer (1280x1024 16bit color) every day.
I don't even _notice_ a difference from accelerated X for a number of uses, 
such as word processing, watching movies with mplayer, web browsing and programming.
Dragging a window around is fine!
Simple opengl games like "frozen bubble" with software rendering are fine too,
on a 333MHz dual celeron.
The only stuff that don't work well is 3D-intensive stuff like quake and tuxracer.

(The unaccelerated xserver is running on the second head of a matrox G550.  The
primary head uses acceleration, but is often in use by another user.)


So a good 2D card is trivial - a video signal generator and memory on an AGP bus.
Let the host processor do software rendering.  Cheap, and I believe this is
the sort of thing embedded uses might go for when they want to display mostly
static stuff. (Web-based info kiosk and similiar).
Add a BIOS rom and you can even see what happens during boot on a pc.

The next step up is 2D acceleration, which is easy enough by sticking a
generic microprocessor there. Maybe an inexpensive celeron/duron.

Then there's 3D, and enough of it to play quake.  The first quakes ran
fine with software rendering and processors that were slow by today's
standards.  Todays cheap processors are faster - I wonder if putting 2-4 of 
them on the card might be enough. They'd be able to access the memory directly,
not limited to slow AGP/PCI speeds.  And they'd be able to divide the work
between them, rendering separate parts of the screen.
[...]
> - Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
> - AGP 2X
> - Up to 2048x2048 resolution at 8, 16, and 32 bpp.
Why bother with 8-bit?

> - Acceleration ONLY for solid fills and bitblts on-screen.
> 
> Given that so little is accelerated, there is no point in putting more 
> than the viewable framebuffer on the card, hense the 16 megs.  It would 
> probably actually HURT performance to cache pixmaps on the card.
> 
> 
> Oh, there's one thing I forgot.  It would have to support VGA.  There is 

Why VGA?  When you have a _driver_ , you don't need compatibility at all.
(Just like soundcards - they don't need soundblaster compatibility for anything)
The pc don't need vga - it can boot using the card's bios
Linux don't need vga - it will use the provided driver.
Apps don't need vga, they don't do that sort of thing anyway.  They
use the tty/X11/SDL/opengl.



> a VGA core on opencores.org that we could use, but its logic area would 
> probably push up the FPGA cost so that the board was in the $100 range. 
>  Probably more.

Another reason to drop VGA then - money.

Helge Hafting

