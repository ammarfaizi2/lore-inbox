Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVKWRVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVKWRVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 12:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVKWRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 12:21:47 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:20089 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750988AbVKWRVr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 12:21:47 -0500
Date: Wed, 23 Nov 2005 12:21:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Christmas list for the kernel
In-reply-to: <20051123144437.GB7328@ucw.cz>
To: linux-kernel@vger.kernel.org
Message-id: <200511231221.27781.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
 <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
 <20051123144437.GB7328@ucw.cz>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 09:44, Vojtech Pavlik wrote:
>On Tue, Nov 22, 2005 at 04:41:02PM -0500, Jon Smirl wrote:
>> On 11/22/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
>> > > Currently you have to compile most of this stuff into the kernel.
>> >
>> > forgive my ignorance, but whats stopping you from doing this now?
>>
>> It would be better if all of the legacy drivers could exist on
>> initramfs and only be loaded if the actual hardware is present. With
>> the current code someone like Redhat has to compile all of the legacy
>> support into their distribution kernel. That code will be present
>> even on new systems that don't have the hardware.
>>
>> An example of this is that the serial driver is hard coded to report
>> four legacy serial ports when my system physically only has two. I
>> have to change a #define and recompile the kernel to change this.
>
>Interesting. Something goes wrong on your system - I have only a single
>serial port on my machine and it's correctly identified by PnP, with no
>other ports showing up.

Now that you mention it:

In my case, I've been getting 6 serial ports reported at boot time
for most of the 2.6.x kernel series.  They are just repeats of ttyS0 and
ttyS1, including the ttyS0/1 designation.

>From my last dmesg while booting 2.6.14.2:

serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

I had posted about this before, but it was apparently lost in the lists
general noise.   I do use both ports here, and they are working, so I
hadn't pursued it further.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

