Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWGFDVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWGFDVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWGFDVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:21:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3544
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965121AbWGFDVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:21:16 -0400
Date: Wed, 05 Jul 2006 20:21:41 -0700 (PDT)
Message-Id: <20060705.202141.41653254.davem@davemloft.net>
To: rdunlap@xenotime.net
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17 on SPARC64 compile fails
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060705140224.144cb9bc.rdunlap@xenotime.net>
References: <20060705.113911.112605950.davem@davemloft.net>
	<20060705131539.ba3275d8.rdunlap@xenotime.net>
	<20060705140224.144cb9bc.rdunlap@xenotime.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Randy.Dunlap" <rdunlap@xenotime.net>
Date: Wed, 5 Jul 2006 14:02:24 -0700

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix sparc64 build errors when CONFIG_PCI=n.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

Randy I'll apply this for now, thanks.

The DMA stuff I want to do differently, but that won't happen
for a few days as I'm still on vacation until Friday.

The idea is to move the SBUS stuff over to the of_driver stuff
the sparc64 port has, and thus make it use the dma_*() interfaces
in the SBUS drivers instead of the SBUS specific DMA mapping
calls the drivers use now.

This will allow drivers which support a chip on both PCI and SBUS
(for example sunhme and one of the ATM drivers) to be done much
more cleanly.
