Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTHaVWO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbTHaVWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:22:14 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:38339 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262689AbTHaVWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:22:10 -0400
Subject: Re: Re: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Baudis <pasky@ucw.cz>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831200639.GA573@pasky.ji.cz>
References: <20030831161634.GA695@pasky.ji.cz>
	 <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk>
	 <200308312032.47638.bzolnier@elka.pw.edu.pl>
	 <20030831185706.GB695@pasky.ji.cz>  <20030831200639.GA573@pasky.ji.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062364872.11140.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 22:21:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 21:06, Petr Baudis wrote:
> I did few more experiments, and one strange thing is that /proc/dma does not
> change when turning using_dma on thru hdparm:

IDE DMA is PCI not ISA. It appears your mainboard is dying when both ISA
and PCI DMA occur together. If so you'd want to drop the ESS audiodrive
into PIO mode assuming ALSA supports it (OSS doesnt although I've got
the docs if you care that much).

Can you do another test here - write to a floppy disk while doing IDE
DMA and see if it also hangs.

> (By the way, there are two 'capacity' entries in /proc/ide/ide*/hd*/.)

Curious 8)


