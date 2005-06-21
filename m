Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVFUSvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVFUSvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVFUSvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:51:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51364 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261311AbVFUSvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:51:10 -0400
Subject: Re: PATCH: IDE - sensible probing for PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
	 <1119363150.3325.151.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119379587.3325.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 19:46:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  How is the range defined -- is there a way for us to find it?  I'd assume 
> in the absence of a PCI-ISA or PCI-EISA bridge all I/O port addresses 
> belong to PCI.  Otherwise the usual rule of "(addr & 0x300) == 0" applies.  
> Perhaps with the addition of "(addr & ~0xff) != 0" for safety as junk I/O 
> is often not recorded properly in BARs, sigh...

No the low addresses belong to the chipset and motherboard. There is
also magic then for video and IDE legacy port ranges. I suspect your
mips boxen might be a lot cleaner than the PC world.

Alan

