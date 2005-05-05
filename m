Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVEELYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVEELYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVEELYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:24:12 -0400
Received: from open.hands.com ([195.224.53.39]:61630 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S262034AbVEELYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:24:08 -0400
Date: Thu, 5 May 2005 12:32:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: tricky challenge for getting round level-driven interrupt problem: help!
Message-ID: <20050505113254.GI8537@lkcl.net>
References: <20050503215634.GH8079@lkcl.net> <1115171395.14869.147.camel@localhost.localdomain> <20050504205831.GF8537@lkcl.net> <1115243014.19844.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115243014.19844.62.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 10:43:35PM +0100, Alan Cox wrote:

> >  hence the redesign to do alternate read-write-read-write, and making
> >  reads exclusive of writes, etc.
> 
> and maybe even turn the IRQ off and use a timer if its slow and not
> sensitive to latency.. ?

 good suggestion...
 
 been there, tried that [i really _am_ sending to lkml as
 last resort, not first!]

 jiffies equals approx 250? per second?

 baud rate from PIC is determined by GPS - 4800 baud - approx
 600 per second.

 so that'd explain why i only got one character every 3.

 *cold sweat*.  

 i could always use the FIQ, which will be running off the back
 of the Audio DAC/ADC's interrupts, 8khz....

 *shudder*...

