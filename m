Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266528AbUGKJ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUGKJ07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUGKJ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:26:59 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:33168 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266528AbUGKJ04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:26:56 -0400
Subject: Re: Integrated ethernet on SiS chipset doesn't work
From: Jean Francois Martinez <jfm512@free.fr>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0407102141560.5590@chaos>
References: <1089480939.2779.22.camel@agnes>
	 <Pine.LNX.4.53.0407102141560.5590@chaos>
Content-Type: text/plain; charset=utf-8
Message-Id: <1089538014.4690.32.camel@agnes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 11 Jul 2004 11:26:54 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 11/07/2004 à 03:48, Richard B. Johnson a écrit :
> On Sat, 10 Jul 2004, Jean Francois Martinez wrote:
> 
> > I have a friend who owns a computer manufactured by Medion and who
> > sports an MSI motherboard who has a SiS chipset.  The MSI motherboard
> > seems to have ben made specially for Medion since it isn't
> > referenced on MSI's site.  The problems is that the integrated ethernet
> > doesn't work at all under Linux be it with 2.4 or 2.6 kernel.  He can't
> > ping or connect to other boxes.  His ethernet works when he boots
> > Windows.
> >
> > I include the output of lspci
> 
> Tell him to plug a supported ethernet board into a PCI slot
> and forget trying to get the embeded one working. It probably
> isn't "turned on" by some secret incantations to some secret
> registers. If you were to actually find out what was necessary
> to make the board work, then that software won't work with a
> regular SiS setup so nobody will put it into the kernel. The
> usual problem with these imbeded boards is that the vendor
> saved 18 US cents (actually) by not putting in the serial
> EEPROM that enables I/O and sets the IEEE station address
> (the MAC address). If you poke the correct registers, you
> can get it turned ON, then what MAC address would you use?
> 
> Buried in some BAR somewhere is the MAC address. Forget it.
> Get a real ethernet board. Been there, done that.
> 
> 

1) I have been using several integrated ethernets in both Nvidia aand
Intel chipsets with good results

2) The Sis 900 driver is supposed to be _supported_ ie someone is being
paid for fixing problems.  It has the highest maintenance status so
its problems are made to be fixed.

3) The guy is not a hard core Linuxer but someone who is just feeling
water temperature.  He has made from Linux being able to make his
ethernet work THE test for deciding if Linux is usable.

4) If I am bothering to submit to the kernel list it is because I want
the problem fixed for _everyone_ and the road for this doesn't go
through using another board or performing a trick of black magic
(putting the thing in half duplex mode).  It goes through having the
driver fixed and in the interim, since searching for black magic things
is not acceptable in a professional context, getting the driver to use
the black magic thing _by default_.  Now I am very willing to help the
maintainer to find what is wrong with this particular
submodel/motherboard.

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

