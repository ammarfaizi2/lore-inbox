Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272723AbRIGPhV>; Fri, 7 Sep 2001 11:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272722AbRIGPhN>; Fri, 7 Sep 2001 11:37:13 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:7557 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S272716AbRIGPg6>; Fri, 7 Sep 2001 11:36:58 -0400
Date: Fri, 7 Sep 2001 11:37:17 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: MTD and Adapter ROMs 
In-Reply-To: <18492.999872048@redhat.com>
Message-ID: <Pine.GSO.4.33.0109071132370.1190-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2001, David Woodhouse wrote:
>jfbeam@bluetopia.net said:
>>  Well, just having documentation on how all the spooge in drivers/mtd
>> actually goes together would go along way to helping people use it.
>
>Bah. That takes all the fun out of it.

Well, you explain where the f*** module "cfi" is located.  It took me a
few hours to figure out what module is, in fact, "cfi".


>>  I think it'll be as "simple" as adding the ID to jedec.c.  Load chips/
>> *, maps/hpt-rom (doctored physmap to enable the rom and use it's
>> location), and then see if I can get mtdchar to drive the mess.
>
>Basically right. Once your map driver has successfully probed the chip and
>registered the MTD device, you should be able to open /dev/mtd0 and read,
>write and ioctl(MEMERASE) it. Not necessarily in that order.

The question becomes, what section of the rom should not be erased?  If I
erase the entire 128k and then reset the system before getting a good image
back in there, I'm betting it'll disappear from the bus.  It's already
screwed up to the point it no longer shows up in PCI space as itself -- which
was entertaining to see the bad BIOS post and then not find itself :-)

00:03.0 Class ff80: 11ff:00ff (rev 03)
 (that's supposed to be 1103:0004)

I'm sure the HPT users of the world will love me if I manage to flash the
SOB from linux.

--Ricky


