Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276824AbRJKUIk>; Thu, 11 Oct 2001 16:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276831AbRJKUIb>; Thu, 11 Oct 2001 16:08:31 -0400
Received: from cs.columbia.edu ([128.59.16.20]:669 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S276824AbRJKUIP>;
	Thu, 11 Oct 2001 16:08:15 -0400
Date: Thu, 11 Oct 2001 16:08:39 -0400
Message-Id: <200110112008.f9BK8dP20700@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Matthew S. Hallacy" <poptix@techmonkeys.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
In-Reply-To: <20011011114208.N11846@techmonkeys.org>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 11:42:08 -0600, Matthew S. Hallacy <poptix@techmonkeys.org> wrote:

> I currently have the equivalent of 8 of these in my system (Compaq NC3131,
> quad ethernet..)
> 
>  Bus  2, device   4, function  0:
>    Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 5).
>                                           ^^^^

Umm, no, that's actually an 82558 rev B. pci.ids should be updated to 
have "Intel Corporation 8255[7-9]" for this id, because Intel can't make 
up their minds to change the PCI id when they release a new product.

rev 1-3 are 82557, rev 4-5 are 82558, rev 6-8 are 82559.

> it is the same chip, this particular interface is 10mbit/half duplex, and
> all the interfaces transfer 1G+/day (some small files, some larger than 500 megs)
> with no problems, I should note this:
> 
> eth0: OEM i82557/i82558 10/100 Ethernet, DE:AD:BA:BE:CA:FE, IRQ 10.
>  Receiver lock-up bug exists -- enabling work-around.
>  ^^^^^^^^^^^^^^^^^^^^

The OEM probably forgot to initialized the eeprom correctly, because 
82558 rev B and higher don't have this bug. Anyway, the workaround is 
pretty harmless.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
