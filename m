Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274734AbRIUB00>; Thu, 20 Sep 2001 21:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274735AbRIUB0R>; Thu, 20 Sep 2001 21:26:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28688 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274734AbRIUB0H>; Thu, 20 Sep 2001 21:26:07 -0400
Subject: Re: Problem: PnP BIOS driver reports outdated information
To: jdthoodREMOVETHIS@yahoo.co.uk (Thomas Hood)
Date: Fri, 21 Sep 2001 02:31:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BAA946F.2D2900AC@yahoo.co.uk> from "Thomas Hood" at Sep 20, 2001 09:14:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kFA6-0006qM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about this: pnpbios functions that scan the device list
> optionally (depending on a flag of some sort, set according to
> whether or not one has an evil BIOS) cause the list to be rebuilt

We can use DMI to figure out if the BIOS is likely to be problematic
A DMI match on Intel or Vaio should cut out most BIOSes that either explode
on boot or have the weird corrupting case.

> I would offer a patch, but I don't know how the aforementioned
> flag should be implemented.

Use the existing vaio flag that is used by the vaio drivers currently -
"is_sony_vaio_laptop"
