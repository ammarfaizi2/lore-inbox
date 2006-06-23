Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWFWPI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWFWPI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWFWPI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:08:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5609 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751446AbWFWPI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:08:56 -0400
Subject: Re: PATA driver patch for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606222050.34248.arvidjaar@mail.ru>
References: <1150740947.2871.42.camel@localhost.localdomain>
	 <e79a9e$2kt$1@sea.gmane.org>
	 <1150925002.15275.128.camel@localhost.localdomain>
	 <200606222050.34248.arvidjaar@mail.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 16:24:38 +0100
Message-Id: <1151076278.4549.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-22 am 20:50 +0400, ysgrifennodd Andrey Borzenkov:
> Not really. AFAIK lowest nibble bit has meaning only in DMA mode anyway.

The BIOS docs are fairly confusing on that point referring to one bit as
the "PIO FIFO" bit.

> Anything else I could try to help pinpoint the problem?

Set the controller to support PIO only and see what happens. 

[ie set .udma_mask = 0 i nthe ali_init_one entries]

If that works it implies the DMA tuning may be involved. If that doesn't
change it what happens with a hard disk in the same place ?



