Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUGKBs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUGKBs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 21:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUGKBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 21:48:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38529 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266474AbUGKBs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 21:48:56 -0400
Date: Sat, 10 Jul 2004 21:48:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jean Francois Martinez <jfm512@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Integrated ethernet on SiS chipset doesn't work
In-Reply-To: <1089480939.2779.22.camel@agnes>
Message-ID: <Pine.LNX.4.53.0407102141560.5590@chaos>
References: <1089480939.2779.22.camel@agnes>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2004, Jean Francois Martinez wrote:

> I have a friend who owns a computer manufactured by Medion and who
> sports an MSI motherboard who has a SiS chipset.  The MSI motherboard
> seems to have ben made specially for Medion since it isn't
> referenced on MSI's site.  The problems is that the integrated ethernet
> doesn't work at all under Linux be it with 2.4 or 2.6 kernel.  He can't
> ping or connect to other boxes.  His ethernet works when he boots
> Windows.
>
> I include the output of lspci

Tell him to plug a supported ethernet board into a PCI slot
and forget trying to get the embeded one working. It probably
isn't "turned on" by some secret incantations to some secret
registers. If you were to actually find out what was necessary
to make the board work, then that software won't work with a
regular SiS setup so nobody will put it into the kernel. The
usual problem with these imbeded boards is that the vendor
saved 18 US cents (actually) by not putting in the serial
EEPROM that enables I/O and sets the IEEE station address
(the MAC address). If you poke the correct registers, you
can get it turned ON, then what MAC address would you use?

Buried in some BAR somewhere is the MAC address. Forget it.
Get a real ethernet board. Been there, done that.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


