Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965329AbWI0FKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbWI0FKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbWI0FKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:10:50 -0400
Received: from DSL022.labridge.com ([206.117.136.22]:30739 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S965329AbWI0FKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:10:48 -0400
Subject: Re: Tiny error in printk output for clocksource : a3:<6>Time:
	acpi_pm clocksource has been installed.
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060926215622.f128d9fa.rdunlap@xenotime.net>
References: <9a8748490609261722g557eaeeayc148b5f5d910874d@mail.gmail.com>
	 <20060926173347.04fd66dd.rdunlap@xenotime.net>
	 <200609270236.58148.jesper.juhl@gmail.com>
	 <20060926205415.98b8d95d.rdunlap@xenotime.net>
	 <20060927043239.GA32082@kroah.com>
	 <20060926215235.16c987c0.rdunlap@xenotime.net>
	 <20060926215622.f128d9fa.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 22:10:43 -0700
Message-Id: <1159333843.13196.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 21:56 -0700, Randy Dunlap wrote:
> > Nope, that's part of the NIC's MAC address.  It was split up.
> 
> Sorry.  In this case, it was via-rhine.c:
> 
> 	for (i = 0; i < 5; i++)
> 		printk("%2.2x:", dev->dev_addr[i]);
> 	printk("%2.2x, IRQ %d.\n", dev->dev_addr[i], pdev->irq);
> 
> so it does break the printk()s up itself.

Changing all of those MAC address printks to a single function
could prevent this.

http://www.uwsg.iu.edu/hypermail/linux/net/0602.1/0002.html

