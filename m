Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWFHOfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWFHOfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFHOfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:35:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40426 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932281AbWFHOf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:35:29 -0400
Subject: Re: binary portability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0606081240370.19327@yvahk01.tjqt.qr>
References: <F444CAE5E62A714C9F45AA292785BED30EB9719C@esng11p33001.sg.csfb.com>
	 <Pine.LNX.4.61.0606081240370.19327@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jun 2006 15:50:46 +0100
Message-Id: <1149778246.22124.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-08 am 12:42 +0200, ysgrifennodd Jan Engelhardt:
> >I know that EM64T and AMD64 are ISA compatible, but there could be some 
> >differences in ELF32 between these 2 processor architectures. 
> >
> What differences? (Apart from MMXEXT and SSE2,SSE3)

There are multiple ISA differences that affect ring 0 (kernel code), but
only one nasty that hit user code with early Intel clones. The early
Intel clones didn't implement the prefetch instructions that are
mandatory in x86-64. This broke a few apps early on but they got
workarounds very fast.

If the code is built for the generic instruction set (as is the case
unless you try very hard) then it should be perfect on both.

Alan

