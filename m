Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUJZXKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUJZXKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUJZXKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:10:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62130 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261528AbUJZXKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:10:21 -0400
Date: Tue, 26 Oct 2004 18:33:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Pete Zaitcev <zaitcev@redhat.com>, jgarzik@pobox.com,
       tglx@linutronix.de, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Linux 2.4.28-rc1
Message-ID: <20041026203334.GB29688@logos.cnet>
References: <417E5904.9030107@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417E5904.9030107@ttnet.net.tr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

If you have been suddenly CC'ed to this message please search
your name below - there is something which concerns you.

Replying only to the list, myself and O.Sezer is appreciated.

On Tue, Oct 26, 2004 at 05:02:44PM +0300, O.Sezer wrote:
> There are many lost/forgotten patches posted here on lkml. Since 2.4.28
> is near and 2.4 is going into "deep maintainance" mode soon, I gathered
> a short list of some of them. 

Oh it is hard to bookkeep all of this. I hope people check and resend, but
they dont do that always.

> There, sure, are many more of them,  but here it goes.

Please send'em all. I really appreciate your efforts.

> I think they deserve a re-review and re-consideration for inclusion.
> 
> Regards,
> O. Sezer
> 
> The "list":
> - Dave Jones:  AMD K7 MCE changes backported from 2.6.
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106521456014393&w=2

Should be merged - Dave?

> - David Vrabel: TI CardBus PCI interrupt routing fix
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=108446444125446&w=2

Looks OK to me who dont have a clue about PCMCIA (it only tries
to handle failure case, pretty safe).

rmk, can you take a look at this patch please?

> - Michael Mueller: opti-viper pci-chipset support
>   (have an updated-for-2.4.23+ patch for this)
>   http://marc.theaimsgroup.com/?t=106698970100002&r=1&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106698965700864&w=2

Should be applied - v2.6 also lacks it AFAICS.

> - Michael Frank: Highmem user-friendliness, Shutdown kernel on zone-
>   alignment failure
>   (have an updated patch)
>   http://lkml.org/lkml/2004/2/7/51
>   http://marc.theaimsgroup.com/?t=107619437300052&r=1&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=107619342911564&w=2

This is not really critical _and_ is the BUG is quite rare, thats
why I haven't applied it.

> - Terry Hardie: 8 port SIIG serial card support
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=107765546507508&w=2

This one looks fine - I indeed missed it. Will apply to 2.4.29pre.

Is it present in v2.6 already?

> - Mauricio Martinez/Corey Minyard: fix a problem (multiple reads of
>   the same data) while reading from a CDU31 SONY CD-ROM drive
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106824345717317&w=2

I dont know this code at all and I'm not confident this is safe.

Maybe Jens can take a look at it?

What about v2.6?

> - Roger Luethi: via-rhine, fix force media
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=108507431710317&w=2

Seems fine - Roger?

> - Robert White: usbserial hangup on disconnect
>   http://marc.theaimsgroup.com/?t=108114071200002&r=1&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=108114073600529&w=2
> 
> - V Ganesh: ipaq, hangup tty on usb disconnect
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109049411609590&w=2

Pete, can you take a look at these?

> - David M. Wilson: sis900 Wake-on-LAN support
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=105835662823748&w=2

Jeff?

> - Thomas Gleixner: sis5513 fix for SiS962 chipset
>   http://marc.theaimsgroup.com/?t=109482706500001&r=1&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109482716300929&w=2

Thomas?

> - Eric Sandeen: fix for large direct I/O
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=108197617129880&w=2

Ouch - missed that. Applied. 

> - Geert Uytterhoeven: smb_ops_unix compiler warning
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=107659039710361&w=2

Will apply to 2.4.29pre.

> - David A. Lethe: scsi_scan.c, look for LUNs on XYRATEX RAID subsystems
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=105534062611620&w=2

[marcelo@logos scsi]$ grep XYRA *
scsi_scan.c:    {"XYRATEX", "RS", "*", BLIST_SPARSELUN | BLIST_LARGELUN},

Seems to be present already.

> - Andrey Borzenkov: devfs deadlock on concurrent lookups on
>   non-existent entry
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=105630542714518&w=2

Looks OK, will look again during 2.4.29pre. 

> - Jim Carter: apm.c, Dell Inspiron, limit rate of power status calls
>   (without the star to the asm code)
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=106049225722612&w=2

Dont know the code at all - seems to change generic code.

> - Eric Uhrhane: ATP867X PCI IDE driver: driver for the Acard/Artop PCI
>   ATA/SATA cards (6885[LP]/6896[S]) based on the ATP867{A,B} chips.
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=108198418515134&w=2

Its a new driver - looks OK. 

If the maintainer really cares about why didnt he resend me? v2.6
already has this driver?

> - Jakub Bogusz: missing include in farsync WAN driver
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109376793014054&w=2

Applied.

> - Willy Tarreau: MTU fix for tulip driver
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109130863303540&w=2

Jeff?

> - Ivan Kokshaysky: alpha, make bootimage and make bootpfile failure,
>   boot failure
>   http://marc.theaimsgroup.com/?t=109760337800003&r=1&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109820176212217&w=2

Ivan, can you please resend me this?

> - Sam King: usbserial, down function call being made from an interrupt
>   handler
>   http://marc.theaimsgroup.com/?t=109639065100005&r=1&w=2
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109639053122263&w=2
> 
> - Wolfgang Mues: auerswald-usb, kernel oops at disconnect or reconnect
>   time because of an endless urb resubmit
>   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108465864428213&w=2

Pete, can you please a look.

> - Hilko Bengen: minor error in /proc/isapnp output
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=107607982001162&w=2
>
> - Joshua Kwan:  scripts: Support output of new ld
>   http://marc.theaimsgroup.com/?t=109549085600003&r=1&w=2
> 
> - Joshua Kwan: kbuild: use infobox instead of msgbox and 'sleep 5'
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=109549111519324&w=2

2.4.29pre, all three.

> - Andre Hedrick: ide updates for 2.4.25
>   http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.4.25/

This I really dont know - I'm a complete IDE ignorant. 

Alan, Bart maybe?
