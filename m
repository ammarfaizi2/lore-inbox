Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274988AbTHATzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274992AbTHATyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:54:21 -0400
Received: from lri.lri.fr ([129.175.15.1]:59553 "EHLO lri.lri.fr")
	by vger.kernel.org with ESMTP id S274988AbTHATxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:53:47 -0400
Date: Fri, 1 Aug 2003 21:53:42 +0200 (MEST)
From: Pierre Letouzey <Pierre.Letouzey@lri.fr>
X-X-Sender: letouzey@lri
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0-test1 refuses to boot on a PC with AMD Athlon XP
 1800+ (another one)
Message-ID: <Pine.GSO.4.44.0308012123510.7082-100000@lri>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all

-----------------------------------------------------------------------
For the impatients: you may want to try kernel option "video=vga16:off"
-----------------------------------------------------------------------

I have also suffered this blank screen probleme after
"Uncompressing Linux... Ok, booting the kernel "
on a Compaq Evo N800c laptop.

After tests and checkings I am pretty sure that in my case:

* It was not related to the misconfiguration issue mentionned in
http://www.codemonkey.org.uk/post-halloween-2.5.txt
Yes, my config file contained:
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_VGA_CONSOLE=y
CONFIG_INPUT=y

* It was not related with the processor type in .config, as suggested by
Herbert Potzl on this list.

I found this "video=vga16:off" solution by chance after heavy mail-list
archive browsing. I do not really understand what this tricks does, but it
certainly makes my laptop boot ok (in old text console, but I don't care).
Seems like something broken concerning my radeon and console graphics in
2.6. I will do some more testing before submitting a proper bug-report.

Hope that this can help some of you...

Pierre Letouzey

Details of my hardware:
 Compaq Evo N800c
 CPU P-IV (M) 1,8Go
 Chipset Intel 82845
 ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500]
 RAM 775 MB
 HDD 30 GB

