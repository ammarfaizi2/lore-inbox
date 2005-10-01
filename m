Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVJAVCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVJAVCn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVJAVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 17:02:43 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:7851 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S1750845AbVJAVCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 17:02:42 -0400
Date: Sat, 1 Oct 2005 18:02:34 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051001210234.GA6397@ime.usp.br>
Mail-Followup-To: Grzegorz Kulewski <kangur@polcom.net>,
	linux-kernel@vger.kernel.org
References: <20050927111038.GA22172@ime.usp.br> <Pine.LNX.4.63.0509271331590.21130@alpha.polcom.net> <204F8530-3DAD-4B20-AC24-2CBA776CC2C2@ime.usp.br> <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.63.0509271425500.21130@alpha.polcom.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Grzegorz. Thank you again for your response.

I haven't been up with linux kernel since I have been experimenting with
my motherboard to see if I could make it stable.

On Sep 27 2005, Grzegorz Kulewski wrote:
> On Tue, 27 Sep 2005, Rogério Brito wrote:
> >The southbridge is a VIA VT82C686.
> 
> I know. I had the same southbridge in my Abit KG7 but I don't know if
> you have version A or version B. I had version B and it has several
> disk problems fixed. For version A there are some workarounds in the
> kernel.

Didn't know that until I saw the following in the dmesg log:

- - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - -
rbrito@dumont:~$ dmesg | grep -i via
Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09
PCI: Disabling Via external APIC routing
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
parport_pc: VIA 686A/8231 detected
parport_pc: VIA parallel port: io=0x378, irq=7
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
- - - - - - - - - - - - - - - - -- - - - - - - - - - - - - - - - - - - -

This also answers the question of my motherboard having the revision A
of the southbridge.

> >Nothing in the logs. No oops, no stack trace, no nothing. :-( Oh, now
> >that
> 
> I don't think that there will be any oops or something like that. But 
> maybe some IDE messages - like failed commands or something. But if there 
> are no such messages then chance is that this is some memory/mb
> problem.

Yes, I found some of them. See below.

> >you mention it, I remember that I also made my Matrox G400 use speed
> >4x. I will try slowing it down to see if there is any influence on
> >what I see.
> 
> Yes, slowing down your graphics card could help.

This is something that I still have not tried, because I lost a good
amount of time using Gold Memory (already mentioned in this thread) to
scan for bad memory.

Even though GM is shareware and only limited its tests to the "quick
tests", it did a *much* better job than memtest86+ finding errors (i.e.,
Gold Memory found errors with my system even when memtest86+ didn't).
Perhaps some of those tests could be included in memtest86+.

Oh, and the fact that we have both memtest86{,+} doesn't help one when
choosing what to use. :-(

> >>I will bet that you have some hardware problem there. You can try to 
> >>remove the 256MB DDR module and turn HIGHMEM off. You can also try to 
> >>check each module separately.
> >
> >I already checked each module separately, but I didn't see any corruption. 
> >I guess that I maybe wasn't paying too much attention. I will try it 
> >again. Thanks for the suggestion.
> 
> Hmm... What did you change before the system started not working?

It had 256MB + 128MB running at PC100 speed (even though both were rated
to work at PC133 speeds).

> Maybe try with only 256MB module installed if that was the working
> configuration...

The catch is that the problem seems to be transient and not that easy to
reproduce. For instance, I had 2 x 512MB + 256MB installed and it
"worked" (meaning that it booted Linux and the system was useable, even
though I saw some problems with md5sums on my system).

Then, just removing the 256MB module made the computer not even POST
anymore! Weird, isn't it? Beyond anything that I can explain yet.

> >It sucks not to be in the US, where things are cheaper. :-(
> 
> Yeah, it sucks. I live in Poland and we have really big prices for 
> computer parts here. :-(

So, you know what I am talking about when I want to keep what I have
just for the moment.


Regards,

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
