Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272273AbTHNKZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272275AbTHNKZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:25:45 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:5827 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S272273AbTHNKZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:25:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: C99 Initialisers
Date: Thu, 14 Aug 2003 06:25:41 -0400
User-Agent: KMail/1.5.1
Cc: Matthew Wilcox <willy@debian.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
References: <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308140625.41289.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.63.243] at Thu, 14 Aug 2003 05:25:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 August 2003 06:05, Geert Uytterhoeven wrote:
>On Wed, 13 Aug 2003, Jeff Garzik wrote:
>> > On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
>> >>enums are easy  putting direct references would be annoying, but
>> >> I also argue it's potentially broken and wrong to store and
>> >> export that information publicly anyway.  The use of enums
>> >> instead of pointers is practically required because there is a
>> >> many-to-one relationship of ids to board information structs.
>> >
>> > The hard part is that it's actually many-to-many.  The same card
>> > can have multiple drivers.  one driver can support many cards.
>>
>> pci_device_tables are (and must be) at per-driver granularity. 
>> Sure the same card can have multiple drivers, but that doesn't
>> really matter in this context, simply because I/we cannot break
>> that per-driver granularity.  Any solution must maintain
>> per-driver granularity.
>
>Aren't there any `hidden multi-function in single-function' PCI
> devices out there? E.g. cards with a serial and a parallel port?
>
>At least for the Zorro bus, these exist. E.g. the Ariadne card
> contains both Ethernet and 2 parallel ports, so the Ariadne
> Ethernet driver and the (still to be written) Ariadne parallel port
> driver are both drivers for the same Zorro device.

And don't forget the MFC-III, which as 2 more seriels and a parallel 
port, a quite popular card for the big box's.  But I can't, at this 
late date, certify the seriels were 16550 compliant.

>Gr{oetje,eeting}s,
>
>						Geert
>
>P.S. Yes, according to the IBM slides at LKS, m68k is dead ;-)
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
> hacker. But when I'm talking to journalists I just say "programmer"
> or something like that. -- Linus Torvalds
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

