Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbTGFH24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 03:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266623AbTGFH24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 03:28:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2976
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266622AbTGFH2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 03:28:55 -0400
Subject: Re: 2.4.21 ServerWorks DMA Bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ryan Mack <lists@mackman.net>
Cc: Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0307050956060.2029@mackman.net>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
	 <87fzllh21i.fsf@gitteundmarkus.de>
	 <Pine.LNX.4.53.0307050956060.2029@mackman.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 08:40:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-05 at 17:58, Ryan Mack wrote:
> That at least explains the lack of DMA, but why does non-DMA IO result in 
> such significant clock skew?

Because for PIO we default to I/O with IRQ blocked (which is needed for
some older 486 type hardware). I really should make setup_pci set the
unmask flag

> Also, does anybody know what the status of the failure to recognize higher 
> UDMA modes on the CSB5 chipset?  Is there a working patch out there?

CSB5 UDMA works properly to all my knowledge

