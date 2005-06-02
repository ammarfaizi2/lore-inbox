Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFBIU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFBIU4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFBIS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:18:57 -0400
Received: from webapps.arcom.com ([194.200.159.168]:6148 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261225AbVFBISP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:18:15 -0400
Subject: deactivating PXA255 watchdog
From: Ian Campbell <icampbell@arcom.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Thu, 02 Jun 2005 09:18:04 +0100
Message-Id: <1117700284.3063.51.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2005 08:27:15.0843 (UTC) FILETIME=[E2199530:01C5674C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wim,

I think you are the current "watchdog guy", although watchdog doesn't
have a MAINTAINERS entry so I'm looking at bk/lkml history etc and might
be mistaken...

I wrote to the the linux-arm-kernel mailing list recently with a query
because the sa1100_wdt code supports the writing 'V' to deactivate the
watchdog thing, but unfortunately once armed the hardware cannot be
deactivated. 

I was going to produce a patch to remove the 'V' support and it was
suggested by Russell that I should ask for your opinion. Do you have a
preference with regards to offering a warning or error etc if a 'V' is
written?

My original message is below. I have had confirmation that the SA1100
has the same behaviour as PXA2xx from Nico.

Ian.

> The code in drivers/char/watchdog/sa1100_wdt.c has support for the
> standard write a 'V' for a safe shutdown semantics, which clears the
> OIER[E3] bit.
> 
> However, it seems that even if this bit is clear the watchdog reset will
> still occur because OWER[WME] is set (and cannot be cleared).
> 
> Removing this support (perhaps with a warning/error or something) would
> seem to make sense but I wanted to check that the SA1100 behaviour was
> the same since they share the driver before I submitted anything.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

