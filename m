Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVK0SaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVK0SaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVK0SaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:30:05 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22870 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751132AbVK0SaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:30:02 -0500
Message-ID: <4389FB44.1080007@tls.msk.ru>
Date: Sun, 27 Nov 2005 21:30:28 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: James Courtier-Dutton <James@superbug.demon.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alternatives to serial console for oops.
References: <4389D63B.4000702@superbug.demon.co.uk> <9a8748490511270909o3e0fdd6erdd17d0b6dbd2c36a@mail.gmail.com>
In-Reply-To: <9a8748490511270909o3e0fdd6erdd17d0b6dbd2c36a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 11/27/05, James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> 
>>Hi,
>>
>>I wish to view the oops that are normally output on the serial port of
>>the PC. The problem I have, is that my PC does not have a serial port.
>>Are there any alternatives for getting that vital oops from the kernel
>>just as it crashes apart from the serial console.
>>Could I get it to use some other interface? e.g. Network interface.
>>Parallel port is also not an option.
> 
> Netconsole (Documentation/networking/netconsole.txt)

I wasn't able to capture an OOPS using netconsole from my
arm-based firewall box -- the output comes too fast and receiving
end only captures some random parts of the OOPS.  I doubt the
receiving box is too slow (2.4GHz Pentium-IV, Intel GigE ethernet),
so it must be the sending end which is trying to generate packets
faster than it's own NIC can transmit them... or something else.

Even "normal" serial console does not work here for this device:
serial port on the box has no flow control, and at 9600 it still
loses some parts of the OOPS, or especially a sysrq-t output
(which is much larger than a typical OOPS).

> Digital camera to take a photo of the screen.

Not all systems has a screen (my router certainly does not).
Also, even for "usual" PC, amount of information in an OOPS
is larger than a screen, so most important part of the OOPS
(several lines on the top) is lost.

> Pen & paper to manually write down the Oops.

The same problem as above with a camera.

This stuff worked perfectly in 2.4 kernel, where it was possible
to use keyboard to scroll to the beginning of an OOPS - only
half a screen and we're here (well, sometimes it is larger,
but Shift-PgUp still worked).  Now, when keyboard does not work
anymore, it's not possible.  As is not possible to reboot the
system using "Three Finger Solution" (Ctrl-Alt-Del) -- some modern
systems does not have "Reset" button, so in order to reboot after
an OOPS, one have to power-cycle the box...

It'd be really nice to have keyboard back in "OOPS mode", as 2.4
had...

Oh well.

/mjt
