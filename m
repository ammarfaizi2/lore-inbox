Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUA3Q6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUA3Q6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:58:39 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:39172 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262308AbUA3Q6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:58:25 -0500
Message-ID: <401A8E0E.6090004@techsource.com>
Date: Fri, 30 Jan 2004 12:02:06 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no>
In-Reply-To: <401A33CA.4050104@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NOTE:  My guilt meter for being so far off topic is starting to peg. 
Let's either find a better open forum to discuss this or just take it 
off list.

The only reason I haven't taken it completely off list so far is because 
SOME aspects of this discussion may be relevant to Free Software in 
general.  It is the Linux mentality that spurred this idea and Linux 
users who would be the target market.  But now we're just arguing 
trivialities.

So, the obligatory on-topic comment is simple:  Any Linux-targeted 
graphics chip has to be quite sophistocated and cost-competitive to some 
extent in order for the idea to have any merit whatsoever.  Core Linux 
users on this list are the most qualified to dictate what they would use 
it for.

Unfortunately, the comments I have gotten so far lead me to solutions 
that already exist.



Helge Hafting wrote:

>>
> I run X on an unaccelerated framebuffer (1280x1024 16bit color) every day.

This is you.  How many other people would be happy with this?


> 
> So a good 2D card is trivial - a video signal generator and memory on an 
> AGP bus.

I wouldn't call it 'good', but you're essentially correct.  Mind you, 
you can get the latest S3 chip for $30 or less.  That's well documented, 
a lot faster than a dumb framebuffer, and has VGA built in.

Once you get below a certain level of performance in this open-source 
design, it's no longer worth doing because there are so many low-end 
alternatives that blow it away.

> Let the host processor do software rendering.  Cheap, and I believe this is
> the sort of thing embedded uses might go for when they want to display 
> mostly
> static stuff. (Web-based info kiosk and similiar).

Not cheap.  You can get cheaper with what's already out there!

Let me put it this way:  To make it cheaper than what's out there, 
someone would have to do a run of _millions_ of some minimalist chip 
that sold for like $1.  You could have a graphics card for $5.  THAT 
would make it worth it.  But we would never get the volumes necessary 
for that!

> Add a BIOS rom and you can even see what happens during boot on a pc.

A BIOS ROM doesn't help you if you don't have a VGA core, and a VGA core 
is not a trivial piece of logic.

I like Macs, Suns, and other UNIX workstations because they don't rely 
on this antiquated piece of logic to act as a console.  The chip I 
designed doesn't do VGA, but that doesn't stop it from working nicely as 
a console in a Sun.

> 
> The next step up is 2D acceleration, which is easy enough by sticking a
> generic microprocessor there. Maybe an inexpensive celeron/duron.

<sigh>  Think about the logic area required for that.  For BASIC 2D 
acceleration, the amount of logic required for elementary operations is 
miniscule compared to the logic required for even the simplest of CPU 
cores.  And the dedicated logic would be faster!

> 
> Then there's 3D, and enough of it to play quake.  The first quakes ran
> fine with software rendering and processors that were slow by today's
> standards.  Todays cheap processors are faster - I wonder if putting 2-4 
> of them on the card might be enough. They'd be able to access the memory 
> directly,
> not limited to slow AGP/PCI speeds.  And they'd be able to divide the work
> between them, rendering separate parts of the screen.

My knowledge of 3D graphics is limited to linear algebra and mostly pure 
theory, but I do have SOME clue as to what existing 3D engines are like. 
    The issue of general purpose CPU's versus GPU's has been discussed 
on the web at nauseum, and for what they do, modern GPU's are an order 
of magnitude faster than CPU's at what they do.  And they're less expensive!


> 
> Why bother with 8-bit?

There are reasons.  We can go into them off-list.


> 
> 
> Why VGA?  When you have a _driver_ , you don't need compatibility at all.

BOOT CONSOLE.  You cannot get a boot console on a PC without a VGA core. 
  Once the kernel takes over, you're right, but until then...


> 
> 
> Another reason to drop VGA then - money.


As soon as PC BIOS's don't require it, we can drop it.

