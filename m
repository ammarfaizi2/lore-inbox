Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751143AbWFEOcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWFEOcs (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWFEOcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:32:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:57489 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751143AbWFEOcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:32:47 -0400
Date: Mon, 5 Jun 2006 16:32:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual via-rhine on EPIA PD6000E
In-Reply-To: <44843EFB.4030704@dgt.com.pl>
Message-ID: <Pine.LNX.4.61.0606051629240.20741@yvahk01.tjqt.qr>
References: <44843EFB.4030704@dgt.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why there are different io adresses in lspci dmesg and ifconfig?

There is a difference between ioports and iomem.

/proc/iomem:
cfffc000-cfffcfff : 0000:00:04.0
  cfffc000-cfffcfff : sis900
/proc/ioports:
d400-d4ff : 0000:00:04.0
  d400-d4ff : sis900
ifconfig:
eth1      Link encap:Ethernet  HWaddr 00:0A:E6:98:ED:D7  
          Interrupt:201 Base address:0xd400 


> Any idea why it's not working???

"Not working" is vague. No packet transmission even though the link is 
active?

> I/O ports at e400 [size=256]
> Memory at de002000 (32-bit, non-prefetchable) [size=256]

^^ ioports vs iomem!


Jan Engelhardt
-- 
