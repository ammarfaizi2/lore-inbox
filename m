Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbTCORvh>; Sat, 15 Mar 2003 12:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbTCORvh>; Sat, 15 Mar 2003 12:51:37 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:35596 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261481AbTCORvf>; Sat, 15 Mar 2003 12:51:35 -0500
Message-ID: <3E736B28.7050906@aitel.hist.no>
Date: Sat, 15 Mar 2003 19:04:24 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VESA FBconsole driver?
References: <3E71AE11.850.4B46BB7@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
> 
>> > Why is it ugly? IMHO it is very much needed, as it would provide a
>> > mechanism for the kernel to be able to properly restore the screen
>> > if a user land program goes astray.
>>
>>First - the bios isn't always able to fix the screen - the program may
>>have programmed the video hardware in odd ways the bios don't know 
>>about.  Bioses aren't a magic fix.
> 
> 
> Exactly what facts do you base the above statement on? Have you seen this 
> in practice? 
> 
I havent seen it, but the matrox fbdev can do things like turning the
legacy vga and/or bios off.  (it makes sense on secondary cards)
There is the warning that such a card may need a power-off in
order to recover. I.e. ordinary reboot won't help.

> I can tell you from my own personal experience that the BIOS on the 
> graphics card can nearly always restore the screen no matter what state 
> you have put the graphics hardware into.

Great. It wasn't always so in the early 1990's. I once had a pc I had
to turn off whenever the os/2 video driver died.  The pc would restart
using the reset button too, but the screen was black unless I powered
it off.

> Great, assuming you *have* a video driver for the card in question! There 
> are lots of cards that can run on the  VESA fbconsole driver that uses a 
> mode set by the real mode boot loader and can never be changed once the 
> system is up and running. For those particular devices using the BIOS is 
> the *perfect* solution IMHO (if the driver was so easy to write it would 
> already exist).

A driver supporting a modern video card may not be easy - supporting
mode changes _only_ (and use fbconsole for unaccelerated graphichs) 
would likely be easy enough if stupid vendors didn't withold 
information. I cannot imagine a trade secret in the mode change
programming.

> 
> What about it? How do you think Linux brings up the secondary graphics 
> card for dual head operations? It uses the *BIOS*! 

I know. I tried, and it failed. :-/

 > As far as legacy I/O port access
> goes, the BIOS will nearly always do that, but if you only run the BIOS 
> on one card at a time, this is no problem. The PCI spec allows you to 
> selectively enable and disable the I/O port access on any graphics card 
> on the bus as you see fit. So you simply disable the primary card, enable 
> the secondary card and let the BIOS have at it.
> 
That works, but doing all that pci disabling looks like a silly 
limitation to me.  Of course it is necessary if no driver exists, but
then I wouldn't buy that card for a linux machine in the first place.

> No, it wouldn't and you would need to ensure mutually exclusive access to 
> the graphics cards. Simple problem really and since XFree86 is not 
> threaded is not a problem in the existing code anyway, but if it is that 
> is pretty a simple multu-processor programming problem.

What I want is to run two xservers on different screens.  Two processes 
so they may run simultaneosly. And they shouldn't need to wait for each 
other because the hardware itself don't need that.

Helge Hafting

