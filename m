Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263142AbRFLTVr>; Tue, 12 Jun 2001 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbRFLTV1>; Tue, 12 Jun 2001 15:21:27 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:5389 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S263160AbRFLTVX>; Tue, 12 Jun 2001 15:21:23 -0400
Message-Id: <200106121921.OAA05009@asooo.flowerfire.com>
Date: Tue, 12 Jun 2001 12:20:58 -0700
From: Ken Brownfield <brownfld@irridia.com>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
Cc: linux-kernel@vger.kernel.org
To: Florin Andrei <florin@sgi.com>
X-Mailer: Apple Mail (2.388)
In-Reply-To: <992371907.26356.3.camel@stantz.corp.sgi.com>
Mime-Version: 1.0 (Apple Message framework v388)
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or you could keep your hardware and try the Intel driver, which seems to 
work fine.  It only works as a module, though.  This might also help 
narrow the issue to a driver vs. card vs. mobo/BIOS/IRQ/APIC/etc issue.

Personally, I've found the EtherExpress hardware and eepro100 driver to 
be flawless in production on both single and dual units, card and 
built-in.  It's the first choice for Linux now that Tulip has somewhat 
faded from view, AFAIC.  I have heard mentioned on this list that the 
Intel driver is necessary for some (older?) cards, however.

OT: does anyone know what the current state of the Tulip driver is and 
if there is good hardware out there?  SMC left Tulip and went through at 
least two other chipsets, so the only Tulip card I could find as of a 
couple of years ago was Digital's.  But it was astonishingly expensive 
and not clearly supported by the Linux driver.

Thanks,
--
Ken.

On Tuesday, June 12, 2001, at 11:51 AM, Florin Andrei wrote:

> On 12 Jun 2001 13:00:41 -0500, John Madden wrote:
>>
>> kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
>> kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
>
> I have the same problem, since a long time, with various 2.2 and 2.4
> kernels running on a i815 motherboard, with on-board eepro100 net card.
>
>> The only solution I've found that works is to reboot, and since this is
>
> For me, it's enough to "ifconfig down" then "ifconfig up" the interface.
>
> I will probably buy another network card, since changing the OS is not
> an option, and Linux seems to not like eepro100 that much... :-/
>
> --
> Florin Andrei
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
