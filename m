Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272668AbRIGOOU>; Fri, 7 Sep 2001 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272670AbRIGOOK>; Fri, 7 Sep 2001 10:14:10 -0400
Received: from t2.redhat.com ([199.183.24.243]:37116 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272668AbRIGOOD>; Fri, 7 Sep 2001 10:14:03 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.33.0109070954400.1190-100000@sweetums.bluetronic.net> 
In-Reply-To: <Pine.GSO.4.33.0109070954400.1190-100000@sweetums.bluetronic.net> 
To: Ricky Beam <jfbeam@bluetopia.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: MTD and Adapter ROMs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Sep 2001 15:14:08 +0100
Message-ID: <18492.999872048@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jfbeam@bluetopia.net said:
>  Well, just having documentation on how all the spooge in drivers/mtd
> actually goes together would go along way to helping people use it.

Bah. That takes all the fun out of it.

> The flash chip is an SST 39SF010.  It will appear somewhere in PCI
> memory space once I reenable the adapter ROM.  It is a JEDEC compilant
> device. I have some code from SST for programming it, but I'd rather
> go the general route instead of the one-shot flash-and-run module. 


>  I think it'll be as "simple" as adding the ID to jedec.c.  Load chips/
> *, maps/hpt-rom (doctored physmap to enable the rom and use it's
> location), and then see if I can get mtdchar to drive the mess.

Basically right. Once your map driver has successfully probed the chip and 
registered the MTD device, you should be able to open /dev/mtd0 and read, 
write and ioctl(MEMERASE) it. Not necessarily in that order.

--
dwmw2


