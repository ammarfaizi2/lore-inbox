Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTLDNHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLDNHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:07:06 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:46084 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261796AbTLDNHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:07:02 -0500
Message-ID: <3FCF3175.8010302@dcrdev.demon.co.uk>
Date: Thu, 04 Dec 2003 13:07:01 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, should've sent this CC'd to list first time (time to make some 
more coffee :)


-------- Original Message --------
Subject: 	Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Date: 	Thu, 04 Dec 2003 12:38:21 +0000
From: 	Dan Creswell <dan@dcrdev.demon.co.uk>
To: 	b@netzentry.com
References: 	<3FCF25F2.6060008@netzentry.com>



b@netzentry.com wrote:

> Dan Creswell wrote:
>
> Thanks for the input, I'll pass it to the list.
>
You're welcome.

> Most of these Athlon victims are UP users, in fact, I
> believe they are exclusively UP. Does MPS 1.1/1.4 play a role
> in a UP system ever? I dont think the NForce2 chipset,

No, MPS shouldn't matter on a UP system.

> where we are seeing these hard hangs (no ping, no screen,
> no blinking cursor, no toggling the caps lock, nothing) is
> capable of SMP operation.
>
> Now whats interesting is you finger the IDE as a potential
> culprit and think its very low level. Interesting.
>
Well, I actually finger heavy duty disk access - my system locks under 
*SCSI* load (via a PCI-card - the motherboard doesn't have built in 
SCSI), I've not had it happen with my CDROM which is on the IDE 
subsystem.  This leads me to my conclusion in respect of interrupt 
load.  It seems to be an issue with simultaneous interrupts from another 
source but that's subjective......

> By the way, I've had trouble with SMP on a Tyan board with an
> i840 chipset with Linux before - I was never able to resolve
> the issue and had to return the board.
>
Interesting - I've had a number of Tyan boards and this is the first one 
I've had any issues with.  What bugs me more is that 2.4 seems fine 
(caveat 2.4.23-rc5 - wondering if the ACPI changes here are back-ported 
from 2.6) whilst 2.6 is horrid.  This is the only thing changing in the 
system which implies that something different goes on in 2.6 from 2.4 
and that it break's things.  Now it could be 2.6 is using some 
additional features - but the problem (once located) would be simply 
removed by providing an "off" switch to stop usage of those features.

> I've beaten on an Intel SR1300 and SR2300 dual Xeon (aka
> Micron's Netframe 1610/2610 aka Sun 60x / 65x) and never run
> into these hangs with kernels up to 2.4.22. The motherboard
> is an Intel SE7501WV2 .
>
Okay - well my Tyan also runs on kernels up to 2.4.22 no problem - 
useful information though.

Thanks,

Dan.



