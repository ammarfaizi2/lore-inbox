Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWISDUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWISDUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWISDUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 23:20:05 -0400
Received: from web36702.mail.mud.yahoo.com ([209.191.85.36]:17315 "HELO
	web36702.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751604AbWISDUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 23:20:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DaJ1Y01RYZF0IHWMx18Ksnoul946Xfbrupkk4n4gug2LgqMcd89sAaeI2NxVGnklU58tvypybCfPAHBsA8g6PH4BVFIT43RaxxYFxA1VyZ126rih70LZ0Lsli1vDNTp9FHIiDKL+0oXlbmbXfbGC1c2Wm2hJ2wvcJFX8N/asSyU=  ;
Message-ID: <20060919032003.77685.qmail@web36702.mail.mud.yahoo.com>
Date: Mon, 18 Sep 2006 20:20:03 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: linux-kernel@vger.kernel.org
Cc: rmk+lkml@arm.linux.org.uk, drzeus-list@drzeus.cx
In-Reply-To: <450A4BA4.9050409@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at the way to put my driver into the kernel and currently have three ways of doing
it (all of them came up in the thread, already):
1.
Put everything in drivers/misc

2.
Put tifm_core, tifm_7xx1 and tifm_ms (in progress) in drivers/misc, tifm_sd in drivers/mmc

3.
Put everything in drivers/mmc

I'm favoring everything in drivers/mmc, especially if it can be renamed into drivers/flashcards or
something. This way, all flash card drivers will be nicely localized. In this respect, I also
wonder where the MemoryStick driver for Winbond card readers is supposed to go when it enters the
kernel? (Winbond driver is written by people with access to the MemoryStick spec and I'm using it
as reference for my own work, with great utility).


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
