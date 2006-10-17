Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWJQNLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWJQNLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWJQNLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:11:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16013 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750878AbWJQNLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:11:44 -0400
Subject: Re: [patch 1/1] watchdog driver for Digital-Logic MSM-P5XEN PC104
	unit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ggaleotti@interfree.it
Cc: akpm@osdl.org, wim@iguana.be, linux-kernel@vger.kernel.org
In-Reply-To: <20061017123440.4321.qmail@community1.interfree.it>
References: <20061017123440.4321.qmail@community1.interfree.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Oct 2006 14:38:36 +0100
Message-Id: <1161092316.24237.169.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 12:34 +0000, ysgrifennodd ggaleotti@interfree.it:
> +static void
> +wdt_enable(unsigned long data)
> +{
> +	(void)data;
> +
> +	outb(inb(io_base + WDT_OFFSET) & 0xf7, io_base + WDT_OFFSET);
> +}
> +

If you don't need "data" why pass it ?



No locking against parallel close/open
No no-way-out lock implementation
Short many of the standard ioctls it could and should implement (eg
timeout get)

NAK for now although it just needs tidying and expanding out a little to
be a good driver.

